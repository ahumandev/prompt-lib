---
description: Manage OpenCode configuration.
agent: build
---

# Opencode locations
- Opencode configuration file location: ~/.config/opencode/opencode.jsonc or {current dir}/.opencode/opencode.jsonc
- agents: ~/.config/opencode/agent or {current dir}/.opencode/agent
- commands: ~/.config/opencode/command or {current dir}/.opencode/command
- mcp: ~/.config/opencode/mcp-servers or {current dir}/.opencode/mcp-servers
- skills: ~/.config/opencode/skills or {current dir}/.opencode/skills

# Opencode doc links
- source code: https://github.com/anomalyco/opencode
- tool docs: https://opencode.ai/docs/tools
- custom tool docs: https://opencode.ai/docs/custom-tools/
- agents docs: https://opencode.ai/docs/agents/
- agents docs: https://opencode.ai/docs/commands/
- permission docs: https://opencode.ai/docs/permissions/
- mcp server docs: https://opencode.ai/docs/mcp-servers/
- skills docs: https://raw.githubusercontent.com/zenobi-us/opencode-skillful/refs/heads/main/README.md

# MCP Servers

Prefer stdio mode if possible to allow multiple concurrent opencode instances (avoid HTTP server port conflict).
