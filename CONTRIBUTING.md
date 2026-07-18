# Filing Issues

This repository holds no source code — the Zenvara CLI is proprietary. Issues and Discussions are the contribution surface. This guide covers how to file an issue that gets fixed fast.

## Pick the right channel

| You have… | Go to |
|---|---|
| A question, "how do I…", command help | [Discussions](https://github.com/zenvara-platform/cli/discussions) or [docs.zenvara.ai](https://docs.zenvara.ai) |
| A reproducible defect | [Bug report](https://github.com/zenvara-platform/cli/issues/new?template=bug_report.yml) |
| An idea or missing capability | [Feature request](https://github.com/zenvara-platform/cli/issues/new?template=feature_request.yml) |
| A security vulnerability | **security@zenvara.ai** — never a public issue. See [SECURITY.md](SECURITY.md) |

## Before you file

1. Check the [troubleshooting guide](https://docs.zenvara.ai/getting-started/troubleshooting/).
2. Search [existing issues](https://github.com/zenvara-platform/cli/issues?q=is%3Aissue) — including closed ones. Add a 👍 or a comment with your details to an existing issue instead of duplicating it.
3. Upgrade if you can: run `zen cli update` (or reinstall the [latest release](https://github.com/zenvara-platform/cli/releases/latest)) and check whether it already fixes the problem.

## Gather the facts

The bug form asks for these — here's where to find them:

- **Version**: `zen --version`. Quote it verbatim.
- **OS / architecture**: e.g. `Ubuntu 24.04 x64`, `Windows 11 x64`, `macOS 15 arm64`.
- **Transport mode**: are you hitting a remote server (`--host` / saved `host`), a local install (`--dir` / saved `dir`), or the MCP bridge? Include the relevant `zen config list` output (redact the `api-key`).
- **The exact command and its full output**: run with the flags you actually used and paste the complete result, including any error line.

## Format

- **Title**: symptom, not judgement. `zen mcp add --client claude: writes empty config on Windows` beats `mcp broken!!`.
- **One bug per issue.** Two problems = two issues; they get fixed on different timelines.
- **Fenced code blocks** for commands, logs, and JSON — triple backticks with a language tag (`bash`, `text`, `json`). Never screenshots of text.
- **Numbered repro steps**, starting from a state we can reach: "fresh install, run X, observe Y".
- **Expected vs actual**, one line each.

## Redact before posting

Issues are public and permanent. Strip from commands, logs, and screenshots:

- API keys, tokens, passwords, connection strings.
- Internal hostnames, IPs, and server URLs if they matter to you.
- Personal data flowing through your flows.

Replace with placeholders (`<API_KEY>`, `<SERVER_URL>`) rather than deleting lines — context matters.

## After you file

- New issues get the `triage` label automatically. We confirm, reproduce, and re-label — or ask follow-up questions. Issues waiting on your reply that stay silent may be closed as stale; a comment reopens the conversation.
- Fixes ship in releases; the release notes reference the issues they close.
- No promises on timelines for feature requests — 👍 reactions on the issue are what we sort by.
