import { spawn } from "node:child_process";
import { randomUUID } from "node:crypto";
import { readFile, rename, stat, writeFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import type {
  ExtensionAPI,
  ExtensionCommandContext,
  ExtensionContext,
} from "@earendil-works/pi-coding-agent";

type NpmUpdate = {
  kind: "npm";
  source: string;
  nextSource: string;
  name: string;
  current: string;
  next: string;
};

type GitUpdate = {
  kind: "git";
  source: string;
  nextSource: string;
  name: string;
  current: string;
  next: string;
};

type Update = NpmUpdate | GitUpdate;
type CheckState = { checkedAt?: number };

const DAY = 24 * 60 * 60 * 1000;
const agentDir = dirname(dirname(fileURLToPath(import.meta.url)));
const settingsPath = join(agentDir, "settings.json");
const statePath = join(agentDir, "extension-update-checks.json");
let checking = false;

export default function extensionUpdates(pi: ExtensionAPI) {
  pi.on("session_start", async (event, ctx) => {
    if (event.reason === "startup") await checkForUpdates(ctx);
  });

  pi.registerCommand("extension-updates", {
    description: "Check pinned Pi extensions for stable updates",
    handler: async (_args, ctx) => checkForUpdates(ctx, true),
  });
}

async function checkForUpdates(
  ctx: ExtensionContext | ExtensionCommandContext,
  force = false,
) {
  if (!ctx.hasUI || checking) return;

  const state = await readJson<CheckState>(statePath, {});
  if (!force && state.checkedAt && Date.now() - state.checkedAt < DAY) return;

  checking = true;
  try {
    const sources = await packageSources();
    ctx.ui.notify(
      `Checking ${sources.length} pinned extension${sources.length === 1 ? "" : "s"} for updates…`,
      "info",
    );
    const results = await Promise.all(sources.map(findUpdate));
    await writeJson(statePath, { checkedAt: Date.now() });

    const updates = results.flatMap((result) =>
      result.update ? [result.update] : [],
    );
    const errors = results.flatMap((result) =>
      result.error ? [result.error] : [],
    );
    if (errors.length)
      ctx.ui.notify(
        `Could not check ${errors.length} extension update${errors.length === 1 ? "" : "s"}.`,
        "warning",
      );
    if (updates.length === 0) {
      if (!errors.length)
        ctx.ui.notify(
          `All ${sources.length} pinned extensions are up to date.`,
          "info",
        );
      return;
    }

    const updated: string[] = [];
    for (const update of updates) {
      const approved = await ctx.ui.confirm(
        `Update ${update.name}?`,
        `${update.current} → ${update.next}\n\nPinned source:\n${update.nextSource}`,
      );
      if (!approved) continue;

      await replaceSource(update);
      const result = await runPiUpdate(update.nextSource);
      if (result.code === 0) {
        updated.push(update.name);
      } else {
        await replaceSource({
          ...update,
          source: update.nextSource,
          nextSource: update.source,
        });
        ctx.ui.notify(
          `Could not update ${update.name}: ${result.output || "pi update failed"}`,
          "error",
        );
      }
    }

    if (updated.length) {
      ctx.ui.notify(
        `Updated ${updated.length} extension${updated.length === 1 ? "" : "s"}: ${updated.join(", ")}. Restart Pi to load ${updated.length === 1 ? "it" : "them"}.`,
        "info",
      );
    } else {
      ctx.ui.notify("No extension updates were installed.", "info");
    }
  } catch (error) {
    ctx.ui.notify(`Extension update check failed: ${message(error)}`, "error");
  } finally {
    checking = false;
  }
}

async function packageSources(): Promise<string[]> {
  const settings = await readJson<{ packages?: unknown }>(settingsPath, {});
  return Array.isArray(settings.packages)
    ? settings.packages.filter(
        (source): source is string => typeof source === "string",
      )
    : [];
}

async function findUpdate(
  source: string,
): Promise<{ update?: Update; error?: string }> {
  try {
    if (source.startsWith("npm:"))
      return { update: await findNpmUpdate(source) };
    if (source.startsWith("git:"))
      return { update: await findGitUpdate(source) };
    return {};
  } catch {
    return { error: source };
  }
}

async function findNpmUpdate(source: string): Promise<Update | undefined> {
  const spec = source.slice("npm:".length);
  const at = spec.lastIndexOf("@");
  if (at <= 0) return undefined;

  const name = spec.slice(0, at);
  const current = spec.slice(at + 1);
  if (!isStableVersion(current)) return undefined;

  const response = await fetch(
    `https://registry.npmjs.org/${encodeURIComponent(name)}/latest`,
    {
      headers: { accept: "application/json" },
      redirect: "error",
      signal: AbortSignal.timeout(10_000),
    },
  );
  if (!response.ok)
    throw new Error(`${name}: registry returned ${response.status}`);

  const latest = ((await response.json()) as { version?: unknown }).version;
  if (
    typeof latest !== "string" ||
    !isStableVersion(latest) ||
    compareVersions(latest, current) <= 0
  )
    return undefined;

  return {
    kind: "npm",
    source,
    nextSource: `npm:${name}@${latest}`,
    name,
    current,
    next: latest,
  };
}

async function findGitUpdate(source: string): Promise<Update | undefined> {
  const spec = source.slice("git:".length);
  const at = spec.lastIndexOf("@");
  if (at <= 0) return undefined;

  const repository = spec.slice(0, at);
  const currentCommit = spec.slice(at + 1);
  if (
    !/^[0-9a-f]{40}$/i.test(currentCommit) ||
    !/^[A-Za-z0-9.-]+\/[A-Za-z0-9._/-]+$/.test(repository)
  )
    return undefined;

  const output = await run(
    "git",
    ["ls-remote", "--tags", `https://${repository}.git`],
    undefined,
    10_000,
  );
  if (output.code !== 0) throw new Error(`${repository}: git ls-remote failed`);

  const tags = tagCommits(output.output);
  const current = [...tags].find(([, commit]) => commit === currentCommit)?.[0];
  if (!current || !isStableVersion(current)) return undefined;

  const latest = [...tags.keys()]
    .filter(isStableVersion)
    .sort((a, b) => compareVersions(b, a))[0];
  if (!latest || compareVersions(latest, current) <= 0) return undefined;

  const nextCommit = tags.get(latest);
  if (!nextCommit || !/^[0-9a-f]{40}$/i.test(nextCommit)) return undefined;

  return {
    kind: "git",
    source,
    nextSource: `git:${repository}@${nextCommit}`,
    name: repository.split("/").at(-1) ?? repository,
    current,
    next: latest,
  };
}

function tagCommits(output: string): Map<string, string> {
  const tags = new Map<string, string>();
  for (const line of output.split("\n")) {
    const [commit, ref] = line.split("\t");
    const match = ref?.match(/^refs\/tags\/(v?\d+\.\d+\.\d+)(\^\{\})?$/);
    if (!commit || !match) continue;
    const tag = match[1];
    if (match[2] || !tags.has(tag)) tags.set(tag, commit);
  }
  return tags;
}

function isStableVersion(version: string): boolean {
  return /^v?\d+\.\d+\.\d+$/.test(version);
}

function compareVersions(left: string, right: string): number {
  const leftParts = left.replace(/^v/, "").split(".").map(Number);
  const rightParts = right.replace(/^v/, "").split(".").map(Number);
  for (let index = 0; index < leftParts.length; index++) {
    if (leftParts[index] !== rightParts[index])
      return leftParts[index] - rightParts[index];
  }
  return 0;
}

async function replaceSource(update: Pick<Update, "source" | "nextSource">) {
  const text = await readFile(settingsPath, "utf8");
  const settings = JSON.parse(text) as { packages?: unknown[] };
  if (!Array.isArray(settings.packages))
    throw new Error("No package list in settings.json.");

  const index = settings.packages.indexOf(update.source);
  if (index === -1)
    throw new Error(
      `Pinned source changed before ${update.source} could be updated.`,
    );
  settings.packages[index] = update.nextSource;

  await writeJson(settingsPath, settings, (await stat(settingsPath)).mode);
}

async function runPiUpdate(source: string) {
  return run("pi", ["update", source], { PI_CODING_AGENT_DIR: agentDir });
}

function run(
  command: string,
  args: string[],
  env?: NodeJS.ProcessEnv,
  timeoutMs?: number,
): Promise<{ code: number | null; output: string }> {
  return new Promise((resolve) => {
    const child = spawn(command, args, {
      env: env ? { ...process.env, ...env } : process.env,
      stdio: ["ignore", "pipe", "pipe"],
    });
    let output = "";
    let settled = false;
    const finish = (code: number | null, detail = output.trim()) => {
      if (settled) return;
      settled = true;
      if (timer) clearTimeout(timer);
      resolve({ code, output: detail });
    };
    const timer =
      timeoutMs &&
      setTimeout(() => {
        child.kill("SIGTERM");
        finish(null, `${command} timed out`);
      }, timeoutMs);
    const append = (chunk: Buffer) => {
      output = (output + chunk).slice(-4_000);
    };
    child.stdout.on("data", append);
    child.stderr.on("data", append);
    child.on("error", (error) => finish(null, message(error)));
    child.on("close", (code) => finish(code));
  });
}

async function readJson<T>(path: string, fallback: T): Promise<T> {
  try {
    return JSON.parse(await readFile(path, "utf8")) as T;
  } catch {
    return fallback;
  }
}

async function writeJson(path: string, value: unknown, mode?: number) {
  const temp = `${path}.${randomUUID()}.tmp`;
  await writeFile(temp, `${JSON.stringify(value, null, 2)}\n`, { mode });
  await rename(temp, path);
}

function message(error: unknown): string {
  return error instanceof Error ? error.message : String(error);
}
