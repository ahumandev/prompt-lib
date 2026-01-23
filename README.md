## Tool access

Example agent front-matter:

```yaml
color: "#E01010"
description: Resolve Git merge conflicts.
hidden: false
mode: primary
permission:
  bash:
    "*": ask
    "git add*": allow
    "git diff": allow
    "git log*": allow
    "git status*": allow
    "grep *": allow
tools:
  "*": false
  bash: true
  edit: true
  glob: true
  grep: true
  list: true
  lsp: true
  question: true
  read: true
  todoread: true
  todowrite: true
  mcp-filesystem_read*: true
  mcp-filesystem_list*: true
```

Using `"*": false` followed by an explicit "allow list" (Principle of Least Privilege) is highly recommended for specialized agents. It ensures:
*   **Security**: The agent cannot perform unauthorized actions (like searching the web or modifying cloud resources if those tools were available).
*   **Focus**: The agent is less likely to "hallucinate" using a tool that isn't relevant to its task.
*   **Efficiency**: It reduces the tool definitions the agent has to keep in context.

In this specific example, restricting `mcp-filesystem` to `read*` and `list*` while allowing the native `edit` tool (line 14) is a sound approach: it can see the conflicts and modify them using the native editor integration, but it can't use MCP to move or delete files.

### The syntax `{mcp server name}_{tool name of mcp server}`
 
In OpenCode, MCP tools are identified by the pattern `[mcp-server-id]_[tool-name]`. 
*   **Separator**: The `_` (underscore) is the standard delimiter.
*   **Wildcards**: The use of `*` (as in `mcp-filesystem_read*`) is supported in these configuration files to enable a group of related tools (e.g., `read_file`, `read_multiple_files`, etc.).

For example:

*   **Server**: `mcp-filesystem` → **Tools**: `mcp-filesystem_read_file`, `mcp-filesystem_write_file`, `mcp-filesystem_list_directory`.
*   **Server**: `excel-mcp-server` → **Tools**: `excel-mcp-server_apply_formula`, `excel-mcp-server_read_data_from_excel`.
*   **Server**: `chrome-devtools` → **Tools**: `chrome-devtools_click`, `chrome-devtools_navigate_page`.

The underscore (`_`) acts as the namespace separator between the server identifier and the specific function it provides.

### Namespace Consistency
In OpenCode, standard native tools (like `read`, `write`, `edit`) don't have a prefix because they are built directly into the core agent logic. MCP tools, however, are external "plugins." To prevent name collisions (e.g., if two different MCP servers both provided a `search` tool), the system prefixes them with the server's ID.

### If the `tools` section is omitted entirely:
The agent defaults to **"All Tools"**. 
It inherits the full toolset of the parent assistant (Sisyphus), including all native tools (read, write, edit, etc.) and all connected MCP servers.

### If the `tools` section exists but is empty:
If you define the key but provide no values:
```yaml
tools:
```
This typically defaults to **"No Tools"** (or a very minimal set of system tools like `question`). The system interprets the presence of the `tools` key as an intent to define a specific whitelist.

### Using the `"*"` wildcard (The Safe Way):
To avoid ambiguity, OpenCode agents use the `"*"` key to set the baseline:

*   **Restrictive (Recommended)**:
    ```yaml
    tools:
      "*": false
      read: true
    ```
    *Result: Only `read` is available.*

*   **Permissive (Default if omitted)**:
    ```yaml
    tools:
      "*": true
      mcp-filesystem*: false
    ```
    *Result: All tools are available EXCEPT those from `mcp-filesystem`.*

*   **No `tools` section** = All tools.

### Context management

When an agent do not have access to a tool, e.g. `some_tool: false`, then the agent's context is not cluttered with that tools description. The agent is unaware of the tool even when then MCP server is enabled.
