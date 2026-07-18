# Security Policy

## Reporting a vulnerability

Please do **not** open a public issue for suspected security vulnerabilities.

Email **security@zenvara.ai** with:

- A description of the issue and its impact.
- Steps to reproduce, or a proof of concept.
- The CLI version affected (`zen --version`).
- Your environment (OS, architecture, install method).

We will acknowledge your report within **3 business days** and keep you informed of progress. Please give us a reasonable window to release a fix before any public disclosure.

## Supported versions

Security fixes land in the latest stable release. Check the [Releases](https://github.com/zenvara-platform/cli/releases) page and upgrade with `zen cli update` or by reinstalling the latest binary.

## Verifying downloads

Every release archive ships with a `.sha256` checksum file. Verify before installing:

```bash
sha256sum -c zen-linux-x64.tar.gz.sha256
```

```powershell
# Windows: compare against the value in the .sha256 file
Get-FileHash zen-win-x64.zip -Algorithm SHA256
```
