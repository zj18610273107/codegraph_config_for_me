#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="${CG_BIN_DIR:-$HOME/.local/bin}"

ALIASES=(
  cg-init
  cg-status
  cg-list
  cg-files
  cg-explore
  cg-callers
  cg-callees
  cg-impact
  cg-query
  cg-node
  cg-sync
  cg-version
)

mkdir -p "$BIN_DIR"
ln -sfn "$REPO_ROOT/bin/cg" "$BIN_DIR/cg"

for name in "${ALIASES[@]}"; do
  ln -sfn "cg" "$BIN_DIR/$name"
done

echo "Installed cg commands in $BIN_DIR"

if command -v codex >/dev/null 2>&1; then
  if codex mcp get codegraph >/dev/null 2>&1; then
    codex mcp remove codegraph >/dev/null
  fi

  codex mcp add codegraph \
    --env CODEGRAPH_DIR=build \
    --env CODEGRAPH_WATCH_DEBOUNCE_MS=5000 \
    -- codegraph serve --mcp

  echo "Restored Codex MCP server: codegraph"
else
  echo "codex command not found"
  echo "Apply the fragment manually: $REPO_ROOT/codex/mcp-codegraph.toml"
fi

echo "Restart Codex, then run: cg-init"
