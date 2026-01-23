# Confluence MCP Server for Opencode

This directory contains helper files to run a Confluence MCP server for Opencode using the `mcp-atlassian` package.

## Files
- `install.sh`: Sets up a virtual environment and installs the `mcp-atlassian` package.
- `mcp-confluence`: Wrapper that calls the installed MCP server from the virtual environment.
- `run.sh`: Main wrapper that loads environment variables from `.env` and runs the server in stdio mode.
- `sample.env`: Template for environment variables.

## Installation
1. Ensure `uv` is installed on your system.
2. Run the installer:
   ```bash
   ./install.sh
   ```
3. Copy `sample.env` to `.env`:
   ```bash
   cp sample.env .env
   ```
4. Edit `.env` and fill in your Confluence URL and Personal Access Token (PAT).

## Usage
Start the server in stdio mode (preferred for Opencode):
```bash
./run.sh
```

## Configuration for Opencode
In your `opencode.jsonc` (usually in `~/.config/opencode/opencode.jsonc`), add the server:

```jsonc
"mcpServers": {
  "confluence": {
    "command": "/home/me/.config/opencode/mcp-servers/confluence/run.sh",
    "args": []
  }
}
```

## Notes
- `OPENCODE_MCP_MODE` is set to `stdio` by default in `run.sh`.
- If you are on a corporate network with SSL inspection, you might need to set `CONFLUENCE_SSL_VERIFY=false` in your `.env`.
