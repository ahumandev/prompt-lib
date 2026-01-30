---
description: Create new agent for Opencode
---

# Create an OpenCode Agent

This command provides comprehensive instructions for creating a new OpenCode agent correctly.

---

## What is an OpenCode Agent?

An OpenCode agent is a specialized AI assistant configured to handle specific types of tasks autonomously. Agents are defined by:

- **A markdown file** (e.g., `agents/my-agent.md`) containing the agent's instructions and behavior
- **Configuration in opencode.jsonc** that defines the agent's model, tools, and settings
- **Clear triggering conditions** that indicate when to invoke this agent

### Agent Scope: Global vs. Project-Level

Agents can be created in two locations:

- **Global agents** (`~/.config/opencode/agents/`) - Available to all projects on your system
- **Project agents** (`{project-dir}/.opencode/agents/`) - Available only within a specific project

When you're in a project directory that has `.opencode/opencode.jsonc`, project-level agents take precedence over global agents with the same name.

---

## ⚡ Quick Start: 3-Minute Setup

### **For a Global Agent** (available everywhere)
1. **Create instructions**: `~/.config/opencode/agents/my-agent.md`
2. **Register in config**: Add to `agent` section in `~/.config/opencode/opencode.jsonc`
3. **Verify**: Run `opencode agents list`

### **For a Project Agent** (this project only)
1. **Create instructions**: `.opencode/agents/my-agent.md`
2. **Register in config**: Add to `agent` section in `.opencode/opencode.jsonc`
3. **Verify**: Run `opencode agents list` (from project directory)

---

## Step-by-Step Guide to Creating an Agent

### Step 1: Determine the Agent's Purpose

**Define clearly:**
- What type of tasks should this agent handle?
- When should it be triggered?
- What tools does it need access to?
- Is it a subagent (called by the main agent) or a primary agent?

**Examples:**
- `websearch`: Conducts systematic web searches with query decomposition
- `git`: Manages Git repositories with staging, commits, and branching
- `excel`: Manipulates Excel workbooks with data operations
- `explore`: Fast exploration of codebases with pattern matching

---

### Step 2: Create the Agent Markdown File

Create a new markdown file at one of these locations:

**Option A: Global Agent** (available to all projects)
```
~/.config/opencode/agents/{agent-name}.md
```

**Option B: Project Agent** (project-specific, requires .opencode in project root)
```
{project-dir}/.opencode/agents/{agent-name}.md
```

**When to choose each:**
- **Global**: Reusable agent for multiple projects (e.g., research tools, coding assistants)
- **Project**: Domain-specific agent for a particular project (e.g., project-specific workflows)

**File Structure:**

```yaml
---
color: "#RRGGBB"                    # Hex color for UI
description: Brief description      # 5-10 words, what does it do
hidden: false                        # true to hide from agent list
mode: subagent                       # "subagent" if called by main agent
model: google/gemini-3-flash        # Which model to use
temperature: 0.7                    # 0.0-1.0 (creativity level)
tools:
    "*": false                       # Default: deny all tools
    doom_loop: true                  # Always enable doom_loop
    edit: true                       # List specific tools
    glob: true
    grep: true
    # Add other tools as needed...
---

# Agent Name

Brief intro paragraph explaining what this agent does.

## When to use this agent

**Trigger this agent when:**
- Specific keywords or phrases
- Types of requests that match this agent's specialty
- Conditions under which it should be invoked

**Do NOT use for:**
- Tasks this agent is not designed for
- When the main agent can handle it better

---

## Overview

Comprehensive explanation of the agent's mission and approach.

## Step 1: [First Major Step]

Detailed instructions...

## Step 2: [Second Major Step]

Detailed instructions...

## Tools Reference

| Tool Name | When to Use | Strategic Purpose |
|-----------|-------------|-------------------|
| `tool_name` | Call when [condition] | e.g. "Narrow search space before grep" |

> [!TIP]
> **Don't document parameters.** Opencode automatically discovers tool schemas (parameters, types, and descriptions) from the registry. Focus your instructions on the **logic** of when to use them and **why** one tool is preferred over another in specific contexts.

## Workflow Checklist

- [ ] Step 1 completed
- [ ] Step 2 completed
- [ ] Final output provided
```

---

### Step 3: Configure the Agent in opencode.jsonc

Add your agent to the `agent` section in the appropriate `opencode.jsonc`:

**Option A: Global Configuration**
Edit: `~/.config/opencode/opencode.jsonc`

**Option B: Project Configuration**
Edit: `{project-dir}/.opencode/opencode.jsonc`

**Note:** If you don't have a `.opencode` directory in your project, create it:
```bash
mkdir -p {project-dir}/.opencode
```

**Configuration Template:**

```jsonc
{
  "agent": {
    "my-agent": {                    // Agent identifier (matches filename)
      "hidden": false,               // Show in agent list
      "model": "google/gemini-3-flash", // Optional: override default model
      "prompt": "agents/my-agent.md", // Path to instructions file
      "temperature": 0.7,            // Optional: override default temperature
      "tools": {
        "*": false,                  // Default: deny all tools
        "doom_loop": true,           // Required: allows safe retry loops
        "edit": true,                // Specific tools this agent needs
        "glob": true,
        "grep": true,
        "my_tool_*": true            // Wildcard patterns supported
      }
    }
  }
}
```

**Configuration Resolution Order** (what OpenCode looks for):

When you invoke an agent, OpenCode searches in this order:
1. **Project agents** - `{current-dir}/.opencode/agents/{agent-name}.md`
2. **Project config** - `{current-dir}/.opencode/opencode.jsonc` (agent config)
3. **Global agents** - `~/.config/opencode/agents/{agent-name}.md`
4. **Global config** - `~/.config/opencode/opencode.jsonc` (agent config)

This means **project-level agents override global agents with the same name**.

**CRITICAL: Tool Access Rules**

- 🛡️ **`"*": false`** - ALWAYS start with a deny-all policy.
- 🔄 **`"doom_loop": true`** - **MANDATORY**. Without this, agents cannot retry failed steps or recover from errors.
- 🎯 **`"tool_prefix_*": true`** - Use wildcards for tool groups (e.g., `websearch_*`) to keep config clean.

**Key Configuration Options:**

| Option | Type | Required | Description |
|--------|------|----------|-------------|
| `prompt` | string | Yes | Path to agent instructions markdown file |
| `model` | string | No | LLM model to use (inherits from config if omitted) |
| `temperature` | number | No | Creativity (0.0-1.0), defaults to global setting |
| `hidden` | boolean | No | Hide from agent list (default: false) |
| `tools` | object | Yes | Tool access policy |

**Tool Access:**
- `"*": false` - Deny all tools by default (recommended for security)
- `"*": true` - Allow all tools (not recommended)
- `"tool_name": true` - Allow specific tool
- `"tool_prefix_*": true` - Allow all tools matching pattern

---

### Step 4: Write Comprehensive Instructions

Your markdown file should provide:

1. **Clear Purpose** - What does this agent do?
2. **When to Trigger** - Keywords, phrases, conditions
3. **Detailed Steps** - Break down the task into clear steps
4. **Tool Reference** - Table of tools and when to use them
5. **Examples** - Show expected workflows
6. **Checklist** - Verification items before completion

**Best Practices:**

- Use **numbered steps** for sequential tasks
- Use **bullet points** for options/alternatives
- Provide **concrete examples** of queries and expected behavior
- Include **tool selection logic** (when to use which tool)
- **AVOID documenting tool parameters**; focus on the "why" and "when"
- Define **success criteria** for each step

---

### Step 4.5: Writing Strategy (High-Impact Principles)

Apply these core principles while drafting your instructions:

- **Use Decisive Verbs**: Replace "should" with **MUST**, **ALWAYS**, or **NEVER**.
- **Positive Framing**: Frame as "do this" rather than "don't do that". (e.g., "Always check cache" vs "Don't skip cache").
- **Measurable Criteria**: Use specific metrics (e.g., "under 500 words", "at least 3 sources").
- **Structured Sections**: Use delimiters (`---`) and consistent heading levels to group concerns.

---

### Step 5: Test Your Agent

Before deploying:

1. **Verify configuration syntax** in opencode.jsonc (valid JSON with comments)
2. **Check file paths** - ensure `agents/my-agent.md` exists and is readable
3. **Review tool access** - verify agent has only necessary tools
4. **Test triggering** - invoke agent and verify it activates
5. **Validate output** - ensure agent follows the instructions

**Testing command:**
```bash
# List available agents
opencode agents list

# Invoke your agent
opencode task --agent my-agent "test query"
```

---

### Step 6: Reference Implementation Examples

Review existing agents to understand patterns:

- **`agents/websearch.md`**: Multi-step systematic search with caching
- **`agents/git.md`**: Repository management with verification
- **`agents/excel.md`**: Data manipulation with complex logic

Key patterns to follow:

1. **State management** - Track progress through multi-step tasks
2. **Caching** - Reuse previous results when applicable
3. **Retry logic** - Handle failures gracefully
4. **Tool selection** - Choose appropriate tool for each step
5. **Output formatting** - Structure results clearly

---

## Common Agent Patterns

### Pattern 1: Research/Analysis Agent

```yaml
mode: subagent
temperature: 0.7
tools:
  "*": false
  doom_loop: true
  webfetch: true
  websearch_*: true
  glob: true
  grep: true
  read: true
```

**Use case:** Web research, codebase analysis, documentation review

### Pattern 2: Code/Git Agent

```yaml
mode: subagent
temperature: 0.3
tools:
  "*": false
  doom_loop: true
  edit: true
  glob: true
  grep: true
  read: true
  git_*: true
  bash: true
```

**Use case:** Code modification, Git operations, repository management

### Pattern 3: Data Processing Agent

```yaml
mode: subagent
temperature: 0.5
tools:
  "*": false
  doom_loop: true
  excel_*: true
  glob: true
  grep: true
  read: true
  write: true
```

**Use case:** Excel workbooks, data transformation, report generation

---

## Tool Access Policy Best Practices

✅ **DO:**
- Start with `"*": false` (deny-all-by-default)
- Explicitly list required tools
- Use wildcards sparingly and purposefully
- Document why each tool is needed

❌ **DON'T:**
- Use `"*": true` for security/safety
- Grant tools the agent doesn't need
- Forget `"doom_loop": true` (agents need this to function)
- Use overly broad wildcards without justification

---

## Configuration Checklist

Before deploying your agent, verify:

### Agent Structure
- [ ] Choose scope: Global (`~/.config/opencode/`) or Project (`.opencode/`)
- [ ] Markdown file created at `agents/{name}.md` in chosen scope
- [ ] YAML frontmatter contains all required fields (color, description, mode, tools)
- [ ] Agent registered in `opencode.jsonc` under `agent` section (same scope)
- [ ] Configuration uses relative path `agents/{name}.md` (works in both scopes)
- [ ] Tool access policy follows deny-by-default pattern
- [ ] `doom_loop: true` is set in tools
- [ ] JSON syntax of opencode.jsonc is valid (with comments allowed)

### Instructions Quality
- [ ] Clear title explaining agent purpose
- [ ] "When to use" section with trigger conditions
- [ ] Numbered workflow/steps (not free-form prose)
- [ ] Tool reference table documents **when** and **why** to use tools
- [ ] **NO** technical parameter or type documentation for tools (auto-discovered)
- [ ] Examples provided for main use cases (quality > quantity)
- [ ] Workflow checklist at end of markdown

### Prompt Optimization
- [ ] Critical constraints placed at beginning and end
- [ ] Related information grouped with clear section dividers (`---`)
- [ ] Consistent markdown formatting throughout
- [ ] Verbs are decisive (MUST/ALWAYS/NEVER, not "should/might")
- [ ] Criteria are measurable (e.g., "under 500 tokens" not "brief")
- [ ] Positive framing ("do this" not "don't do that")
- [ ] Bullet lists used for rules and options (not wordy paragraphs)
- [ ] Redundancy removed (constraints not repeated)
- [ ] Grammar and spelling correct
- [ ] Tool conditions explicit ("call X when Y happens")

---

## Quick Reference: Configuration Structure

**Global Agent Configuration:**
Edit: `~/.config/opencode/opencode.jsonc`
```jsonc
{
  "agent": {
    "agent-name": {                          // Must match file name
      "hidden": false,                       // Show in list
      "model": "google/gemini-3-flash",     // Optional override
      "prompt": "agents/agent-name.md",     // Path to instructions
      "temperature": 0.7,                   // Optional override
      "tools": {
        "*": false,                         // Deny all by default
        "doom_loop": true,                  // Required!
        "required_tool_1": true,            // List each tool
        "required_tool_2": true,
        "tool_prefix_*": true               // Or use wildcards
      }
    }
  }
}
```

**Project Agent Configuration:**
Edit: `{project-dir}/.opencode/opencode.jsonc`
```jsonc
{
  "agent": {
    "project-agent": {                       // Agent ID (matches agent-name.md)
      "hidden": false,                       // Show in list
      "prompt": "agents/project-agent.md",  // Relative path works in project
      "tools": {
        "*": false,
        "doom_loop": true,
        "project_specific_tool": true
      }
    }
  }
}
```

**Directory Structure Examples:**

Global agent:
```
~/.config/opencode/
├── opencode.jsonc          (contains agent config)
└── agents/
    └── my-agent.md         (agent instructions)
```

Project agent:
```
{project-dir}/
├── .opencode/
│   ├── opencode.jsonc      (contains agent config)
│   └── agents/
│       └── project-agent.md (agent instructions)
└── ... other project files
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Agent not appearing in list | Check `hidden: false` in frontmatter |
| "Tool not available" error | Verify tool in `tools` section of config |
| Agent not executing | Check `prompt` file path exists and is readable |
| Unexpected behavior | Review instructions for ambiguous steps |
| Agent loops infinitely | Check `doom_loop: true` in tools, review task scope |

---

## Prompt Optimization Guide (Advanced)

After writing your agent instructions, optimize them for better LLM performance and lower token usage.

### Why Optimize?
- **Reduces context window usage** - More room for agent reasoning
- **Improves clarity** - Reduces ambiguity and misinterpretation
- **Better performance** - Focused, structured prompts produce better results
- **Faster execution** - Less text = faster processing

### Quick Optimization Workflow

1. **Review Structure**
   - Are critical constraints at the top AND bottom? ✅
   - Is related info grouped together? ✅
   - Are there clear section delimiters? ✅

2. **Improve Language**
   - Replace fuzzy verbs with MUST/ALWAYS/NEVER
   - Replace vague criteria with measurable ones
   - Convert "don't do X" to "do Y instead"
   - Use bullet lists instead of prose for rules

3. **Compress Content**
   - Remove redundant constraints (don't repeat)
   - Keep only the best examples (quality > quantity)
   - Condense explanations to 1-2 sentences
   - Use tables for comparisons

4. **Test Clarity**
   - Can a new person understand each step?
   - Are tool usage conditions explicit?
   - Can checklist items be verified objectively?

### Red Flags (Signs Your Prompt Needs Optimization)

| Red Flag | Fix |
|----------|-----|
| Lots of "maybe" or "should probably" | Use decisive: MUST, ALWAYS, NEVER |
| Vague criteria ("good job", "properly") | Measurable: "under 500 tokens", "5 bullet points" |
| Long paragraphs explaining rules | Convert to bullet list |
| Same constraint mentioned in multiple places | Consolidate into one location |
| Instructions say "don't do X" | Reframe: "do Y instead" |
| Examples that don't match the scenario | Remove or replace with real examples |
| Unclear when to use a tool | Add explicit condition: "when X occurs, call Y" |

### Real-World Optimization Example

**Original (verbose, 180 tokens):**
```
The agent should begin by checking if the information it needs is 
already in the cache. If the cache contains relevant information that 
could answer the user's question, the agent should use that instead of 
making a web request. However, if the cache doesn't have what we need, 
then the agent should proceed to search the web for the information. 
When searching online, the agent might want to try different search 
queries if the initial query doesn't return good results. The agent 
should keep trying until it finds useful information or reaches some 
reasonable limit on the number of attempts.
```

**Optimized (precise, 75 tokens):**
```
## Search Process

1. **Check cache** - Use `filesystem_grep_files` on `.opencode/cache/`
2. **Search online** - Call `websearch_search` only on cache miss
3. **Retry logic** - Try up to 3 alternative queries if <5 results returned
4. **Success criteria** - Stop when answer clearly addresses original question
```

**Benefits:**
- 58% reduction in tokens ✅
- Clearer step-by-step flow ✅
- Explicit tool usage ✅
- Measurable success criteria ✅

### Optimization Tool Reference

| Goal | Technique |
|------|-----------|
| Reduce wordiness | Convert prose to bullet lists; use decisive verbs |
| Clarify constraints | Move to top/bottom; use MUST/ALWAYS/NEVER |
| Improve structure | Add clear section dividers; group related content |
| Make measurable | Replace vague with specific numbers/criteria |
| Fix ambiguity | Add conditions: "when X, call Y"; use tables for options |
| Show examples | Keep 1 strong example per section; include input+output |

---

## Resources

- **OpenCode Agents Docs**: https://opencode.ai/docs/agents/
- **Custom Tools Docs**: https://opencode.ai/docs/custom-tools/
- **Permissions Docs**: https://opencode.ai/docs/permissions/
- **Source Code**: https://github.com/anomalyco/opencode
- **Prompt Optimization Tips**: See "Optimize Agent Prompts" section in Step 4.5

---

## Summary

Creating an OpenCode agent requires:

1. **Purpose** - Define what the agent does
2. **Markdown File** - Write comprehensive instructions with steps
3. **Configuration** - Register in opencode.jsonc with tool access
4. **Testing** - Verify agent works as expected
5. **Documentation** - Include examples and checklists

Follow the structure of existing agents, use the deny-by-default tool access pattern, and provide detailed, step-by-step instructions for your agent to function optimally.
