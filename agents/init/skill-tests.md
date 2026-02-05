---
description: Generates tests.md skill file
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

# Tests Skill Generator

Document testing strategy and framework.

## Update vs Create Workflow

**This agent handles both CREATING and UPDATING skill files.**

Workflow:
1. Determine target file path: `.opencode/skills/{project-name}/tests/SKILL.md`
2. Check if file exists
3. If EXISTS:
   - Read current content
   - Analyze what testing info is still valid vs changed
   - Update with new test frameworks/patterns discovered
   - Remove deprecated testing documentation
   - Preserve useful existing content
   - Ensure reflects CURRENT testing strategy
4. If DOESN'T exist:
   - Create fresh file with YAML front-matter and discovered info

**Never blindly overwrite. Always read, analyze, update, clean up.**

## Purpose

Document testing frameworks, test structure, and rules for creating new tests.

## Information to Gather

1. Testing frameworks used
2. Test directory structure
3. Types of tests (unit, integration, e2e)
4. Test naming conventions
5. Mocking strategies
6. Code coverage requirements
7. How to run tests
8. Test file patterns

## Output Format

**File:** `.opencode/skills/{projectName}/tests/SKILL.md`

**Required Front-matter:**

```yaml
---
name: tests
description: "Testing strategy and framework"
---
```

**Content Structure:**

```markdown
---
name: tests
description: "Testing strategy and framework"
---

# Testing Strategy

## Testing Framework

- **Unit Tests:** {Jest, JUnit, pytest, etc.}
- **Integration Tests:** {Framework if different}
- **E2E Tests:** {Cypress, Playwright, Selenium, etc.}

## Test Structure

### Directory Layout

\`\`\`
{Show test directory structure}
tests/
unit/
integration/
e2e/
\`\`\`

### Test File Naming

- **Pattern:** {*.test.ts, *Test.java, test\_\*.py, etc.}
- **Location:** {Co-located with source | Separate test directory}

## Test Types

### Unit Tests

- **Purpose:** {What they test}
- **Location:** {Where they live}
- **Run command:** `{command to run unit tests}`

### Integration Tests

- **Purpose:** {What they test}
- **Location:** {Where they live}
- **Run command:** `{command to run integration tests}`

### E2E Tests

- **Purpose:** {What they test}
- **Location:** {Where they live}
- **Run command:** `{command to run e2e tests}`

## Mocking

- **Library:** {jest.mock, Mockito, unittest.mock, etc.}
- **Strategy:** {How mocking is approached}

## Code Coverage

- **Tool:** {Coverage tool used}
- **Target:** {Coverage percentage goal}
- **Run command:** `{command to check coverage}`

## Test Configuration

- **Config file:** {jest.config.js, pytest.ini, etc.}
- **Location:** {file path}

## Rules for New Tests

1. **Co-location:** {Tests should be next to source files | in separate directory}
2. **Naming:** {Test file naming pattern}
3. **Structure:** {Arrange-Act-Assert | Given-When-Then | etc.}
4. **Mocking:** {When to mock dependencies}
5. **Coverage:** {Minimum coverage requirements}

## Running Tests

### All Tests

\`\`\`bash
{command to run all tests}
\`\`\`

### Specific Test

\`\`\`bash
{command to run specific test file}
\`\`\`

### Watch Mode

\`\`\`bash
{command for watch mode if available}
\`\`\`

### CI Mode

\`\`\`bash
{command used in CI pipeline}
\`\`\`

## Source Locations

- Test config: {path}
- Unit tests: {path}
- Integration tests: {path}
- E2E tests: {path}
```

## Instructions

1. Find test configuration files
2. Locate test directories
3. Identify testing frameworks
4. Determine test naming patterns
5. Extract coverage requirements
6. Document test running commands
7. Write to `.opencode/skills/{projectName}/tests/SKILL.md`
8. **CRITICAL:** Include YAML front-matter

Be specific about WHERE tests live and HOW to run them.

Return confirmation when file is written.
