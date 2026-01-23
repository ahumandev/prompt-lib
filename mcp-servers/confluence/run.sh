#!/usr/bin/env bash
# Simple wrapper to run the Confluence MCP server in stdio mode.
# It looks for an executable named `mcp-confluence` in the same directory.

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MCP_BIN="$SCRIPT_DIR/mcp-confluence"

# Load .env if present
if [ -f "$SCRIPT_DIR/.env" ]; then
  # shellcheck disable=SC1091
  source "$SCRIPT_DIR/.env"
fi

# Allow overriding the mode; default to stdio to avoid port conflicts
: "${OPENCODE_MCP_MODE:=stdio}"
export OPENCODE_MCP_MODE

if [ ! -x "$MCP_BIN" ]; then
  echo "Error: MCP wrapper not found or not executable: $MCP_BIN" >&2
  echo "Run ./install.sh first to set up the environment." >&2
  exit 2
fi

# Forward any args to the binary
exec "$MCP_BIN" "$@"
