// dcg — Destructive Command Guard for Pi
// Validates bash commands through dcg before execution.
// Runs BEFORE rtk so denied commands never reach the rewriter.
//
// https://github.com/Dicklesworthstone/destructive_command_guard
//
// Exit code contract for `dcg --robot test`:
//   0           Allowed
//   1           Denied (JSON on stdout carries reason, rule_id, explanation, …)
//   >=3         dcg error (config/parse/IO) → fail closed (block with error)
//
// Design: fail-closed. If dcg can't validate, commands are denied.
// Override with DCG_DISABLED=1 to bypass entirely.

import {
  isToolCallEventType,
  type ExtensionAPI,
} from "@earendil-works/pi-coding-agent";

const DCG_TIMEOUT_MS = 5_000;
const DCG_BIN = process.env.DCG_BIN ?? "dcg";
const DCG_DISABLED = process.env.DCG_DISABLED === "1";

async function checkCommand(
  pi: ExtensionAPI,
  command: string,
  signal?: AbortSignal,
): Promise<{ deny: boolean; reason: string }> {
  const result = await pi.exec(DCG_BIN, ["--robot", "test", command], {
    timeout: DCG_TIMEOUT_MS,
    signal,
  });

  switch (result.code) {
    case 0:
      return { deny: false, reason: "" };
    case 1:
      // Denied — the raw JSON carries reason, rule_id, explanation, severity, …
      return { deny: true, reason: result.stdout };
    default:
      // exit >= 3 means dcg had an error (config/parse/IO) — fail closed.
      return {
        deny: true,
        reason:
          result.stderr ||
          result.stdout ||
          `dcg exited with code ${result.code}`,
      };
  }
}

export default async function (pi: ExtensionAPI) {
  if (DCG_DISABLED) {
    console.warn(
      "[dcg] DCG_DISABLED=1 — extension disabled, commands pass through",
    );
    return;
  }

  // Probe dcg version at load time.
  let dcgAvailable = false;
  try {
    const ver = await pi.exec(DCG_BIN, ["--version"], {
      timeout: DCG_TIMEOUT_MS,
    });
    dcgAvailable = ver.code === 0;
    if (!dcgAvailable) console.warn("[dcg] dcg binary not found in PATH");
  } catch {
    console.warn("[dcg] dcg binary not found in PATH");
  }

  pi.on("tool_call", async (event, ctx) => {
    try {
      if (!isToolCallEventType("bash", event)) return;

      const cmd = event.input.command;
      if (typeof cmd !== "string" || cmd.trim() === "") return;

      if (!dcgAvailable) {
        return {
          block: true,
          reason: `dcg not found in PATH (${DCG_BIN}). All bash commands are blocked until the guard is installed. Set DCG_DISABLED=1 to bypass.`,
        };
      }

      const { deny, reason } = await checkCommand(pi, cmd, ctx.signal);
      if (deny) return { block: true, reason };
    } catch (err: any) {
      // Fail-closed: block on unexpected extension errors too.
      return {
        block: true,
        reason: `dcg extension error: ${err?.message ?? err}`,
      };
    }
  });
}
