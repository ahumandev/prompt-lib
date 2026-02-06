---
description: Generate/update all project documentation (comments, AGENTS.md, README.md, etc.)
agent: document
---

Perform a comprehensive documentation update for the entire project:

1. Read existing README.md (if it exists) to extract context
2. Call ALL documentation subagents to analyze and update their respective areas:
   - `document/api` - Document all API endpoints in source code comments
   - `document/install` - Create/update INSTALL.md with installation and usage instructions
   - `document/data` - Document all data entities in source code comments
   - `document/integrations` - Document all external system integrations in source code comments
   - `document/security` - Create/update SECURITY.md with security architecture
   - `document/contributing` - Create/update CONTRIBUTING.md with coding standards
3. Generate/update AGENTS.md based on all subagent reports
4. Call `document/readme` to finalize README.md

Update all documentation files, source code comments, and ensure consistency across the project.
