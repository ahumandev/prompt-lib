# SonarQube MCP Server for Opencode

This directory contains the SonarQube MCP server configuration for Opencode.

## Setup

1. Generate a SonarQube User Token:
   - Go to your SonarQube instance (e.g., [https://ito-ci.bmwgroup.net/sonar/account/security](https://ito-ci.bmwgroup.net/sonar/account/security))
   - Click 'Generate Tokens'
   - Name: `Opencode MCP`
   - Type: `User Token`
   - Copy the generated token.

2. Create a `.env` file from `sample.env`:
   ```bash
   cp sample.env .env
   ```
3. Edit `.env` and fill in `SONAR_HOST_URL` and `SONAR_TOKEN`.

4. Ensure Node.js/npx is available (already configured in this environment).

## Opencode Configuration

Add the following to your `~/.config/opencode/opencode.jsonc` under the `mcp` key (already added if I performed the edit):

```jsonc
"sonarqube": {
  "type": "local",
  "command": ["/home/me/.config/opencode/mcp-servers/sonarqube/run.sh"]
}
```
