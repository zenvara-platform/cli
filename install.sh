#!/bin/sh
# zen installer for Linux and macOS.
#
#   curl -fsSL https://raw.githubusercontent.com/zenvara-platform/cli/main/install.sh | sh
#
# ⚠️ THIS FILE IS DEPLOYED TO THE PUBLIC zenvara-platform/cli REPO ROOT as install.sh
#    (canonical source lives here in cli-source). It is version-independent — it
#    resolves the latest release at runtime — so it is deployed once, not per release.
#
# Overrides (env):
#   ZEN_VERSION      pin a version (default: latest), e.g. ZEN_VERSION=1.2.0
#   ZEN_INSTALL_DIR  install location (default: ~/.local/bin — zen's own user dir)
#
# Windows: use Scoop, winget, or Chocolatey instead (see the repo README).
set -eu

REPO="zenvara-platform/cli"
INSTALL_DIR="${ZEN_INSTALL_DIR:-$HOME/.local/bin}"
VERSION="${ZEN_VERSION:-latest}"

fail() { echo "zen: $1" >&2; exit 1; }

# --- detect os / arch → release RID -----------------------------------------
os=$(uname -s)
arch=$(uname -m)
case "$os" in
  Linux)  os_id=linux ;;
  Darwin) os_id=osx ;;
  *) fail "unsupported OS '$os' — on Windows use Scoop, winget, or Chocolatey" ;;
esac
case "$arch" in
  x86_64|amd64)  arch_id=x64 ;;
  aarch64|arm64) arch_id=arm64 ;;
  *) fail "unsupported architecture '$arch'" ;;
esac
asset="zen-${os_id}-${arch_id}.tar.gz"

# --- resolve version --------------------------------------------------------
# Read the tag from the /releases/latest redirect — no GitHub API (rate-limited)
# and no jq required.
if [ "$VERSION" = latest ]; then
  VERSION=$(curl -fsSLI -o /dev/null -w '%{url_effective}' \
    "https://github.com/${REPO}/releases/latest" | sed 's#.*/tag/##')
  # On any resolution failure the effective URL has no /tag/ segment, so sed
  # returns it unchanged (still contains '/'). Reject that, don't build a bad URL.
  case "$VERSION" in
    ''|*/*) fail "could not resolve the latest version — set ZEN_VERSION to pin one" ;;
  esac
fi
base="https://github.com/${REPO}/releases/download/${VERSION}"

# --- download + verify checksum ---------------------------------------------
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

echo "zen: downloading ${asset} (${VERSION})"
curl -fsSL "${base}/${asset}"        -o "$tmp/$asset"       || fail "download failed: ${base}/${asset}"
curl -fsSL "${base}/${asset}.sha256" -o "$tmp/$asset.sha256" || fail "checksum download failed"

echo "zen: verifying checksum"
expected=$(awk '{print $1}' "$tmp/$asset.sha256")
if command -v sha256sum >/dev/null 2>&1; then
  actual=$(sha256sum "$tmp/$asset" | awk '{print $1}')
elif command -v shasum >/dev/null 2>&1; then
  actual=$(shasum -a 256 "$tmp/$asset" | awk '{print $1}')
else
  fail "no sha256 tool found (need sha256sum or shasum)"
fi
[ "$expected" = "$actual" ] || fail "checksum mismatch (expected $expected, got $actual)"

# --- install ----------------------------------------------------------------
tar xzf "$tmp/$asset" -C "$tmp" || fail "extract failed"
mkdir -p "$INSTALL_DIR"
if ! install -m 0755 "$tmp/zen" "$INSTALL_DIR/zen" 2>/dev/null; then
  cp "$tmp/zen" "$INSTALL_DIR/zen" && chmod 0755 "$INSTALL_DIR/zen"
fi

# macOS: clear the Gatekeeper quarantine attribute on the downloaded binary.
[ "$os_id" = osx ] && xattr -d com.apple.quarantine "$INSTALL_DIR/zen" 2>/dev/null || true

echo "zen: installed ${VERSION} to $INSTALL_DIR/zen"

# --- PATH hint --------------------------------------------------------------
case ":$PATH:" in
  *":$INSTALL_DIR:"*) ;;
  *) echo "zen: $INSTALL_DIR is not on your PATH — add it, e.g.:"
     echo "       export PATH=\"$INSTALL_DIR:\$PATH\"" ;;
esac

# Best-effort smoke check (confirms the binary runs on this arch).
"$INSTALL_DIR/zen" --version 2>/dev/null || true
