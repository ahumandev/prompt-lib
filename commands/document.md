---
description: Generate/update all project documentation (comments, AGENTS.md, README.md, etc.)
agent: document
---

Perform a comprehensive documentation update for the entire project:

1. Read existing README.md (if it exists) to extract context
2. Call ALL documentation subagents to analyze and update their respective areas.
3. Generate/update AGENTS.md based on all subagent reports
4. Use your task tool to call `document/readme` to finalize `README.md`
