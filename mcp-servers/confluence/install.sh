#!/usr/bin/env bash
# Installer for Confluence MCP server using mcp-atlassian package.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV="$SCRIPT_DIR/.venv"

echo "Setting up Confluence MCP server in $SCRIPT_DIR"

# Check if uv is available
if ! command -v uv &> /dev/null; then
    echo "Error: 'uv' not found. Please install uv first (https://docs.astral.sh/uv/)." >&2
    exit 1
fi

if [ ! -d "$VENV" ]; then
  echo "Creating virtual environment..."
  uv venv "$VENV"
fi

echo "Installing mcp-atlassian package..."
# Use uv to install the package in the venv
uv pip install --python "$VENV/bin/python" mcp-atlassian

echo "Creating wrapper script..."
cat > "$SCRIPT_DIR/mcp-confluence" <<EOF
#!/usr/bin/env bash
SCRIPT_DIR="\$(cd "\$(dirname "\${BASH_SOURCE[0]}")" && pwd)"
VENV="\$SCRIPT_DIR/.venv"

if [ -x "\$VENV/bin/mcp-atlassian" ]; then
  exec "\$VENV/bin/mcp-atlassian" "\$@"
fi

# Fallback to module execution
exec "\$VENV/bin/python" -m mcp_atlassian "\$@"
EOF
chmod +x "$SCRIPT_DIR/mcp-confluence"

echo "Done. Edit .env (copy from sample.env) and run ./run.sh to start the MCP server."
