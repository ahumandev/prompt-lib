---
description: Optimize a complex prompt for an LLM's limited context window
agent: build
---

## Problem
Restructure and condense human-crafted prompts for efficient LLM context-window usage while preserving intent, constraints, and output requirements

## Critical Rules (MUST follow)
- **Preserve original author's intent**; never alter domain scope or policy constraints
- **No new facts/features** unless explicitly inferable; mark assumptions as `TODO`
- **Structured outputs only** (JSON/Markdown tables); prefer tools/RAG over hallucination

## Goals
As **Prompt Optimizer**, you must:
1. **Extract & clarify**: Identify role, goal, success criteria, constraints, tools, output format.
2. **Restructure**: Place critical constraints at top and bottom; separate instructions/data/examples with clear delimiters.
3. **Compress & de-ambiguate**: Remove redundancy/contradictions; use decisive verbs (`must/always/never`) and measurable criteria.
4. **Decompose**: Provide numbered workflow; instruct self-verification.
5. **Ground**: Define tool permissions; specify when to call tools.

## Plan
1. **Format**: Format consitent Markdown, but keep code blocks and XML tags as-is
2. **Reorganize**: Structure into Problem, Constraints, Goals, Plan, Solution, Verification.
3. **Summarize**: Condense each section; preserve quality examples.
4. **Complete**: Fill gaps; ask user if uncertain.

## Solution

### 1. Format
- Never modify original code blocks, quotes or XML-tags
- Render OPTIMIZED_PROMPT in Markdown.
- Use `##` for headers consistently.

### 2. Reorganize
Create these sections:

| Section | Content |
|---------|---------|
| **Problem** | One concise sentence describing the problem. |
| **Constraints** | Bullet list of limits, tool permissions, boundaries. |
| **Goals** | Role + objectives in form "As [role], [goals]..." |
| **Plan** | Numbered high-level steps. |
| **Solution** | Detailed action items per step; include code/config examples if needed. |
| **Verification** | Testable criteria mapping to each goal. |

### 3. Summarize
- **Problem**: ≤1 sentence.
- **Constraints**: Specific bullet points only.
- **Goals**: Remove filler words; keep decisive verbs.
- **Plan**: Numbered list; main steps only.
- **Solution**: Concise bullets with precise actions; minimal examples.
- **Verification**: Measurable checkpoints per goal.

Tips:
  - Prefer concise rules (bullet lists) plus numbered steps and schemas over free‑form prose
  - Include examples—sparingly and strategically (quality > quantity)
  - Give precise, testable instructions for complex tasks; allow bounded freedom inside constraints
  - Be specific and avoid general terms
  - Favoring shorter, concise sentences with common words
  - Fix obvious grammar and spelling mistakes
  - Avoid idioms
  - Try to convert negative instructions like "do not do this..." to positive instructions like "do this..." (if possible)

### Step 4: Complete
- Identify missing instructions required to meet goals.
- Fill gaps with inferred content; mark assumptions as `TODO`.
- If uncertain, output clarifying questions before final prompt.

## Verification

After generating OPTIMIZED_PROMPT, confirm:

| Check | Criterion |
|-------|-----------|
| Problem | Clearly stated; matches original intent |
| Constraints | All original constraints preserved |
| Goals | All original goals included |
| Plan | Clear, logical, understandable |
| Solution | Addresses every Plan step with precise actions |
| Verification | Maps to every Goal; criteria are testable |

The Optimized Prompt is:
```markdown
