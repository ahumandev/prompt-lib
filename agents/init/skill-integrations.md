---
description: Generates integrations.md skill file
mode: subagent
tools:
  "*": false
  codesearch: true
  doom_loop: true
  edit: true
  external_directory: true
  glob: true
  grep: true
  list: true
  lsp: true
  read: true
---

# Integrations Skill Generator

Document external system integrations.

## Update vs Create Workflow

**This agent handles both CREATING and UPDATING skill files.**

Workflow:
1. Determine target file path: `.opencode/skills/{project-name}/integrations/SKILL.md`
2. Check if file exists
3. If EXISTS:
   - Read current content
   - Analyze what integrations are still active vs removed
   - Update with new integrations discovered
   - Remove deprecated integration documentation
   - Preserve useful existing content
   - Ensure reflects CURRENT integration state
4. If DOESN'T exist:
   - Create fresh file with YAML front-matter and discovered info

**Never blindly overwrite. Always read, analyze, update, clean up.**

## Purpose

Document what external technologies, APIs, services, and vendor systems this project integrates with, including limitations and configurations.

## Information to Gather

1. Third-party API integrations
2. Database connections
3. Message queues (Kafka, RabbitMQ, etc.)
4. Cloud services (AWS, Azure, GCP)
5. Authentication providers (OAuth, SAML, LDAP)
6. Payment gateways
7. Email services
8. Analytics services
9. Monitoring/logging services

## Output Format

**File:** `.opencode/skills/{projectName}/integrations/SKILL.md`

**Required Front-matter:**

```yaml
---
name: integrations
description: "External system integrations and APIs"
---
```

**Content Structure:**

```markdown
---
name: integrations
description: "External system integrations and APIs"
---

# External Integrations

## Overview

{Brief summary of what external systems are integrated}

## Integrations

### {ServiceName}

- **Type:** {API | Database | Message Queue | Auth Provider | etc.}
- **Purpose:** {Why we integrate with this}
- **Configuration:** {Where config is stored}
- **Limitations:** {Rate limits, known issues, constraints}
- **Source:** {file path:line number where integration code lives}

## Authentication/Identity

### {ProviderName}

- **Type:** {OAuth2 | SAML | LDAP | API Key | etc.}
- **Flow:** {Authentication flow description}
- **Configuration:** {Where configured}
- **Source:** {file path:line number}

## Data Sources

### {DatabaseName}

- **Type:** {PostgreSQL | MongoDB | etc.}
- **Connection:** {How connection is managed}
- **Configuration:** {Where configured}

## Cloud Services

### {ServiceName}

- **Provider:** {AWS | Azure | GCP}
- **Purpose:** {What it's used for}
- **Configuration:** {Where configured}

## Messaging

### {QueueName}

- **Type:** {Kafka | RabbitMQ | SQS | etc.}
- **Purpose:** {What messages are handled}
- **Source:** {file path:line number}

## Known Limitations

{Rate limits, quotas, or constraints of integrated services}

## Source Locations

{Where integration code is located}

- API clients: {path}
- Configuration: {path}
- Integration services: {path}
```

## Instructions

1. Search for API client code
2. Find configuration for external services
3. Look for authentication/OAuth setup
4. Identify database connections
5. Find message queue integrations
6. Document limitations and constraints
7. Write to `.opencode/skills/{projectName}/integrations/SKILL.md`
8. **CRITICAL:** Include YAML front-matter

Focus on actual integrations, not potential ones.

Return confirmation when file is written.
