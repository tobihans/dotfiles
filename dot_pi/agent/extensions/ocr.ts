import { randomUUID } from "node:crypto";
import { existsSync, readFileSync, statSync } from "node:fs";
import { mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { isAbsolute, relative, resolve } from "node:path";
import { parseArgs as parseCliArgs } from "node:util";
import { StringEnum } from "@earendil-works/pi-ai";
import type {
  ExtensionAPI,
  ExtensionContext,
} from "@earendil-works/pi-coding-agent";
import { Type } from "typebox";

const OCR_TIMEOUT_MS = 60_000;
const REVIEW_PACKET_LIMIT = 120_000;
const OCR_REVIEWER_AGENT = "ocr-reviewer";
const SUBAGENT_DELEGATION_REQUEST = "prompt-template:subagent:request";
const SUBAGENT_DELEGATION_RESPONSE = "prompt-template:subagent:response";
const SUBAGENT_DELEGATION_UPDATE = "prompt-template:subagent:update";
const SUBAGENT_DELEGATION_CANCEL = "prompt-template:subagent:cancel";
const SUBAGENT_RUNTIME_AGENT_REGISTER =
  "pi-subagents:runtime-agent-register:v1";
const THINKING_LEVELS = [
  "off",
  "minimal",
  "low",
  "medium",
  "high",
  "xhigh",
  "max",
] as const;
const COMMAND_OPTIONS = [
  "--repo",
  "--from",
  "--to",
  "--commit",
  "--patch",
  "--scan",
  "--background",
  "--background-file",
  "--model",
  "--thinking",
  "--help",
];

type ReviewMode = "workspace" | "range" | "commit" | "patch" | "scan";
type ReviewRequest = {
  mode: ReviewMode;
  repo?: string;
  from?: string;
  to?: string;
  commit?: string;
  patchFile?: string;
  paths?: string[];
  background?: string;
  backgroundFile?: string;
  model?: string;
  thinking?: (typeof THINKING_LEVELS)[number];
};

type OcrPreview = {
  mode: string;
  repository: string;
  reviewable_count: number;
  total_files: number;
  reviewable_files: Array<{
    path: string;
    status: string;
    insertions: number;
    deletions: number;
  }>;
};

type OcrRules = { groups: Array<{ files: string[]; rule: string }> };
type ReviewPacket = {
  request: ReviewRequest;
  repo?: string;
  files: string[];
  preview?: OcrPreview;
  rules: OcrRules["groups"];
  content: string;
  patch: string;
  uiPatchFile?: string;
  temporaryPatchFile?: boolean;
};

type ReviewFinding = {
  source: string;
  scope: "line" | "file" | "general";
  filePath: string;
  lineStart: number;
  lineEnd: number;
  side: "new";
  type: "comment";
  text: string;
  severity?: "important" | "nit";
  reasoning?: string;
  author: "OCR reviewer";
};

type ReviewResult = {
  findings: ReviewFinding[];
  summary: string;
  model: string;
};

type PlannotatorResponse =
  | {
      status: "handled";
      result: {
        approved: boolean;
        feedback?: string;
        annotations?: unknown[];
        exit?: boolean;
      };
    }
  | { status: "unavailable" | "error"; error?: string };

type SubagentDelegationResponse = {
  requestId: string;
  ownerRunId: string;
  nodeId: string;
  status: "completed" | string;
  error?: string;
  model?: string;
  result?: { kind: "structured"; value: unknown };
};

type SubagentDelegationUpdate = {
  requestId: string;
  ownerRunId: string;
  nodeId: string;
  currentTool?: string;
};

type RuntimeAgentRegistration = { dispose(): void };
type RuntimeAgentRegistrationRequest = {
  version: 1;
  name: string;
  definition: Record<string, unknown>;
  result?:
    | { ok: true; registration: RuntimeAgentRegistration }
    | { ok: false; error: Error };
};

function shellWords(input: string): string[] {
  const words: string[] = [];
  let word = "";
  let quote = "";
  let escaped = false;
  for (const char of input.trim()) {
    if (escaped) {
      word += char;
      escaped = false;
      continue;
    }
    if (char === "\\") {
      escaped = true;
      continue;
    }
    if (quote) {
      if (char === quote) quote = "";
      else word += char;
      continue;
    }
    if (char === "'" || char === '"') {
      quote = char;
      continue;
    }
    if (/\s/.test(char)) {
      if (word) {
        words.push(word);
        word = "";
      }
      continue;
    }
    word += char;
  }
  if (escaped) word += "\\";
  if (quote) throw new Error("Unclosed quote.");
  if (word) words.push(word);
  return words;
}

function trim(text: string, limit = REVIEW_PACKET_LIMIT): string {
  return text.length <= limit
    ? text
    : `${text.slice(0, limit)}\n\n[Truncated after ${limit} characters.]`;
}

function commandHelp(): string {
  return [
    "Usage: /ocr [options]",
    "",
    "Scope (one at a time):",
    "  (none)                         current staged, unstaged, and untracked changes",
    "  --from <ref> [--to <ref>]      compare refs (default: HEAD)",
    "  --commit <ref>                 review one commit",
    "  --patch <file.diff>            review a static unified diff",
    "  --scan <path[,path]>           review complete current files",
    "",
    "Options:",
    "  --repo <path> --background <text> --background-file <file.md>",
    "  --model <provider/model> --thinking <level>",
  ].join("\n");
}

function parseCommand(args: string): ReviewRequest | { error: string } {
  try {
    const parsed = parseCliArgs({
      args: shellWords(args),
      options: {
        repo: { type: "string" },
        from: { type: "string" },
        to: { type: "string" },
        commit: { type: "string" },
        patch: { type: "string" },
        scan: { type: "string" },
        background: { type: "string" },
        "background-file": { type: "string" },
        model: { type: "string" },
        thinking: { type: "string" },
        help: { type: "boolean" },
      },
      strict: true,
      allowPositionals: false,
    });
    if (parsed.values.help) return { error: "help" };
    const values = parsed.values as Record<
      string,
      string | boolean | undefined
    >;
    const targets = [
      values.from || values.to,
      values.commit,
      values.patch,
      values.scan,
    ].filter(Boolean);
    if (targets.length > 1) return { error: "Choose only one review scope." };
    if (values.to && !values.from) return { error: "--to requires --from." };
    const thinking = values.thinking;
    if (
      thinking &&
      (typeof thinking !== "string" ||
        !THINKING_LEVELS.includes(thinking as (typeof THINKING_LEVELS)[number]))
    ) {
      return {
        error: `--thinking must be one of: ${THINKING_LEVELS.join(", ")}.`,
      };
    }
    if (
      values.model &&
      (typeof values.model !== "string" || !/^[^/]+\/.+$/.test(values.model))
    ) {
      return { error: "--model must be provider/model." };
    }
    const request: ReviewRequest = {
      mode:
        values.from || values.to
          ? "range"
          : values.commit
            ? "commit"
            : values.patch
              ? "patch"
              : values.scan
                ? "scan"
                : "workspace",
      repo: typeof values.repo === "string" ? values.repo : undefined,
      from: typeof values.from === "string" ? values.from : undefined,
      to: typeof values.to === "string" ? values.to : undefined,
      commit: typeof values.commit === "string" ? values.commit : undefined,
      patchFile: typeof values.patch === "string" ? values.patch : undefined,
      paths:
        typeof values.scan === "string"
          ? values.scan.split(",").filter(Boolean)
          : undefined,
      background:
        typeof values.background === "string" ? values.background : undefined,
      backgroundFile:
        typeof values["background-file"] === "string"
          ? values["background-file"]
          : undefined,
      model: typeof values.model === "string" ? values.model : undefined,
      thinking: thinking as ReviewRequest["thinking"],
    };
    return request;
  } catch (error) {
    return { error: error instanceof Error ? error.message : String(error) };
  }
}

async function run(
  pi: ExtensionAPI,
  program: string,
  args: string[],
  timeout = OCR_TIMEOUT_MS,
): Promise<string> {
  const result = await pi.exec(program, args, { timeout });
  if (result.code !== 0)
    throw new Error(
      result.stderr.trim() ||
        result.stdout.trim() ||
        `${program} exited ${result.code}`,
    );
  return result.stdout;
}

async function repoRoot(
  pi: ExtensionAPI,
  requested: string | undefined,
  cwd: string,
): Promise<string> {
  const repo = resolve(cwd, requested ?? ".");
  return (
    await run(pi, "git", ["-C", repo, "rev-parse", "--show-toplevel"])
  ).trim();
}

function repoFile(repo: string, path: string): string {
  const file = resolve(repo, path);
  const fromRepo = relative(repo, file);
  if (!fromRepo || fromRepo.startsWith("..") || isAbsolute(fromRepo))
    throw new Error(`Path escapes the repository: ${path}`);
  return file;
}

function ocrScopeArgs(request: ReviewRequest, repo: string): string[] {
  const args = ["--format", "json", "--repo", repo];
  if (request.from) args.push("--from", request.from);
  if (request.to) args.push("--to", request.to);
  if (request.commit) args.push("--commit", request.commit);
  if (request.background) args.push("--background", request.background);
  if (request.backgroundFile)
    args.push("--background-file", repoFile(repo, request.backgroundFile));
  return args;
}

async function ocrMetadata(
  pi: ExtensionAPI,
  request: ReviewRequest,
  repo: string,
): Promise<{ preview: OcrPreview; rules: OcrRules["groups"] }> {
  const preview = JSON.parse(
    await run(pi, "ocr", [
      "delegate",
      "preview",
      ...ocrScopeArgs(request, repo),
    ]),
  ) as OcrPreview;
  const files = preview.reviewable_files.map((file) => file.path);
  if (!files.length) return { preview, rules: [] };
  const rules = JSON.parse(
    await run(pi, "ocr", [
      "delegate",
      "rule",
      ...ocrScopeArgs(request, repo),
      "--",
      ...files,
    ]),
  ) as OcrRules;
  return { preview, rules: rules.groups ?? [] };
}

function fullFilePatch(path: string, source: string): string {
  const lines = source.split("\n");
  const count = source.endsWith("\n") ? lines.length - 1 : lines.length;
  return [
    `diff --git a/${path} b/${path}`,
    "new file mode 100644",
    "--- /dev/null",
    `+++ b/${path}`,
    `@@ -0,0 +1,${count} @@`,
    ...lines.slice(0, count).map((line) => `+${line}`),
  ].join("\n");
}

async function workspacePatch(
  pi: ExtensionAPI,
  repo: string,
  files: Array<{ path: string; status: string }>,
): Promise<string> {
  let tracked: string;
  try {
    tracked = await run(pi, "git", [
      "-C",
      repo,
      "diff",
      "--no-ext-diff",
      "--binary",
      "--unified=40",
      "HEAD",
    ]);
  } catch {
    tracked = await run(pi, "git", [
      "-C",
      repo,
      "diff",
      "--cached",
      "--no-ext-diff",
      "--binary",
      "--unified=40",
    ]);
    tracked += await run(pi, "git", [
      "-C",
      repo,
      "diff",
      "--no-ext-diff",
      "--binary",
      "--unified=40",
    ]);
  }
  const untracked = files
    .filter((file) => file.status === "added")
    .flatMap((file) => {
      const fullPath = repoFile(repo, file.path);
      return existsSync(fullPath) && statSync(fullPath).isFile()
        ? [fullFilePatch(file.path, readFileSync(fullPath, "utf8"))]
        : [];
    });
  return [tracked, ...untracked].filter(Boolean).join("\n");
}

async function diffContent(
  pi: ExtensionAPI,
  request: ReviewRequest,
  repo: string,
  preview: OcrPreview,
): Promise<string> {
  if (request.mode === "workspace")
    return workspacePatch(pi, repo, preview.reviewable_files);
  if (request.mode === "range")
    return run(pi, "git", [
      "-C",
      repo,
      "diff",
      "--no-ext-diff",
      "--binary",
      "--unified=40",
      `${request.from}..${request.to ?? "HEAD"}`,
    ]);
  if (request.mode === "commit")
    return run(pi, "git", [
      "-C",
      repo,
      "show",
      "--format=",
      "--no-ext-diff",
      "--binary",
      "--unified=40",
      request.commit!,
    ]);
  return "";
}

function rulesText(groups: OcrRules["groups"]): string {
  return groups
    .map((group) => `Files: ${group.files.join(", ")}\n${group.rule}`)
    .join("\n\n---\n\n");
}

async function buildPacket(
  pi: ExtensionAPI,
  request: ReviewRequest,
  cwd: string,
): Promise<ReviewPacket> {
  if (request.mode === "patch") {
    const patchFile = resolve(cwd, request.patchFile!);
    if (!existsSync(patchFile) || !statSync(patchFile).isFile())
      throw new Error(`Patch file not found: ${request.patchFile}`);
    const patch = readFileSync(patchFile, "utf8");
    return {
      request,
      files: [],
      rules: [],
      patch,
      uiPatchFile: patchFile,
      content: trim(`Static patch review.\n\nDiff:\n${patch}`),
    };
  }
  const repo = await repoRoot(pi, request.repo, cwd);
  if (request.mode === "scan") {
    const paths = request.paths!.map((path) => path.replace(/^\.\//, ""));
    const rules = JSON.parse(
      await run(pi, "ocr", [
        "delegate",
        "rule",
        ...ocrScopeArgs({ ...request, mode: "workspace" }, repo),
        "--",
        ...paths,
      ]),
    ) as OcrRules;
    const source = paths.map((path) => {
      const fullPath = repoFile(repo, path);
      if (!existsSync(fullPath) || !statSync(fullPath).isFile())
        throw new Error(`Not a readable file inside the repository: ${path}`);
      return { path, content: readFileSync(fullPath, "utf8") };
    });
    const patch = source
      .map((file) => fullFilePatch(file.path, file.content))
      .join("\n");
    return {
      request,
      repo,
      files: paths,
      rules: rules.groups ?? [],
      patch,
      content: trim(
        `OCR full-file scan\n\nRules:\n${rulesText(rules.groups ?? [])}\n\nSource:\n${source.map((file) => `--- ${file.path}\n${file.content}`).join("\n\n")}`,
      ),
    };
  }
  const { preview, rules } = await ocrMetadata(pi, request, repo);
  const patch = await diffContent(pi, request, repo, preview);
  const background = request.backgroundFile
    ? readFileSync(repoFile(repo, request.backgroundFile), "utf8")
    : request.background;
  return {
    request,
    repo,
    preview,
    rules,
    patch,
    files: preview.reviewable_files.map((file) => file.path),
    content: trim(
      [
        `OCR review target: ${preview.mode} (${preview.reviewable_count}/${preview.total_files} files)`,
        background ? `Background:\n${background}` : "",
        `Selected files:\n${preview.reviewable_files.map((file) => `${file.status.padEnd(9)} ${file.path} (+${file.insertions}/-${file.deletions})`).join("\n") || "(none)"}`,
        `Resolved OCR rules:\n${rulesText(rules) || "(none)"}`,
        `Diff:\n${patch || "(no diff content)"}`,
      ]
        .filter(Boolean)
        .join("\n\n"),
    ),
  };
}

function reviewPrompt(packet: ReviewPacket): string {
  return [
    "You are an isolated, read-only code-review agent. Review only this OCR-selected scope and its rules.",
    "You may use the provided read, grep, find, ls, and bash tools for repository context. Do not edit files, run mutating commands, access the network, or call other agents.",
    "Report only actionable defects introduced by the target. Do not speculate or propose edits. Every line finding must cite an added/new-file line in the supplied diff.",
    'Your final answer must be JSON only: {"summary": string, "findings": [{"scope": "line"|"file"|"general", "filePath": string, "lineStart": number, "lineEnd": number, "text": string, "severity": "important"|"nit", "reasoning": string}]}. Use [] when there are no findings.',
    packet.content,
  ].join("\n\n");
}

function parseFindings(
  text: string,
  source: string,
): { findings: ReviewFinding[]; summary: string } {
  const json = text
    .trim()
    .replace(/^```json\s*/i, "")
    .replace(/\s*```$/, "");
  let result: unknown;
  try {
    result = JSON.parse(json);
  } catch {
    throw new Error("Review model did not return valid JSON.");
  }
  if (
    !result ||
    typeof result !== "object" ||
    !Array.isArray((result as { findings?: unknown }).findings)
  )
    throw new Error("Review model JSON must contain a findings array.");
  const summary =
    typeof (result as { summary?: unknown }).summary === "string"
      ? (result as { summary: string }).summary
      : "";
  const findings = (result as { findings: unknown[] }).findings.flatMap(
    (item): ReviewFinding[] => {
      if (!item || typeof item !== "object") return [];
      const finding = item as Record<string, unknown>;
      const scope =
        finding.scope === "line" ||
        finding.scope === "file" ||
        finding.scope === "general"
          ? finding.scope
          : undefined;
      const text = typeof finding.text === "string" ? finding.text.trim() : "";
      if (!scope || !text) return [];
      if (scope === "general")
        return [
          {
            source,
            scope,
            filePath: "",
            lineStart: 0,
            lineEnd: 0,
            side: "new",
            type: "comment",
            text,
            author: "OCR reviewer",
            ...(finding.severity === "important" || finding.severity === "nit"
              ? { severity: finding.severity }
              : {}),
            ...(typeof finding.reasoning === "string"
              ? { reasoning: finding.reasoning }
              : {}),
          },
        ];
      if (
        typeof finding.filePath !== "string" ||
        !finding.filePath ||
        (scope === "line" &&
          (!Number.isInteger(finding.lineStart) ||
            !Number.isInteger(finding.lineEnd)))
      )
        return [];
      return [
        {
          source,
          scope,
          filePath: finding.filePath,
          lineStart: scope === "line" ? (finding.lineStart as number) : 0,
          lineEnd: scope === "line" ? (finding.lineEnd as number) : 0,
          side: "new",
          type: "comment",
          text,
          author: "OCR reviewer",
          ...(finding.severity === "important" || finding.severity === "nit"
            ? { severity: finding.severity }
            : {}),
          ...(typeof finding.reasoning === "string"
            ? { reasoning: finding.reasoning }
            : {}),
        },
      ];
    },
  );
  return { findings, summary };
}

const REVIEW_RESULT_SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: ["summary", "findings"],
  properties: {
    summary: { type: "string" },
    findings: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: [
          "scope",
          "filePath",
          "lineStart",
          "lineEnd",
          "text",
          "severity",
          "reasoning",
        ],
        properties: {
          scope: { enum: ["line", "file", "general"] },
          filePath: { type: "string" },
          lineStart: { type: "integer" },
          lineEnd: { type: "integer" },
          text: { type: "string" },
          severity: { enum: ["important", "nit"] },
          reasoning: { type: "string" },
        },
      },
    },
  },
};

let reviewerRegistration: RuntimeAgentRegistration | undefined;
let reviewerRegistrationError: string | undefined;

function registerReviewerAgent(pi: ExtensionAPI): void {
  reviewerRegistration?.dispose();
  reviewerRegistration = undefined;
  reviewerRegistrationError = undefined;
  const request: RuntimeAgentRegistrationRequest = {
    version: 1,
    name: OCR_REVIEWER_AGENT,
    definition: {
      description: "Isolated, read-only OCR code reviewer",
      systemPrompt:
        "Review only the assigned OCR scope. Do not modify files, use the network, or delegate work. Return the requested structured findings.",
      tools: ["read", "grep", "find", "ls", "bash"],
      systemPromptMode: "replace",
      inheritProjectContext: false,
      inheritGlobalContext: false,
      inheritSkills: false,
      defaultContext: "fresh",
      defaultAcceptance: false,
      extensions: [],
    },
  };
  pi.events.emit(SUBAGENT_RUNTIME_AGENT_REGISTER, request);
  if (!request.result) {
    reviewerRegistrationError = "pi-subagents is not installed or ready.";
  } else if (!request.result.ok) {
    reviewerRegistrationError = request.result.error.message;
  } else {
    reviewerRegistration = request.result.registration;
  }
}

function delegateReview(
  pi: ExtensionAPI,
  packet: ReviewPacket,
  ctx: ExtensionContext,
  signal?: AbortSignal,
): Promise<SubagentDelegationResponse> {
  if (!reviewerRegistration)
    return Promise.reject(
      new Error(reviewerRegistrationError ?? "OCR reviewer is unavailable."),
    );
  const requestId = randomUUID();
  const ownerRunId = `ocr:${ctx.sessionManager.getSessionId()}`;
  const nodeId = `review:${requestId}`;
  const statusKey = `ocr-review:${requestId}`;
  return new Promise((resolve, reject) => {
    const disposeResponse = pi.events.on(
      SUBAGENT_DELEGATION_RESPONSE,
      (data) => {
        const response = data as Partial<SubagentDelegationResponse>;
        if (
          response.requestId !== requestId ||
          response.ownerRunId !== ownerRunId ||
          response.nodeId !== nodeId
        )
          return;
        cleanup();
        resolve(response as SubagentDelegationResponse);
      },
    );
    const disposeUpdate = pi.events.on(SUBAGENT_DELEGATION_UPDATE, (data) => {
      const update = data as Partial<SubagentDelegationUpdate>;
      if (
        update.requestId === requestId &&
        update.ownerRunId === ownerRunId &&
        update.nodeId === nodeId
      )
        ctx.ui.setStatus(
          statusKey,
          update.currentTool
            ? `OCR reviewer: ${update.currentTool}`
            : "OCR reviewer is working…",
        );
    });
    const cancel = () => {
      pi.events.emit(SUBAGENT_DELEGATION_CANCEL, {
        requestId,
        ownerRunId,
        nodeId,
      });
    };
    const cleanup = () => {
      disposeResponse();
      disposeUpdate();
      signal?.removeEventListener("abort", cancel);
      ctx.ui.setStatus(statusKey, undefined);
    };
    if (signal?.aborted) {
      cleanup();
      reject(new Error("OCR review cancelled."));
      return;
    }
    signal?.addEventListener("abort", cancel, { once: true });
    pi.events.emit(SUBAGENT_DELEGATION_REQUEST, {
      requestId,
      ownerRunId,
      nodeId,
      agent: OCR_REVIEWER_AGENT,
      task: reviewPrompt(packet),
      context: "fresh",
      cwd: packet.repo ?? ctx.cwd,
      model: packet.request.model ?? "inherit",
      thinking: packet.request.thinking ?? ctx.thinkingLevel,
      result: { kind: "structured", schema: REVIEW_RESULT_SCHEMA },
    });
  });
}

async function runReviewAgent(
  pi: ExtensionAPI,
  packet: ReviewPacket,
  ctx: ExtensionContext,
  signal?: AbortSignal,
): Promise<ReviewResult> {
  const response = await delegateReview(pi, packet, ctx, signal);
  if (response.status !== "completed")
    throw new Error(response.error ?? `OCR reviewer ${response.status}.`);
  if (response.result?.kind !== "structured")
    throw new Error("OCR reviewer did not return structured findings.");
  const model = response.model ?? packet.request.model ?? "inherit";
  const parsed = parseFindings(
    JSON.stringify(response.result.value),
    `OCR ${model}`,
  );
  return { ...parsed, model };
}

async function makePatchFile(packet: ReviewPacket): Promise<string> {
  if (packet.uiPatchFile) return packet.uiPatchFile;
  const dir = await mkdtemp(`${tmpdir()}/ocr-`);
  const file = resolve(dir, "review.diff");
  await writeFile(file, packet.patch);
  packet.uiPatchFile = file;
  packet.temporaryPatchFile = true;
  return file;
}

async function cleanupPatch(packet: ReviewPacket): Promise<void> {
  if (packet.temporaryPatchFile && packet.uiPatchFile)
    await rm(resolve(packet.uiPatchFile, ".."), {
      recursive: true,
      force: true,
    });
}

function annotationsFor(review: ReviewResult): ReviewFinding[] {
  return [
    ...review.findings,
    {
      source: `OCR ${review.model}`,
      scope: "general",
      filePath: "",
      lineStart: 0,
      lineEnd: 0,
      side: "new",
      type: "comment",
      text: `OCR delegated review completed with ${review.model}. ${review.findings.length} finding(s).${review.summary ? `\n\n${review.summary}` : ""}`,
      author: "OCR reviewer",
    },
  ];
}

function requestPlannotator(
  pi: ExtensionAPI,
  packet: ReviewPacket,
  review: ReviewResult,
): Promise<PlannotatorResponse> {
  if (
    !pi.getCommands().some((command) => command.name === "plannotator-review")
  ) {
    return Promise.resolve({
      status: "unavailable",
      error: "Install and enable @plannotator/pi-extension.",
    });
  }
  return new Promise((respond) => {
    pi.events.emit("plannotator:request", {
      requestId: randomUUID(),
      action: "code-review",
      payload: {
        cwd: packet.repo,
        patchFile: packet.uiPatchFile,
        annotations: annotationsFor(review),
      },
      respond,
    });
  });
}

function findingsFeedback(review: ReviewResult): string {
  const findings = review.findings.length
    ? review.findings
        .map(
          (finding) =>
            `- ${finding.scope === "line" ? `${finding.filePath}:${finding.lineStart}` : finding.filePath || "general"}: ${finding.text}`,
        )
        .join("\n")
    : "- No actionable findings.";
  return [
    `OCR review (${review.model}):`,
    review.summary ? `Summary: ${review.summary}` : "",
    findings,
  ]
    .filter(Boolean)
    .join("\n");
}

function reviewFeedback(
  review: ReviewResult,
  human: {
    approved: boolean;
    feedback?: string;
    annotations?: unknown[];
    exit?: boolean;
  },
): string {
  const decision = human.exit
    ? "Plannotator: closed without submission."
    : human.approved
      ? "Plannotator: approved."
      : "Plannotator: feedback submitted.";
  return [
    findingsFeedback(review),
    "",
    decision,
    human.feedback?.trim() ? `\nHuman feedback:\n${human.feedback}` : "",
  ]
    .filter(Boolean)
    .join("\n");
}

async function review(
  pi: ExtensionAPI,
  request: ReviewRequest,
  ctx: ExtensionContext,
  humanReview: boolean,
  signal?: AbortSignal,
): Promise<string> {
  const packet = await buildPacket(pi, request, ctx.cwd);
  if (!packet.files.length && request.mode !== "patch")
    throw new Error("OCR found no reviewable files.");
  ctx.ui.notify(
    `OCR is reviewing ${packet.files.length || ""} file(s) with a separate Pi agent…`,
    "info",
  );
  const result = await runReviewAgent(pi, packet, ctx, signal);
  if (!humanReview) return findingsFeedback(result);
  await makePatchFile(packet);
  try {
    const response = await requestPlannotator(pi, packet, result);
    if (response.status !== "handled")
      throw new Error(response.error ?? response.status);
    return reviewFeedback(result, response.result);
  } finally {
    await cleanupPatch(packet);
  }
}

export default function (pi: ExtensionAPI) {
  let modelChoices: string[] = [];
  pi.on("session_start", (_event, ctx) => {
    modelChoices = ctx.modelRegistry
      .getAvailable()
      .map((model) => `${model.provider}/${model.id}`);
    registerReviewerAgent(pi);
  });
  pi.on("session_shutdown", () => {
    reviewerRegistration?.dispose();
    reviewerRegistration = undefined;
  });

  pi.registerCommand("ocr", {
    description:
      "Run an isolated OCR-delegated review, then open its findings in Plannotator",
    getArgumentCompletions: (prefix) => {
      const modelMatch = prefix.match(/(?:^|\s)--model\s+([^\s]*)$/);
      if (modelMatch)
        return modelChoices
          .filter((model) => model.startsWith(modelMatch[1]!))
          .map((value) => ({ value, label: value }));
      const thinkingMatch = prefix.match(/(?:^|\s)--thinking\s+([^\s]*)$/);
      if (thinkingMatch)
        return THINKING_LEVELS.filter((level) =>
          level.startsWith(thinkingMatch[1]!),
        ).map((value) => ({ value, label: value }));
      const current = prefix.trim().split(/\s+/).at(-1) ?? "";
      return COMMAND_OPTIONS.filter((option) => option.startsWith(current)).map(
        (value) => ({ value, label: value }),
      );
    },
    handler: async (args, ctx) => {
      const request = parseCommand(args ?? "");
      if ("error" in request) {
        ctx.ui.notify(
          request.error === "help"
            ? commandHelp()
            : `${request.error}\n\n${commandHelp()}`,
          request.error === "help" ? "info" : "error",
        );
        return;
      }
      void review(pi, request, ctx, true).then(
        (feedback) => pi.sendUserMessage(feedback, { deliverAs: "followUp" }),
        (error) =>
          ctx.ui.notify(
            `OCR review failed: ${error instanceof Error ? error.message : String(error)}`,
            "error",
          ),
      );
    },
  });

  pi.registerTool({
    name: "ocr",
    label: "OCR Review",
    description:
      "Run a read-only, OCR-scoped review in an isolated Pi agent. Returns findings directly unless humanReview is true.",
    promptSnippet: "Run an isolated OCR code review",
    promptGuidelines: [
      "Use ocr for read-only review findings during the session.",
      "Set humanReview to true only when the user should review the findings in Plannotator.",
    ],
    parameters: Type.Object({
      mode: StringEnum([
        "workspace",
        "range",
        "commit",
        "patch",
        "scan",
      ] as const),
      repo: Type.Optional(Type.String()),
      from: Type.Optional(Type.String()),
      to: Type.Optional(Type.String()),
      commit: Type.Optional(Type.String()),
      patchFile: Type.Optional(Type.String()),
      paths: Type.Optional(Type.Array(Type.String())),
      background: Type.Optional(Type.String()),
      backgroundFile: Type.Optional(Type.String()),
      model: Type.Optional(
        Type.String({
          description:
            "Pi model as provider/model; defaults to the active model.",
        }),
      ),
      thinking: Type.Optional(StringEnum(THINKING_LEVELS)),
      humanReview: Type.Optional(
        Type.Boolean({
          description:
            "Open Plannotator for a human review after the AI review. Defaults to false.",
        }),
      ),
    }),
    async execute(_toolCallId, params, _signal, _onUpdate, ctx) {
      const feedback = await review(
        pi,
        params,
        ctx,
        params.humanReview ?? false,
        _signal,
      );
      return {
        content: [{ type: "text", text: feedback }],
        details: {
          mode: params.mode,
          humanReview: params.humanReview ?? false,
        },
      };
    },
  });
}
