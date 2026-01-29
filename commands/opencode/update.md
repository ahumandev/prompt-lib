---
description: Update all OpenCode plugins and MCP servers
agent: general
---

Update all OpenCode plugins and MCP servers based on the configuration in opencode.jsonc.

Follow these steps:

1. **Read the ~/.config/opencode/opencode.jsonc and {current dir}/.opencode/opencode.jsonc configuration files** to identify:
   - Plugins listed in the `plugin` array
   - MCP servers defined in the `mcp` object with `type: "local"`

2. **Update each plugin** in the `plugin` array:
   - For npm packages (e.g., `opencode-pty`, `@plannotator/opencode`, `@zenobius/opencode-skillful`):
     - Run: `npm install -g <package>@latest`
   - For packages with version specifiers (e.g., `opencode-antigravity-auth@latest`):
     - Run: `npm install -g <package>@latest`

3. **Update each local MCP server**:
   - For npx-based MCP servers (using `npx` in the command array):
     - These auto-update when run with `-y` flag, no action needed
   - For Python-based MCP servers (using Python virtual environments):
     - Identify the virtual environment path from the command
     - Activate the venv and run: `pip install --upgrade <package-name>`
     - Example for `/home/me/excel-mcp-server/.venv/bin/excel-mcp-server`:
       - `cd /home/me/excel-mcp-server && source .venv/bin/activate && pip install --upgrade excel-mcp-server && deactivate`
   - For Node-based MCP servers (using node or custom paths):
     - Navigate to the directory and run: `npm update`

4. **Report the update status**:
   - List each plugin/MCP server updated
   - Show any errors encountered
   - Suggest restarting OpenCode to apply changes

**Important notes:**
- Only update components that are actually configured in opencode.jsonc
- Handle errors gracefully and continue with remaining updates
- Respect stdio vs HTTP mode preferences (don't modify configuration)
- After all updates, remind the user to restart OpenCode

---
