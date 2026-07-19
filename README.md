# Zenvara CLI (`zen`)

**One binary to install, run, and operate Zenvara.**

[![Latest release](https://img.shields.io/github/v/release/zenvara-platform/cli?label=release)](https://github.com/zenvara-platform/cli/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/zenvara-platform/cli/total)](https://github.com/zenvara-platform/cli/releases)
[![Docs](https://img.shields.io/badge/docs-docs.zenvara.ai-blue)](https://docs.zenvara.ai)
[![Website](https://img.shields.io/badge/website-zenvara.ai-blue)](https://zenvara.ai)

`zen` is the cross-platform command-line tool for [Zenvara](https://zenvara.ai). It manages the full lifecycle of a Zenvara deployment — install, service/IIS hosting, updates, rollbacks — and transparently forwards flow commands (`run`, `flows`, `logs`, …) to a local installation or a remote server. It also registers the **MCP bridge** that connects Claude Code, Gemini, and OpenCode to a running Zenvara.

It ships as a single self-contained native executable (~8 MB, NativeAOT) — no .NET runtime, no dependencies to install.

---

## About this repository

> **This repository does not contain the CLI's source code.** Zenvara is a proprietary product. This repo is the public home for:
>
> - 📦 **Releases** — download the latest `zen` binaries from the [**Releases**](../../releases) tab.
> - 🐞 **Issues** — report bugs and track fixes in [**Issues**](../../issues).
> - 💬 **Discussions** — ask questions and share patterns in [**Discussions**](../../discussions).

## Install

Binaries come from the [latest release](https://github.com/zenvara-platform/cli/releases/latest). Every archive ships a `.sha256` sidecar — verify it before installing. Each archive contains a single executable (`zen` / `zen.exe`).

Supported platforms: `linux-x64`, `linux-arm64`, `win-x64`, `osx-x64`, `osx-arm64`.

### Linux

#### Quick install (recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/zenvara-platform/cli/main/install.sh | sh
```

Detects your architecture, verifies the checksum, and installs `zen` to `~/.local/bin`. Pin a version with `ZEN_VERSION=1.2.0` or change the target with `ZEN_INSTALL_DIR`.

#### Manual

```bash
# Download zen-linux-x64.tar.gz (or -arm64) and its .sha256, then:
sha256sum -c zen-linux-x64.tar.gz.sha256
tar xzf zen-linux-x64.tar.gz
chmod +x zen
./zen path install            # add zen to your PATH (~/.local/bin)
zen --version
```

### Windows

#### Scoop (recommended)

```powershell
scoop bucket add zenvara https://github.com/zenvara-platform/cli
scoop install zen
zen --version
```

Scoop shims `zen` onto your PATH, so `zen path install` is unnecessary. Upgrade later with `scoop update zen`.

#### Manual

```powershell
# Download zen-win-x64.zip, then verify against the .sha256:
Get-FileHash zen-win-x64.zip -Algorithm SHA256
Expand-Archive zen-win-x64.zip -DestinationPath C:\zen
C:\zen\zen.exe path install   # copies zen and adds it to your user Path
zen --version
```

### macOS

#### Quick install (recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/zenvara-platform/cli/main/install.sh | sh
```

Detects Apple Silicon vs Intel, verifies the checksum, clears the Gatekeeper quarantine, and installs `zen` to `~/.local/bin`. Pin a version with `ZEN_VERSION=1.2.0` or change the target with `ZEN_INSTALL_DIR`.

#### Manual

```bash
# Download zen-osx-arm64.tar.gz (Apple Silicon) or zen-osx-x64.tar.gz (Intel), then:
tar xzf zen-osx-arm64.tar.gz
xattr -dr com.apple.quarantine zen   # clear Gatekeeper quarantine
chmod +x zen
./zen path install
zen --version
```

Use `zen path status` to check the install location and `zen cli update` to keep the installed copy in sync. Full command reference is in the [official documentation](https://docs.zenvara.ai).

## Quick start

```bash
# Point zen at a Zenvara server (or a local install with --dir)
zen config set host http://server:5000
zen login                       # mints and persists an API key

# Run flows — anything zen doesn't own is forwarded to Zenvara
zen flows
zen run my-flow -p key=value
zen logs <invocation-id>

# Register the MCP bridge for your AI client
zen mcp add --client claude
```

For more information, refer to the [official documentation site](https://docs.zenvara.ai).

## Reporting an issue

The full guide — channel selection, required facts, format, redaction — is in [CONTRIBUTING.md](CONTRIBUTING.md). The short version:

1. Check the [docs](https://docs.zenvara.ai) and the [troubleshooting guide](https://docs.zenvara.ai/getting-started/troubleshooting/).
2. Search [existing issues](https://github.com/zenvara-platform/cli/issues) to avoid duplicates.
3. File with the facts listed in [CONTRIBUTING.md](CONTRIBUTING.md) — `zen --version`, OS/arch, the exact command and output.

> ⚠️ **Security issues:** please do **not** open a public issue for suspected vulnerabilities. Email **security@zenvara.ai** instead. See [SECURITY.md](SECURITY.md).

## License

Zenvara is commercial, proprietary software. © Zenvara. All rights reserved. Use is governed by your license agreement; binaries published here are distributed under those terms. See [LICENSE.md](LICENSE.md).
