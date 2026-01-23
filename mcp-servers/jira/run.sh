#!/usr/bin/env bash
# Simple wrapper to run the JIRA MCP server in stdio mode.
# It looks for an executable named `mcp-jira` in the same directory.
# Usage: ./run.sh

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MCP_BIN="$SCRIPT_DIR/mcp-jira"

# Load .env if present (optional)
if [ -f "$SCRIPT_DIR/.env" ]; then
  # shellcheck disable=SC1091
  source "$SCRIPT_DIR/.env"
fi

# Allow overriding the mode; default to stdio to avoid port conflicts
: "${OPENCODE_MCP_MODE:=stdio}"

if [ ! -x "$MCP_BIN" ]; then
  echo "Error: MCP binary not found or not executable: $MCP_BIN" >&2
  echo "Place the official MCP JIRA binary at: $MCP_BIN" >&2
  exit 2
fi

# Export OPENCODE_MCP_MODE to the process environment
export OPENCODE_MCP_MODE

# Forward any args to the binary
exec "$MCP_BIN" "$@"
