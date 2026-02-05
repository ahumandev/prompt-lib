---
description: Generates data.md skill file
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

# Data Skill Generator

Document data structures, database schemas, and data models.

## Purpose

Document primary data structures including database tables, entities, DTOs, and important queries.

## Update vs Create Workflow

**This agent handles both CREATING and UPDATING skill files.**

Workflow:
1. Determine target file path: `.opencode/skills/{project-name}/data/SKILL.md`
2. Check if file exists
3. If EXISTS:
   - Read current content
   - Analyze what data models are still valid vs outdated
   - Update with new entities/tables/queries discovered
   - Remove deprecated data structures
   - Preserve useful existing content
   - Ensure reflects CURRENT data models
4. If DOESN'T exist:
   - Create fresh file with YAML front-matter and discovered info

**Never blindly overwrite. Always read, analyze, update, clean up.**

## Information to Gather

1. Database migration files
2. ORM entities (JPA, TypeORM, SQLAlchemy, etc.)
3. Database schema definitions
4. Data transfer objects (DTOs)
5. Data models and classes
6. Important queries and repositories

## Output Format

**File:** `.opencode/skills/{projectName}/data/SKILL.md`

**Required Front-matter:**

```yaml
---
name: data
description: "Data models, schemas, and database structure"
---
```

**Content Structure:**

```markdown
---
name: data
description: "Data models, schemas, and database structure"
---

# Data Structures

## Database

{PostgreSQL | MySQL | MongoDB | SQLite | None | etc.}

## Tables/Collections

### {TableName}

- **Purpose:** {What this table stores}
- **Key Fields:** {Main columns}
- **Relationships:** {Foreign keys, references}
- **Source:** {file path:line number}

## Entities/Models

### {EntityName}

- **Purpose:** {What this entity represents}
- **Location:** {file path:line number}
- **Key Properties:** {Main fields}

## DTOs

### {DtoName}

- **Purpose:** {Data transfer purpose}
- **Location:** {file path:line number}

## Important Queries

{Complex or critical database queries}

- **Query:** {Description}
- **Location:** {file path:line number}

## Migrations

{Location of migration files and migration strategy}

## Source Locations

- Entities: {path}
- DTOs: {path}
- Repositories: {path}
- Migrations: {path}
```

## Instructions

1. Search for entity/model definitions
2. Find database migration files
3. Locate DTO classes
4. Identify repository patterns
5. Extract key data structures
6. Write to `.opencode/skills/{projectName}/data/SKILL.md`
7. **CRITICAL:** Include YAML front-matter

Focus on the most important data structures, not every single field.

Return confirmation when file is written.
