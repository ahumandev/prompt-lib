#!/usr/bin/env bash
# Simple wrapper to run the SonarQube MCP server in stdio mode.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MCP_BIN="$SCRIPT_DIR/mcp-sonarqube"

# Load .env if present
if [ -f "$SCRIPT_DIR/.env" ]; then
  # shellcheck disable=SC1091
  source "$SCRIPT_DIR/.env"
fi

# Allow overriding the mode; default to stdio
: "${OPENCODE_MCP_MODE:=stdio}"

if [ ! -x "$MCP_BIN" ]; then
  echo "Error: MCP binary not found or not executable: $MCP_BIN" >&2
  exit 2
fi

# Export variables for the docker container
export SONAR_TOKEN
export SONAR_HOST_URL
export OPENCODE_MCP_MODE

# Forward any args to the binary
exec "$MCP_BIN" "$@"
