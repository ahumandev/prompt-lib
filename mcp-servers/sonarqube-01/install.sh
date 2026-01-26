#!/usr/bin/env bash
# Installer for SonarQube MCP (Node.js/npx based)
set -euo pipefail

echo "Checking for Node.js..."
if command -v npx >/dev/null 2>&1; then
    echo "npx is available."
else
    echo "Error: npx not found. Please install Node.js." >&2
    exit 1
fi

echo "Done. Edit .env and run ./run.sh to start the MCP server in stdio mode."
