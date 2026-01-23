JIRA MCP Server for Opencode

This directory contains helper files to run a JIRA MCP server for Opencode.

Files
- `mcp-jira` (not included): the MCP server executable. Place the official binary here and make it executable.
- `run.sh`: wrapper that prefers stdio mode and forwards arguments to the binary.
- `.env.sample`: example environment variables. Copy to `.env` and fill with your credentials.
- `install.sh`: optional script with commands to download the server (not guaranteed to work for all systems).

Install steps
1. Obtain the official MCP JIRA server binary (prebuilt release or build from source). The upstream repo is usually published on GitHub; search for "opencode mcp jira" or refer to the Opencode MCP server docs: https://opencode.ai/docs/mcp-servers/
2. Place the binary at: `~/.config/opencode/mcp-servers/jira/mcp-jira` and make it executable: `chmod +x ~/.config/opencode/mcp-servers/jira/mcp-jira`.
3. Copy `.env.sample` to `.env` and fill `JIRA_HOST`, `JIRA_EMAIL`, and `JIRA_API_TOKEN`.
4. Start the server (stdio mode):

   ```bash
   cd ~/.config/opencode/mcp-servers/jira
   ./run.sh
   ```

Notes
- The wrapper sets `OPENCODE_MCP_MODE=stdio` by default to avoid HTTP port conflicts and allow multiple Opencode instances.
- Do not commit secrets. Keep `.env` local and protected.
- If you want the MCP to run as an HTTP server instead, set `OPENCODE_MCP_MODE=http` and configure a port in the binary's config (details depend on the MCP implementation).

Troubleshooting
- If the wrapper reports "mcp binary not found", ensure the executable is present and executable.
- If you prefer automatic installation, modify `install.sh` with the correct upstream release URL and run it. The script in this directory is an optional convenience and may require edits for your OS.
