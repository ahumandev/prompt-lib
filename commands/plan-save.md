---
description: Save current plan for another agent instance to work on.
agent: build
---

Persist the current execution plan to .opencode\next-plan.md for stateless agent handoff.

## Constraints
- **MUST** preserve original plan's intent, domain scope, and constraints
- **MUST** replace existing file if present
- **NEVER** add features/facts unless explicitly inferable
- **File location**: .opencode\next-plan.md

## Goals
As Planner, capture every detail of the current execution plan such that a context-free LLM agent can:

- Understand the plan's intent and background
- Architectural decisions
- Execute steps in correct order
- Verify successful completion
- Locate all required files

## Plan
- Extract current plan details (background, steps, files, success criteria)
- Write plan to target file
- Verify completeness

### 1. Extract Plan Details

Gather from current context:

- Background: Original intent (<400 words) with examples or test data (if available)
- Acceptance Criteria: Copy the original acceptance criteria as-is
- Steps: All instructions in execution order
- Files: Absolute paths to modified/created files
- Success criteria: Testable verification (e.g., unit tests, output validation or user instructions on how to test)

### 2. Write Plan Details

- Write every step of the original plan as a sub-section under the Implementation section
- Each step **MUST** include a purpose (short term goal) and strategy (how it fits in the bigger picture)
- Copy all details of the original plan's step including the complete code blocks, config blocks and examples

### 3. Write File

Use filesystem_write_file to write .opencode\next-plan.md

### 4. Verify Completeness
Confirm plan.md includes:

- Intent: Background matches original plan purpose
- Completeness: Every instruction/step/example copied
- Paths: All file locations are absolute paths
- Order: Steps numbered in correct execution sequence
- Testability: Verification section has measurable criteria
- Clarity: Context-free agent can execute without questions
