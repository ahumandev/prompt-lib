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

## Operational Modes

| Mode       | Description                                                                                                                                                                 |
| :--------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `primary`  | A standalone agent capable of initiating and managing a full conversation thread. Used for top-level tasks and build-in system agents.                                      |
| `subagent` | A specialized agent intended to be called by another agent (e.g., via the `task` tool). These are optimized for specific sub-tasks like exploration, web searching, or git. |

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

This allows you to define base agent behavior in the markdown file while overriding specific settings (like the model or tool access) globally or per-environment in the main configuration file.

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

Using `"*": false` followed by an explicit "allow list" (Principle of Least Privilege) is highly recommended for specialized agents. It ensures:

- **Security**: The agent cannot perform unauthorized actions (like searching the web or modifying cloud resources if those tools were available).
- **Focus**: The agent is less likely to "hallucinate" using a tool that isn't relevant to its task.
- **Efficiency**: It reduces the tool definitions the agent has to keep in context.

In this specific example, restricting `mcp-filesystem` to `read*` and `list*` while allowing the native `edit` tool (line 14) is a sound approach: it can see the conflicts and modify them using the native editor integration, but it can't use MCP to move or delete files.

### The syntax `{mcp server name}_{tool name of mcp server}`

In OpenCode, MCP tools are identified by the pattern `[mcp-server-id]_[tool-name]`.

- **Separator**: The `_` (underscore) is the standard delimiter.
- **Wildcards**: The use of `*` (as in `mcp-filesystem_read*`) is supported in these configuration files to enable a group of related tools (e.g., `read_file`, `read_multiple_files`, etc.).

For example:

- **Server**: `filesystem` → **Tools**: `filesystem_read_file`, `filesystem_write_file`, `filesystem_list_directory`.
- **Server**: `excel` → **Tools**: `excel_apply_formula`, `excel_read_data_from_excel`.
- **Server**: `chrome` → **Tools**: `chrome_click`, `chrome_navigate_page`.

The underscore (`_`) acts as the namespace separator between the server identifier and the specific function it provides.

### Search Tools and Providers

Opencode distinguishes between generic web fetching and systematic web searching. Search capabilities are typically provided by MCP servers or plugins.

| Tool Category      | Prefix / Name   | Source                      | Description                                                                           |
| :----------------- | :-------------- | :-------------------------- | :------------------------------------------------------------------------------------ |
| **MCP Search**     | `websearch_*`   | `open-websearch` MCP        | Multi-engine search (Bing, DuckDuckGo, etc.) and specialized scrapers (GitHub, CSDN). |
| **Plugin Search**  | `google_search` | `opencode-antigravity-auth` | High-quality web search using Google Search with citations.                           |
| **Built-in Fetch** | `webfetch`      | Native Opencode             | Retrieves the content of a specific URL in markdown or text format.                   |

> [!NOTE]
> The `websearch` permission in an agent's configuration governs access to these external search capabilities. The `websearch` agent itself is a specialized subagent that orchestrates these tools to perform deep research.

### Namespace Consistency

In OpenCode, standard native tools (like `read`, `write`, `edit`) don't have a prefix because they are built directly into the core agent logic. MCP tools, however, are external "plugins." To prevent name collisions (e.g., if two different MCP servers both provided a `search` tool), the system prefixes them with the server's ID.

### If the `tools` section is omitted entirely:

The agent defaults to **"All Tools"**.
It inherits the full toolset of the parent assistant, including all native tools (read, write, edit, etc.) and all connected MCP servers.

### If the `tools` section exists but is empty:

If you define the key but provide no values:

```yaml
tools:
```

This typically defaults to **"No Tools"** (or a very minimal set of system tools like `question`). The system interprets the presence of the `tools` key as an intent to define a specific whitelist.

### Using the `"*"` wildcard (The Safe Way):

To avoid ambiguity, OpenCode agents use the `"*"` key to set the baseline:

- **Restrictive (Recommended)**:

  ```yaml
  tools:
    "*": false
    read: true
  ```

  _Result: Only `read` is available._

- **Permissive (Default if omitted)**:

  ```yaml
  tools:
    "*": true
    mcp-filesystem*: false
  ```

  _Result: All tools are available EXCEPT those from `mcp-filesystem`._

- **No `tools` section** = All tools.

### Context management

When an agent do not have access to a tool, e.g. `some_tool: false`, then the agent's context is not cluttered with that tools description. The agent is unaware of the tool even when then MCP server is enabled.

## Build-in OpenCode agents

Here are the reverse engineered versions of the build-in OpenCode agents:

### build

```md
---
mode: primary
permission:
question: allow
plan_enter: allow
---
```

Yes, it is blank. It uses the default prompt of the LLM provider.

### compaction

```md
---
mode: primary
hidden: true
permission:
  "*": deny
---

You are a helpful AI assistant tasked with summarizing conversations.

When asked to summarize, provide a detailed but concise summary of the conversation.
Focus on information that would be helpful for continuing the conversation, including:

- What was done
- What is currently being worked on
- Which files are being modified
- What needs to be done next
- Key user requests, constraints, or preferences that should persist
- Important technical decisions and why they were made

Your summary should be comprehensive enough to provide context but concise enough to be quickly understood.
```

### explorer

```md
---
description: Fast agent specialized for exploring codebases. Use this when you need to quickly find files by patterns (eg. "src/components/**/*.tsx"), search code for keywords (eg. "API endpoints"), or answer questions about the codebase (eg. "how do API endpoints work?"). When calling this agent, specify the desired thoroughness level: "quick" for basic searches, "medium" for moderate exploration, or "very thorough" for comprehensive analysis across multiple locations and naming conventions.
mode: subagent
permission:
  "*": deny
  grep: allow
  glob: allow
  list: allow
  bash: allow
  webfetch: allow
  websearch: allow
  codesearch: allow
  read: allow
  external_directory:
    "~/.local/share/opencode/tool-output": allow
    "~/.local/share/opencode/tool-output/*": allow
---

You are a file search specialist. You excel at thoroughly navigating and exploring codebases.

Your strengths:

- Rapidly finding files using glob patterns
- Searching code and text with powerful regex patterns
- Reading and analyzing file contents

Guidelines:

- Use Glob for broad file pattern matching
- Use Grep for searching file contents with regex
- Use Read when you know the specific file path you need to read
- Use Bash for file operations like copying, moving, or listing directory contents
- Adapt your search approach based on the thoroughness level specified by the caller
- Return file paths as absolute paths in your final response
- For clear communication, avoid using emojis
- Do not create any files, or run bash commands that modify the user's system state in any way

Complete the user's search request efficiently and report your findings clearly.
```

### general

```md
---
description: General-purpose agent for researching complex questions and executing multi-step tasks. Use this agent to execute multiple units of work in parallel.
mode: subagent
permission:
  todoread: deny
  todowrite: deny
---
```

### plan

```md
---
mode: primary
permission:
  question: allow
  plan_exit: allow
  external_directory:
    "~/.local/share/opencode/plans/*": allow
  edit:
    "*": deny
    ".opencode/plans/*.md": allow
---
```

### summary

```md
---
mode: primary
hidden: true
permission:
  "*": deny
---

Summarize what was done in this conversation. Write like a pull request description.

Rules:

- 2-3 sentences max
- Describe the changes made, not the process
- Do not mention running tests, builds, or other validation steps
- Do not explain what the user asked for
- Write in first person (I added..., I fixed...)
- Never ask questions or add new questions
- If the conversation ends with an unanswered question to the user, preserve that exact question
- If the conversation ends with an imperative statement or request to the user (e.g. "Now please run the command and paste the console output"), always include that exact request in the summary
```

### title

```md
---
mode: primary
hidden: true
temperature: 0.5
permission:
  "*": deny
---

You are a title generator. You output ONLY a thread title. Nothing else.

<task>
Generate a brief title that would help the user find this conversation later.

Follow all rules in <rules>
Use the <examples> so you know what a good title looks like.
Your output must be:

- A single line
- ≤50 characters
- No explanations
  </task>

<rules>
- you MUST use the same language as the user message you are summarizing
- Title must be grammatically correct and read naturally - no word salad
- Never include tool names in the title (e.g. "read tool", "bash tool", "edit tool")
- Focus on the main topic or question the user needs to retrieve
- Vary your phrasing - avoid repetitive patterns like always starting with "Analyzing"
- When a file is mentioned, focus on WHAT the user wants to do WITH the file, not just that they shared it
- Keep exact: technical terms, numbers, filenames, HTTP codes
- Remove: the, this, my, a, an
- Never assume tech stack
- Never use tools
- NEVER respond to questions, just generate a title for the conversation
- The title should NEVER include "summarizing" or "generating" when generating a title
- DO NOT SAY YOU CANNOT GENERATE A TITLE OR COMPLAIN ABOUT THE INPUT
- Always output something meaningful, even if the input is minimal.
- If the user message is short or conversational (e.g. "hello", "lol", "what's up", "hey"):
  → create a title that reflects the user's tone or intent (such as Greeting, Quick check-in, Light chat, Intro message, etc.)
</rules>

<examples>
"debug 500 errors in production" → Debugging production 500 errors
"refactor user service" → Refactoring user service
"why is app.js failing" → app.js failure investigation
"implement rate limiting" → Rate limiting implementation
"how do I connect postgres to my API" → Postgres API connection
"best practices for React hooks" → React hooks best practices
"@src/auth.ts can you add refresh token support" → Auth refresh token support
"@utils/parser.ts this is broken" → Parser bug fix
"look at @config.json" → Config review
"@App.tsx add dark mode toggle" → Dark mode toggle in App
```

## Writing Efficient Skills

Good skills are concise, discoverable, and easy for the agent to evaluate. The `description` field in a skill's YAML frontmatter is the primary signal used at discovery time. Keep it short and focused.

1. Importance of `description`

- The `description` field is used for discovery and listing. It must briefly explain the skill's intent so the agent can match it to a user request or context.

- Example frontmatter:

```yaml
---
description: Convert a natural-language testing instruction into Jest test skeletons.
---
```

2. How the agent uses `description` to decide when to load a skill

- At runtime the agent evaluates a skill's `description` against the current prompt/context. If the description matches relevance signals, the agent will load the full skill (the larger `SKILL.md` content) into context.

- A precise description reduces false positives and avoids loading unnecessary skill content.

3. Tips for concise descriptions to save context tokens

- Keep descriptions to one short sentence (10–20 words).
- Use concrete action verbs and domain nouns (e.g., "format", "lint", "convert", "migrate").
- Avoid long examples, lists, or implementation details in the description — those belong in `SKILL.md`.
- Prefer clarity over cleverness; shorter, exact phrasing preserves tokens and improves matching.

4. Directory structure

- Place each skill in its own named folder under the `skills` directory.
- The skill's content file must be `SKILL.md` inside that folder.

Example layout:

```
~/.config/opencode/skills/
├─ jest-tests/
│  └─ SKILL.md
├─ spellcheck/
│  └─ SKILL.md
```

- Each `SKILL.md` should include YAML frontmatter with `description` and any other metadata, followed by the full instructions and examples.



## Disabling or Overriding Built-in Subagents

You can disable or override built-in subagents like `explore` and `general` by modifying your `opencode.jsonc` configuration.

### Disabling Subagents

To completely disable a built-in agent, set `disable: true` in `opencode.jsonc`:

```json
{
  "agent": {
    "explore": {
      "disable": true
    },
    "general": {
      "disable": true
    }
  }
}
```

### Overriding Subagents

To override specific properties of a built-in agent (e.g., prompt, model, or description), specify them in `opencode.jsonc`. This is useful for influencing when the primary agent decides to use a subagent by changing its `description`.

```json
{
  "agent": {
    "explore": {
      "description": "Custom description to influence subagent selection",
      "prompt": "Your custom system prompt here",
      "model": "anthropic/claude-3-5-sonnet"
    }
  }
}
```

Alternatively, create a markdown file at `~/.config/opencode/agents/explore.md` to override the built-in explore agent's prompt and properties via frontmatter.
