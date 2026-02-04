# Opencode Locations

- Opencode configuration file location: `~/.config/opencode/opencode.jsonc` or `{current dir}/.opencode/opencode.jsonc`
- agents: `~/.config/opencode/agents` or `{current dir}/.opencode/agents`
- commands: `~/.config/opencode/commands` or `{current dir}/.opencode/commands`
- mcp: `~/.config/opencode/mcp-servers` or `{current dir}/.opencode/mcp-servers`
- skills: `~/.config/opencode/skills` or `{current dir}/.opencode/skills`
- Global agent instructions: `~/.config/opencode/AGENTS.md` or `{current dir}/AGENTS.md`

## Agent Properties

The YAML frontmatter of an agent's `.md` file (stored in `~/.config/opencode/agents/` or `.opencode/agents/`) supports the following properties:

| Property      | Type    | Description                                                                                 |
| :------------ | :------ | :------------------------------------------------------------------------------------------ |
| `color`       | String  | Hex color code for the agent (e.g., `"#E01010"`).                                           |
| `description` | String  | A brief description of the agent's purpose and usage.                                       |
| `hidden`      | Boolean | If `true`, the agent is hidden from the UI and agent lists.                                 |
| `mode`        | String  | The operational mode of the agent. See [Operational Modes](#operational-modes) for details. |
| `permission`  | Object  | Granular tool permissions (`allow`, `ask`, `deny`) mapped to command/path patterns.         |
| `tools`       | Object  | A whitelist/blacklist of tools available to the agent (e.g., `"*": false`).                 |
| `temperature` | Number  | LLM sampling temperature for the agent's responses (typically `0.0` to `1.0`).              |

### Best Practices for Agent Descriptions

The `description` field in the frontmatter is critical for subagent discovery and routing. Follow these guidelines to ensure the main agent correctly identifies when to use a subagent:

- **Ideal Length**: **20–50 words** (1–2 concise sentences).
- **Trigger-Action Syntax**: Use "Use this when..." or "Useful for..." to provide a clear logical hook.
- **Action-Oriented Verbs**: Use precise verbs (e.g., *Refactor, Audit, Provision, Reconcile*) instead of vague ones (e.g., *Handle, Process, Manage*).
- **Clear Boundaries**: Explicitly state the agent's expertise, domain, and specific tool access (e.g., "Specialized in Kubernetes manifest optimization using websearch").
- **Exclude Polite Filler**: Avoid phrases like "This agent is designed to..." or "I am here to help...".
- **Contrastive Language**: If an agent has a similar role to another, use explicit exclusions (e.g., "Exclusively for Git operations; do not use for general code generation").

Ensure the rest of the file content is preserved.

## Operational Modes

| Mode       | Description                                                                                                                                                                 |
| :--------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `primary`  | A standalone agent capable of initiating and managing a full conversation thread. Used for top-level tasks and build-in system agents.                                      |
| `subagent` | A specialized agent intended to be called by another agent (e.g., via the `task` tool). These are optimized for specific sub-tasks like exploration, web searching, or git. |

## Agent Prompts in Conversations

Each agent has a specific prompt that defines its identity and behavior. This prompt is injected into the LLM as a **system prompt** on every interaction. 

If you switch agents during a conversation (e.g., using the Tab key in the opencode CLI), the system prompt for the next turn is replaced with the new agent's instructions. The previous agent's instructions are discarded for that turn, but the **conversation history** (user messages, assistant responses, and tool results) is maintained, allowing the new agent to continue where the last one left off.

## Agent Discovery

Opencode automatically discovers agents defined in the standard locations:

- `~/.config/opencode/agents/*.md`
- `{project root}/.opencode/agents/*.md`

### Automatic Mapping

If an agent is used (e.g., via a subagent call) and is not explicitly configured in `opencode.jsonc`, Opencode will look for a markdown file with the same name in the `agents/` directory.

### When to use `prompt` in `opencode.jsonc`

The `prompt` property in `opencode.jsonc` is **optional** if the file follows the `{name}.md` convention in the `agents/` folder. It is required only if:

1. The markdown file name does not match the agent name.
2. The file is located outside the standard `agents/` directory.
3. You are explicitly configuring a built-in agent to use a custom prompt file.

## Configuration Precedence

In Opencode, agent properties can be defined in both the agent's `.md` file (YAML frontmatter) and the `opencode.jsonc` configuration file. The precedence rules are:

1.  **`opencode.jsonc` overrides `.md` files**: Properties defined in `opencode.jsonc` under the `agent` key take precedence over properties defined in the agent's markdown frontmatter.
2.  **Merging**: If a property is an object (like `tools` or `permission`), the keys from `opencode.jsonc` are merged with the keys from the `.md` file, with `opencode.jsonc` keys taking priority in case of conflicts.

This allows you to define base agent behavior in the markdown file while overriding specific settings (like the model or tool access) globally or per-environment.

## Tool access

### Supported Permissions

Permissions control what an agent is allowed to do. They can be set to "allow", "ask", or "deny".

| Permission            | Description                                                                                            | Plugin / MCP                | 
|-----------------------|:-------------------------------------------------------------------------------------------------------|:----------------------------|
| bash                  | Running shell commands. Matches the command string.                                                    | build-in                    |
| chrome_*              | Chrome MCP server.                                                                                     | chrome-devtools-mcp         |                                                                                
| codesearch            | Searching for code patterns across the web or large repositories.                                      | build-in                    |
| context7_*            | Context7 MCP server.                                                                                   | context7-mcp                |
| doom_loop             | Safety guard triggered when the same tool call repeats 3+ times with identical input.                  | build-in                    |
| edit                  | All file modifications. Covers edit, write, patch, and multiedit tools. Matches against the file path. | build-in                    |
| excel_*               | Excel MCP server.                                                                                      | excel-mcp-server            |
| external_directory    | Safety guard triggered when a tool accesses paths outside the project root.                            | build-in                    |
| filesystem_*          | Filesystem MCP server.                                                                                 | mcp-filesystem              |
| git_git_add           | Stages files for commit.                                                                               | mcp-server-git              |
| git_git_branch        | Lists branches (local/remote/all).                                                                     | mcp-server-git              |
| git_git_checkout      | Switches branches.                                                                                     | mcp-server-git              |
| git_git_commit        | Creates a new commit with a message.                                                                   | mcp-server-git              |
| git_git_create_branch | Creates a new branch.                                                                                  | mcp-server-git              |
| git_git_diff          | Compares branches or commits.                                                                          | mcp-server-git              |
| git_git_diff_staged   | Shows staged changes.                                                                                  | mcp-server-git              |
| git_git_diff_unstaged | Shows unstaged changes.                                                                                | mcp-server-git              |
| git_git_log           | Shows commit history/logs.                                                                             | mcp-server-git              |
| git_git_reset         | Unstages all changes.                                                                                  | mcp-server-git              |
| git_git_show          | Shows contents of a specific revision.                                                                 | mcp-server-git              |
| git_git_status        | Shows the working tree status.                                                                         | mcp-server-git              |
| glob                  | Finding files using glob patterns. Matches the pattern.                                                | build-in                    |
| google_search         | Performing web searches using Google Search (via opencode-antigravity-auth).                           | `opencode-antigravity-auth` |
| grep                  | Searching file contents with regex. Matches the regex pattern.                                         | build-in                    |
| list                  | Listing directory contents. Matches the directory path.                                                | build-in                    |
| lsp                   | Running Language Server Protocol queries.                                                              | build-in                    |
| plan_enter            | Entering the structured planning mode.                                                                 | build-in                    |
| plan_exit             | Exiting the planning mode and submitting a plan.                                                       | build-in                    |
| pty_*                 | Interactive PTY management (`spawn`, `read`, `write`, `list`, `kill`).                                 | opencode-pty                |
| question              | Asking the user for clarification or input via the UI.                                                 | build-in                    |
| read                  | Reading file contents. Matches against the file path.                                                  | build-in                    |
| skill                 | Loading specialized instructions/patterns. Matches the skill name.                                     | build-in                    |
| skill_*               | Skill management and discovery (`use`, `find`, `resource`).                                            | @zenobius/opencode-skillful |
| task                  | Launching subagents. Matches the subagent name/type.                                                   | build-in                    |
| todoread              | Reading the project's todo list.                                                                       | build-in                    |
| todowrite             | Adding or updating items in the todo list.                                                             | build-in                    |
| webfetch              | Fetching content from a URL. Matches the URL.                                                          | build-in                    |
| websearch             | Performing web searches (e.g., via DuckDuckGo or Exa).                                                 | open-websearch              

### Example Agent

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
  filesystem_read*: true
  filesystem_list*: true
```

This file was copied from /home/me/.config/opencode/README.md

## Commands

Commands are custom prompts that can be executed in the TUI using the `/` prefix. They are automatically discovered in:
- `~/.config/opencode/commands/*.md`
- `{project root}/.opencode/commands/*.md`

### Variable Substitution

Opencode provides several ways to inject dynamic data into command templates:

- **`$ARGUMENTS`**: Injects the entire string of text provided after the command name.
- **Positional Parameters (`$1`, `$2`, etc.)**: Accesses specific arguments by their position. The last placeholder in a template will "swallow" all remaining arguments.
- **File Inlining (`@filename`)**: Reads and includes the full content of the specified file (e.g., `@src/main.ts`).
- **Shell Command Output (`!'command'`)**: Injects the output of a bash command directly into the prompt (e.g., `!'git status'`).
- **Project Path (`${path}`)**: Injects the absolute path to the current project worktree.

Note: Substitution works when a command is invoked via the terminal or when an agent calls the `task()` tool with a `/` prefixed command.

### Communication Flow

Communication between agents is strictly **synchronous and hierarchical**:

- **One-Way Command**: Parent agents send a prompt to a subagent and wait for the final result.
- **Blocking**: While a subagent is working, the parent agent is paused and cannot respond to queries from the subagent.
- **No Callbacks**: Subagents cannot "ask the parent" for clarification mid-task. They can, however, use the `question` tool to ask the **human user** for information before continuing.
- **Clarification Loop**: If a subagent cannot complete its task due to ambiguous instructions, it should return that feedback in its final output. The parent agent can then refine the instruction and call the subagent again (using the same `session_id` to maintain context).
