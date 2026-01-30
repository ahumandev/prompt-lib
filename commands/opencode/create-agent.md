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
- **NEW:** Which LLM model(s) will this agent target? (Claude, GPT, Gemini, etc.)

**Examples:**
- `websearch`: Conducts systematic web searches with query decomposition
- `git`: Manages Git repositories with staging, commits, and branching
- `excel`: Manipulates Excel workbooks with data operations
- `explore`: Fast exploration of codebases with pattern matching

---

### Format & Structure Best Practices

This section covers modern prompt engineering techniques that significantly improve LLM agent performance.

#### 1. XML Tag Structuring (Model-Specific)

**For Claude/Anthropic Models:**
XML tags provide superior structural anchors compared to Markdown alone. Use them to clearly delineate distinct sections:

```xml
<instructions>
  <!-- Core behavioral instructions go here -->
</instructions>

<task>
  <!-- Current task description -->
</task>

<context>
  <!-- Background information and constraints -->
</context>

<constraints>
  <!-- Critical rules and safety boundaries -->
</constraints>

<examples>
  <!-- Few-shot examples demonstrating desired behavior -->
</examples>
```

**For GPT/OpenAI Models:**
GPT performs better with Markdown structure, but can benefit from XML tags as supplementary anchors for critical sections. Use selectively for emphasis.

**When to Use:**
- Claude models: Use XML tags throughout for maximum effectiveness
- GPT models: Use Markdown primarily; add XML tags only for critical constraints
- Multi-model agents: Layer both (Markdown base + XML for critical sections)

**Example Template:**
```yaml
---
# In agent markdown frontmatter
model: anthropic/claude-3-sonnet  # Triggers XML-first approach
---

<instructions>
This agent performs comprehensive code analysis...
</instructions>

<constraints>
- ALWAYS verify syntax before suggesting changes
- NEVER modify files without explicit permission
- MUST preserve existing formatting and comments
</constraints>
```

#### 2. Few-Shot Examples: The "Gold Standard" for Behavior Control

Research demonstrates that **examples often outweigh written instructions in impact**. Quality examples are more effective than lengthy explanations.

**Key Principles:**
- **Quality > Quantity**: 2-3 excellent examples beat 10 mediocre ones
- **Input + Output Clarity**: Show exact input format and expected output
- **Edge Cases**: Include at least one example of correct behavior under difficult conditions
- **Explicit Success**: Make it clear what "correct" looks like

**Example Structure:**
```markdown
## Examples

### Example 1: Simple Task
**Input:** User asks to "find bugs in this code"
**Expected Output:** 
- Specific bug locations with line numbers
- Severity level (critical/warning/info)
- Clear explanations and fixes

### Example 2: Complex Condition
**Input:** User asks to refactor while "keeping the same API"
**Expected Output:**
- Changes are internal-only, no signature changes
- All tests still pass
- Performance maintained or improved

### Example 3: Edge Case - Ambiguous Request
**Input:** User provides code with no context: "fix this"
**Expected Output:**
- Agent ASKS clarifying questions rather than assuming
- Lists possible interpretations
- Proposes focused approach once intent is clear
```

#### 3. Chain of Thought (CoT) Prompting

Instruct agents to "think step-by-step" explicitly. Research shows this dramatically improves reasoning quality.

**How to Implement:**
- Preface task descriptions with: "Think step-by-step before responding"
- Use explicit planning sections in your instructions
- Show the Plan → Reasoning → Solution workflow

**Example Integration:**
```markdown
## Your Approach

**Think step-by-step:**
1. First, gather all information about the problem
2. Then, analyze constraints and dependencies
3. Next, generate possible solutions
4. Finally, select the best approach and validate it

**Never skip steps** - the planning phase prevents errors.
```

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
model: google/gemini-3-flash        # Which model to use (affects prompt format)
temperature: 0.7                    # 0.0-1.0 (creativity level)
tools:
    "*": false                       # Default: deny all tools
    doom_loop: true                  # Always enable doom_loop
    edit: true                       # List specific tools
    glob: true
    grep: true
    # Add other tools as needed...
---

<instructions>
This section should be wrapped in XML tags for Claude models, or use 
standard Markdown for other models. Include all core behavioral instructions.
</instructions>

## Agent Name

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

## Examples

Provide 2-3 high-quality few-shot examples showing:
- Exact input format
- Expected output format
- Success criteria

Focus on quality over quantity. Include at least one edge case example.

## Step 1: [First Major Step]

Detailed instructions with explicit reasoning. Use "Think step-by-step" language.

## Step 2: [Second Major Step]

Detailed instructions...

## Tools Reference

| Tool Name | When to Use | Strategic Purpose |
|-----------|-------------|-------------------|
| `tool_name` | Call when [condition] | e.g. "Narrow search space before grep" |

> [!TIP]
> **Don't document parameters.** Opencode automatically discovers tool schemas (parameters, types, and descriptions) from the registry. Focus your instructions on the **logic** of when to use them and **why** one tool is preferred over another in specific contexts.

## Verification Checklist

Use this as a self-verification strategy to ensure quality output:

- [ ] Step 1 completed and verified
- [ ] Step 2 completed and verified
- [ ] Output matches expected format from Examples section
- [ ] All constraints honored
- [ ] Final output provided
```

**Model-Specific Template Variations:**

For **Claude/Anthropic Models**, wrap the entire instruction in XML tags for maximum clarity:

```yaml
---
model: anthropic/claude-3-sonnet
---

<instructions>
[Your full markdown instructions here]
</instructions>

<constraints>
- CRITICAL constraint 1
- CRITICAL constraint 2
</constraints>

<examples>
[Few-shot examples here]
</examples>
```

For **GPT/OpenAI Models**, use standard Markdown with XML only for critical sections:

```yaml
---
model: openai/gpt-4-turbo
---

# Agent Name

[Your instructions in standard Markdown]

<constraints>
Only wrap the most critical safety/behavior constraints
</constraints>
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
| `model` | string | No | LLM model to use (affects instruction format; see Step 2) |
| `temperature` | number | No | Creativity (0.0-1.0), defaults to global setting |
| `hidden` | boolean | No | Hide from agent list (default: false) |
| `tools` | object | Yes | Tool access policy |

**Tool Access:**
- `"*": false` - Deny all tools by default (recommended for security)
- `"*": true` - Allow all tools (not recommended)
- `"tool_name": true` - Allow specific tool
- `"tool_prefix_*": true` - Allow all tools matching pattern

**Model Selection Guidance:**

| Model | Strengths | Best For | XML Tags |
|-------|-----------|----------|----------|
| Claude 3 (Anthropic) | Excellent reasoning, long context | Complex analysis, code review | ✅ Use extensively |
| GPT-4 (OpenAI) | Broad knowledge, instruction following | General tasks, web research | ⚠️ Use sparingly |
| Gemini (Google) | Multimodal, fast | Real-time tasks, document analysis | ⚠️ Use for clarity |

---

### Step 4: Write Comprehensive Instructions

Your markdown file should provide:

1. **Clear Purpose** - What does this agent do?
2. **When to Trigger** - Keywords, phrases, conditions
3. **Few-Shot Examples** - 2-3 quality examples showing expected behavior (see Format & Structure Best Practices)
4. **Detailed Steps** - Break down with Chain-of-Thought guidance (think step-by-step)
5. **Tool Reference** - Table of tools and when to use them
6. **Verification Checklist** - Self-verification items before completion

**Best Practices:**

- Use **numbered steps** for sequential tasks
- Use **bullet points** for options/alternatives
- Provide **concrete examples** of queries and expected behavior (quality > quantity)
- Include **few-shot examples** demonstrating desired input/output formats
- Include **tool selection logic** (when to use which tool)
- Emphasize **Chain of Thought**: Include language like "Think step-by-step before responding"
- **AVOID documenting tool parameters**; focus on the "why" and "when"
- Define **success criteria** for each step using testable, measurable criteria
- Use **clear delimiters** to separate sections and prevent prompt injection attacks
- Structure output expectations using **Markdown tables or JSON** for consistency

---

### Step 4.5: Writing Strategy (High-Impact Principles)

Apply these core principles while drafting your instructions:

#### Fundamental Principles

- **Use Decisive Verbs**: Replace "should" with **MUST**, **ALWAYS**, or **NEVER**.
- **Positive Framing**: Frame as "do this" rather than "don't do that". (e.g., "Always check cache" vs "Don't skip cache").
- **Measurable Criteria**: Use specific metrics (e.g., "under 500 words", "at least 3 sources").
- **Structured Sections**: Use delimiters (`---`) and consistent heading levels to group concerns.

#### Critical Instruction Placement (Lost in the Middle Phenomenon)

Research shows that models perform worse with critical information in the **middle of long contexts**. Apply this strategy:

**For Short Prompts (<2000 tokens):**
- Place critical constraints at the beginning
- Repeat them once at the end

**For Long Prompts (>2000 tokens):**
- **Repeat critical constraints at BOTH beginning AND end**
- Place them in `<constraints>` XML blocks (for Claude)
- Use `---` delimiters to make them visually distinct
- Never bury critical rules in the middle section

**Example Structure:**
```markdown
<constraints>
🔴 CRITICAL - Place at START
- MUST verify all changes
- NEVER modify without permission
</constraints>

---

## Main Instructions
[Detailed steps and guidance]

---

<constraints>
🔴 CRITICAL - Repeat at END  
- MUST verify all changes
- NEVER modify without permission
</constraints>
```

#### Self-Verification & Verification Tables

Include a **verification table** at the end of your instructions. This sophisticated technique maps verification criteria to specific goals, dramatically improving model compliance.

**Example Verification Strategy:**

```markdown
## Verification Checklist

| Goal | Verification Criteria | How to Test |
|------|----------------------|------------|
| Correct format | Output is valid JSON | Try parsing with `json.parse()` |
| No hallucination | All facts from sources | Cross-check against input documents |
| Complete analysis | All criteria covered | Verify each point from requirements list |
| Safe modifications | No breaking changes | Compare with version control history |

- [ ] All verification criteria met before returning output
- [ ] No assumptions made beyond provided data
- [ ] Output structure matches Example section format
```

#### Structured Output & Delimiter Strategy

Prevent hallucination and prompt injection by requiring structured outputs:

```markdown
## Output Format

Return results ONLY in this exact format:

\`\`\`json
{
  "status": "success|error",
  "findings": [
    {
      "type": "bug|warning|info",
      "location": "file:line",
      "description": "..."
    }
  ]
}
\`\`\`

Use the format above **EXACTLY**. Do not deviate or create custom fields.
```

#### Dynamic Prompting for Long Context

When dealing with large codebases or documents, don't include everything in the base prompt:

```markdown
## Context Injection Strategy

For each sub-task:
1. Start with base instructions (this section)
2. Inject ONLY relevant file snippets
3. Include relevant Examples from Step 1
4. Re-include Critical Constraints from this prompt

This prevents "Lost in the Middle" problems and keeps focus high.
```

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
5. **Validate output** - ensure agent follows the instructions and verification checklist

**Testing command:**
```bash
# List available agents
opencode agents list

# Invoke your agent
opencode task --agent my-agent "test query"

# For complex agents, test multiple scenarios
opencode task --agent my-agent "edge case scenario 1"
opencode task --agent my-agent "edge case scenario 2"
```

**Validation Checklist:**
- [ ] Output matches structure from Examples section
- [ ] All verification criteria passed
- [ ] No hallucinated information
- [ ] Tool usage follows the decision logic
- [ ] Error handling works correctly

---

### Step 6: Reference Implementation Examples

Review existing agents to understand patterns:

- **`agents/websearch.md`**: Multi-step systematic search with few-shot examples
- **`agents/git.md`**: Repository management with verification tables
- **`agents/excel.md`**: Data manipulation with structured output

Key patterns to follow:

1. **Few-shot Examples** - Include 2-3 quality input/output pairs
2. **Chain of Thought** - Explicitly instruct agents to think step-by-step
3. **Verification Strategy** - Include verification table mapping criteria to goals
4. **State management** - Track progress through multi-step tasks
5. **Caching** - Reuse previous results when applicable
6. **Retry logic** - Handle failures gracefully
7. **Tool selection** - Choose appropriate tool for each step
8. **Output formatting** - Structure results using tables or JSON

---

## Common Agent Patterns

### Pattern 1: Research/Analysis Agent

```yaml
mode: subagent
model: anthropic/claude-3-sonnet  # Recommended for complex reasoning
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

**Instruction Template:**

```markdown
---
model: anthropic/claude-3-sonnet
---

<instructions>
# Research Agent

This agent conducts systematic research by gathering, analyzing, and synthesizing information.

## When to Use
- Complex research questions requiring multiple sources
- Deep analysis of codebase or documentation
- Comparative analysis of approaches/tools

## Your Approach

Think step-by-step through research:
1. Break down the question into sub-questions
2. Search for relevant sources
3. Evaluate source credibility
4. Synthesize findings into coherent analysis

## Examples

### Example 1: Simple Research
**Input:** "How do async/await patterns compare to callbacks?"
**Expected Output:** Structured comparison with pros/cons of each

### Example 2: Complex Analysis  
**Input:** "Analyze this codebase for architectural patterns"
**Expected Output:** Identified patterns, usage locations, recommendations
</instructions>

<constraints>
- MUST cite sources for all claims
- ALWAYS verify information across multiple sources
- NEVER make assumptions without evidence
</constraints>
```

### Pattern 2: Code/Git Agent

```yaml
mode: subagent
model: anthropic/claude-3-sonnet  # Superior code reasoning
temperature: 0.3  # Lower = more deterministic
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

**Instruction Template:**

```markdown
---
model: anthropic/claude-3-sonnet
temperature: 0.3
---

<instructions>
# Code Modification Agent

This agent safely modifies code while preserving functionality and style.

## Chain of Thought Process

Think step-by-step:
1. Understand current code purpose and implementation
2. Identify changes needed
3. Plan modifications respecting existing patterns
4. Verify changes don't break tests

## Examples

### Example 1: Simple Refactoring
**Input:** "Extract the validation logic into a separate function"
**Output:** New function definition + updated caller

### Example 2: Bug Fix
**Input:** "Fix the null pointer on line 42"
**Output:** Analysis of root cause + minimal fix + test verification
</instructions>

<constraints>
- MUST preserve code formatting and style
- ALWAYS check for test coverage before modifying
- NEVER remove error handling without replacement
</constraints>
```

### Pattern 3: Data Processing Agent

```yaml
mode: subagent
model: google/gemini-3-flash  # Good for data tasks
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

**Instruction Template:**

```markdown
---
model: google/gemini-3-flash
temperature: 0.5
---

# Data Processing Agent

This agent transforms and analyzes data structures systematically.

## Structured Approach

Think step-by-step:
1. Understand data schema
2. Identify transformation rules
3. Apply transformations consistently
4. Verify output format and completeness

## Examples

### Example 1: Data Transformation
**Input:** CSV with dates in "MM/DD/YYYY" format
**Output:** Transformed to ISO format with validation

### Example 2: Report Generation  
**Input:** Raw data with multiple sheets
**Output:** Consolidated summary with charts

## Output Format

Always return data as structured tables:

\`\`\`json
{
  "status": "success",
  "rows_processed": 1000,
  "data": [/* structured records */]
}
\`\`\`
```

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
- [ ] YAML frontmatter contains all required fields (color, description, mode, model, tools)
- [ ] Agent registered in `opencode.jsonc` under `agent` section (same scope)
- [ ] Configuration uses relative path `agents/{name}.md` (works in both scopes)
- [ ] Tool access policy follows deny-by-default pattern
- [ ] `doom_loop: true` is set in tools
- [ ] JSON syntax of opencode.jsonc is valid (with comments allowed)
- [ ] Model choice is documented (affects XML tag usage in Step 2)

### Instructions Quality
- [ ] Clear title explaining agent purpose
- [ ] "When to use" section with trigger conditions
- [ ] **Few-shot examples included** (2-3 quality input/output pairs showing expected behavior)
- [ ] Examples demonstrate edge cases or challenging scenarios
- [ ] Numbered workflow/steps (not free-form prose)
- [ ] **Chain of Thought language used** ("Think step-by-step", "Consider", "Reason through")
- [ ] Tool reference table documents **when** and **why** to use tools
- [ ] **NO** technical parameter or type documentation for tools (auto-discovered)
- [ ] **Verification table** maps success criteria to specific goals
- [ ] Structured output format defined (Markdown table, JSON, or XML structure)
- [ ] Workflow checklist at end of markdown

### Prompt Optimization
- [ ] Critical constraints placed at beginning AND end (long context)
- [ ] XML tags used appropriately for target model (Claude: extensive, GPT: selective)
- [ ] Related information grouped with clear section dividers (`---`)
- [ ] Consistent markdown formatting throughout
- [ ] Verbs are decisive (MUST/ALWAYS/NEVER, not "should/might")
- [ ] Criteria are measurable (e.g., "under 500 tokens" not "brief")
- [ ] Positive framing ("do this" not "don't do that")
- [ ] Bullet lists used for rules and options (not wordy paragraphs)
- [ ] Redundancy removed (constraints not repeated except strategically)
- [ ] Clear delimiters prevent prompt injection and improve clarity
- [ ] Grammar and spelling correct
- [ ] Tool conditions explicit ("call X when Y happens")
- [ ] Context injection strategy documented (for large codebases)

---

## Model-Specific Best Practices

### Claude/Anthropic Models

**Advantages:**
- Superior reasoning and long-context handling
- Excellent at following complex instructions
- Strong safety alignment

**Optimization Strategy:**
1. Use XML tags extensively throughout instructions
2. Place critical constraints in `<constraints>` tags
3. Include examples in `<examples>` tags
4. Use detailed reasoning in base instructions
5. Leverage longer context window for comprehensive examples

**Example Structure:**
```markdown
---
model: anthropic/claude-3-sonnet
---

<instructions>
# Agent Purpose

Complete markdown instructions wrapped in XML tag.
</instructions>

<examples>
### Example 1
[Detailed example]
</examples>

<constraints>
- CRITICAL: Never do X
- CRITICAL: Always do Y
</constraints>
```

**Temperature Recommendation:** 0.3-0.5 for analytical tasks, 0.7-1.0 for creative

### GPT/OpenAI Models

**Advantages:**
- Broad general knowledge
- Excellent instruction following with Markdown
- Good performance across diverse tasks

**Optimization Strategy:**
1. Use clear Markdown structure as primary format
2. Add XML tags only for most critical constraints
3. Be more explicit with examples (GPT needs more specificity)
4. Break instructions into smaller, digestible chunks
5. Use numbered lists for sequential instructions

**Example Structure:**
```markdown
---
model: openai/gpt-4-turbo
---

# Agent Purpose

[Standard Markdown instructions]

## Critical Rules

<constraints>
- MUST: [Most critical constraint]
- MUST: [Most critical constraint]
</constraints>

## Examples
[Detailed input/output examples]
```

**Temperature Recommendation:** 0.2-0.4 for precise tasks, 0.6-0.8 for analysis

### Google Gemini Models

**Advantages:**
- Multimodal capabilities
- Fast processing
- Good at real-time tasks

**Optimization Strategy:**
1. Use clear Markdown with occasional XML for emphasis
2. Structure information hierarchically
3. Provide concrete, diverse examples
4. Use tables for structured information
5. Keep constraints concise and scannable

**Temperature Recommendation:** 0.3-0.7 (balanced approach)

### Multi-Model Flexibility

If your agent supports multiple models, provide layered instructions:

```markdown
---
model: google/gemini-3-flash  # Default, but others can override
---

## For Claude Models

Use XML tags and detailed reasoning...

---

## For GPT/Other Models

Use Markdown-first approach...

---

## Universal Instructions

[Instructions that work across all models]
```

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
- **Improves consistency** - Prevents hallucination and drift

### The "Lost in the Middle" Problem

Research shows that critical information placed in the **middle of long prompts** is often overlooked by LLMs. This is especially important for agents with large instruction sets.

**Solution Strategy:**

```
┌─────────────────────────────────────┐
│  🔴 CRITICAL CONSTRAINTS (TOP)     │
│  Place here for immediate impact    │
└─────────────────────────────────────┘
         ↓
┌─────────────────────────────────────┐
│  📋 Main Instructions               │
│  Detailed steps and examples        │
└─────────────────────────────────────┘
         ↓
┌─────────────────────────────────────┐
│  🔴 CRITICAL CONSTRAINTS (END)      │
│  Repeat here for reinforcement      │
└─────────────────────────────────────┘
```

**Implementation:**
- For prompts < 2000 tokens: Place critical rules at top and bottom
- For prompts > 2000 tokens: Place at top, middle, and bottom
- Use `---` delimiters and XML tags (`<constraints>`) for visibility
- Test variations to measure impact

### Quick Optimization Workflow

1. **Review Structure**
   - Are critical constraints at the top AND bottom? ✅
   - Is related info grouped together? ✅
   - Are there clear section delimiters? ✅
   - Does prompt follow target model's format (XML for Claude, Markdown for GPT)? ✅

2. **Improve Language**
   - Replace fuzzy verbs with MUST/ALWAYS/NEVER
   - Replace vague criteria with measurable ones
   - Convert "don't do X" to "do Y instead"
   - Use bullet lists instead of prose for rules

3. **Enhance Structure**
   - Add few-shot examples if missing (research shows high impact)
   - Include verification table for self-checking
   - Add Chain of Thought language ("think step-by-step")
   - Use XML tags for model-specific optimization

4. **Compress Content**
   - Remove redundant constraints (except strategic repetition for long prompts)
   - Keep only the best examples (quality > quantity)
   - Condense explanations to 1-2 sentences
   - Use tables for comparisons and structured data

5. **Test Clarity**
   - Can a new person understand each step?
   - Are tool usage conditions explicit?
   - Can verification checklist items be verified objectively?
   - Would examples help clarify ambiguous sections?

### Red Flags (Signs Your Prompt Needs Optimization)

| Red Flag | Fix | Research Finding |
|----------|-----|-------------------|
| Lots of "maybe" or "should probably" | Use decisive: MUST, ALWAYS, NEVER | Decisive language improves compliance |
| Vague criteria ("good job", "properly") | Measurable: "under 500 tokens", "5 bullet points" | Measurable goals reduce hallucination |
| Long paragraphs explaining rules | Convert to bullet list or table | Structured format improves parsing |
| Same constraint in multiple places | Consolidate, then repeat strategically at top+bottom | Strategic repetition overcomes "lost in middle" |
| Instructions say "don't do X" | Reframe: "do Y instead" | Positive framing outweighs negatives |
| Examples that don't match the scenario | Remove or replace with real examples | Quality examples outweigh written instructions |
| Unclear when to use a tool | Add explicit: "when X occurs, ALWAYS call Y" | Explicit conditions prevent errors |
| No success/verification criteria | Add verification table | Testable criteria dramatically improve compliance |
| No examples provided | Add 2-3 few-shot examples | Examples are "gold standard" for behavior control |

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

**CRITICAL:** ALWAYS check cache first to reduce API usage and latency.
```

**Benefits:**
- 58% reduction in tokens ✅
- Clearer step-by-step flow ✅
- Explicit tool usage ✅
- Measurable success criteria ✅
- Critical constraint emphasized ✅

### Advanced: Dynamic Prompting for Long Context

For agents handling large codebases or documents, implement dynamic context injection:

```markdown
## Context Injection Strategy (Important for Long Contexts)

For each sub-task:

1. **Start with base instructions** (this section - critical rules always included)
2. **Inject ONLY relevant snippets** (not entire files/documents)
3. **Include relevant examples** (from Examples section above)
4. **Reinforce critical constraints** (repeat from this prompt)
5. **Process and return** (structured output only)

This prevents "Lost in the Middle" degradation and maintains focus quality
across the entire context window.
```

### Optimization Tool Reference

| Goal | Technique | Research Support |
|------|-----------|-------------------|
| Reduce wordiness | Convert prose to bullet lists; use decisive verbs | Structured format improves parsing |
| Clarify constraints | Move to top/bottom; use MUST/ALWAYS/NEVER; use XML | Repetition overcomes "lost in middle" |
| Improve structure | Add section dividers; group related content; use XML | XML tags provide stronger anchors |
| Make measurable | Replace vague with specific numbers/criteria | Measurable goals reduce hallucination |
| Fix ambiguity | Add conditions: "when X, call Y"; use tables | Explicit rules prevent errors |
| Improve behavior | Add few-shot examples | Examples outweigh written instructions |
| Add verification | Include verification table mapping to goals | Testable criteria improve compliance |
| Support CoT | Use "think step-by-step" language | CoT dramatically improves reasoning |

### Token Usage Estimation

Before and after optimization, estimate token counts:

```bash
# Rough token count: ~4 characters = 1 token

Original: 180 tokens
Optimized: 75 tokens
Savings: 58%

Context Window Example:
- GPT-4: 128K tokens total
- Original instructions: 180 tokens
- Optimized instructions: 75 tokens
- Freed context: 105 tokens per call × N calls = significant savings
```

---

## Resources

### Official Documentation
- **OpenCode Agents Docs**: https://opencode.ai/docs/agents/
- **Custom Tools Docs**: https://opencode.ai/docs/custom-tools/
- **Permissions Docs**: https://opencode.ai/docs/permissions/
- **Source Code**: https://github.com/anomalyco/opencode

### Prompt Engineering Research
- **Few-Shot Learning**: Research shows examples often outweigh written instructions
- **Chain of Thought (CoT)**: Explicit "think step-by-step" language improves reasoning quality
- **Lost in the Middle**: Critical information in long prompts' middle is often overlooked - use repetition strategy
- **Structured Outputs**: Using tables/JSON prevents hallucination and improves consistency
- **XML Tags**: Provide stronger structural anchors for Claude models vs Markdown alone
- **Prompt Optimization**: See "Optimize Agent Prompts" section in Step 4.5 for advanced techniques

### Model-Specific Guidance
- **Claude/Anthropic**: Use extensive XML tags, long context leverage, superior reasoning
- **GPT/OpenAI**: Use Markdown-first approach, be explicit with examples
- **Gemini/Google**: Multimodal support, balanced approach works well

---

## Summary

Creating an OpenCode agent with modern LLM best practices requires:

1. **Purpose** - Define what the agent does and target model(s)
2. **Format Choice** - Use XML tags for Claude, Markdown for GPT, or both
3. **Few-Shot Examples** - Include 2-3 quality input/output pairs (high-impact!)
4. **Chain of Thought** - Explicitly instruct agents to think step-by-step
5. **Markdown File** - Write comprehensive instructions with proper structure
6. **Configuration** - Register in opencode.jsonc with tool access policy
7. **Verification** - Include verification tables and testable criteria
8. **Optimization** - Apply "Lost in the Middle" mitigation and prompt optimization
9. **Testing** - Verify agent works as expected with all criteria met
10. **Documentation** - Include examples, checklists, and clarity for future reference

### Key Research Findings Applied

✅ **Few-Shot Examples**: Quality examples outweigh written instructions  
✅ **Chain of Thought**: Explicit step-by-step reasoning improves outputs  
✅ **XML Tags**: Provide stronger structural anchors for Claude models  
✅ **Lost in the Middle**: Repeat critical constraints at top and bottom  
✅ **Verification Tables**: Map testing criteria to specific goals  
✅ **Structured Output**: Use tables, JSON, or XML to prevent hallucination  
✅ **Model-Specific Optimization**: Tailor format to target LLM  
✅ **Decisive Language**: MUST/ALWAYS/NEVER outperform "should/might"  
✅ **Measurable Criteria**: Specific metrics reduce compliance issues  

Follow the structure of existing agents, use the deny-by-default tool access pattern, apply modern prompt engineering research, and provide detailed, well-structured instructions for your agent to function optimally across different models.

