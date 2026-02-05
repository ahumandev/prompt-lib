---
description: Generates tech.md skill file
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
     read: true
---

# Tech Stack Skill Generator

Document technology stack and architectural decisions.

## Update vs Create Workflow

**This agent handles both CREATING and UPDATING skill files.**

Workflow:
1. Determine target file path: `.opencode/skills/{project-name}/tech/SKILL.md`
2. Check if file exists
3. If EXISTS:
   - Read current content
   - Analyze what tech stack info is still valid vs changed
   - Update with new technologies/patterns discovered
   - Remove deprecated technology documentation
   - Preserve useful existing content
   - Ensure reflects CURRENT tech stack
4. If DOESN'T exist:
   - Create fresh file with YAML front-matter and discovered info

**Never blindly overwrite. Always read, analyze, update, clean up.**

## Purpose

Document what technologies are used in this project and WHY they were chosen.

## Information to Gather

1. Programming languages
2. Frameworks (React, Angular, Spring Boot, etc.)
3. Build tools (Webpack, Vite, Maven, Gradle)
4. Testing frameworks
5. Database technologies
6. Deployment platforms
7. Architectural patterns
8. Why these technologies were chosen

## Output Format

**File:** `.opencode/skills/{projectName}/tech/SKILL.md`

**Required Front-matter:**

```yaml
---
name: tech
description: "Technology stack and architecture"
---
```

**Content Structure:**

```markdown
---
name: tech
description: "Technology stack and architecture"
---

# Technology Stack

## Languages

- **Primary:** {Language and version}
- **Why:** {Reason for choosing this language}

## Framework

- **Name:** {Framework name and version}
- **Why:** {Reason for choosing this framework}
- **Configuration:** {file path to config}

## Build Tool

- **Name:** {Tool name}
- **Why:** {Reason for this choice}
- **Configuration:** {file path to config}

## Testing

- **Framework:** {Jest, JUnit, pytest, etc.}
- **Why:** {Reason for this choice}
- **Configuration:** {file path to config}

## Database

- **Type:** {Database name and version}
- **Why:** {Reason for this choice}
- **ORM:** {If applicable}

## Architecture Pattern

{Layered | Microservices | MVC | Clean Architecture | etc.}

### Pattern Details

- **Style:** {Architectural style}
- **Why:** {Reasoning}
- **Structure:** {How code is organized}

## Frontend (if applicable)

- **Framework:** {React, Angular, Vue, etc.}
- **UI Library:** {Material-UI, Ant Design, custom, etc.}
- **State Management:** {Redux, MobX, Context API, etc.}

## Backend (if applicable)

- **Framework:** {Express, Spring Boot, FastAPI, etc.}
- **API Style:** {REST, GraphQL, gRPC}

## Deployment

- **Platform:** {AWS, Azure, GCP, Docker, Kubernetes, etc.}
- **CI/CD:** {GitHub Actions, Jenkins, GitLab CI, etc.}
- **Configuration:** {file path to deployment configs}

## Development Tools

- **Linter:** {ESLint, Pylint, etc.}
- **Formatter:** {Prettier, Black, etc.}
- **Package Manager:** {npm, yarn, pnpm, maven, etc.}

## Key Architectural Decisions

{Major technical decisions and their rationale}

1. **Decision:** {What was decided}
   - **Why:** {Reasoning}
   - **Trade-offs:** {What was sacrificed}

## Source Locations

- Config files: {paths to key configuration files}
```

## Instructions

1. Identify primary language and version
2. Find framework configuration files
3. Determine build tool setup
4. Locate testing configuration
5. Identify architectural pattern
6. Extract reasons for technology choices (from README, ADRs, comments)
7. Write to `.opencode/skills/{projectName}/tech/SKILL.md`
8. **CRITICAL:** Include YAML front-matter

Focus on WHY technologies were chosen, not just listing them.

Return confirmation when file is written.
