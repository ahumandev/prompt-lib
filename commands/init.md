---
description: Generate AGENTS.md files and skills for the current project
agent: init
---

This command updates AGENTS.md files and skills for the current project by delegating all work to the init agent. The init agent analyzes project structure, generates the root AGENTS.md file, structured sub-directory AGENTS.md files, and creates skills in `.opencode/skills/{project-name}/`.

All orchestration logic, including project analysis, AGENTS.md generation, and skill creation, is handled by the init agent and its sub-agents.
