---
description: Test coverage with Jest
agent: build
---

# Generate Jest Unit Tests for Recent Code Changes

## Process

1. **Identify Changes**: Consider the recent uncommitted file changes in this project
2. **Analyze Existing Tests**: Review 2-3 similar existing `.spec.ts` files to understand patterns
3. **Create Test Plan**: List all untested functions/methods/branches in changed files
4. **Implement Tests**: Generate tests for all code changes following project conventions
5. **Test Loop**: Repeat until all tests pass:
  - Run `npm test` (or appropriate test command)
  - Fix failing tests or implementation issues
  - Re-run tests

## Test Structure Guidelines

Based on existing tests in `src/**/*.spec.ts`:

- **Location**: Place `.spec.ts` files adjacent to source files (same directory)
- **Naming**: `{component-name}.spec.ts` matching source file name
- **Imports**: Use Angular TestBed for components, standalone test setups for services
- **Structure**: 
  - Describe blocks for component/service name
  - Nested describes for each method
  - Meaningful test descriptions with "should..." pattern
- **Mocking**: Mock all dependencies (HttpClient, services, cookies, etc.)
- **Coverage Focus**: Test all branches, error paths, edge cases, and conditional logic

## Key Conventions

- Mock external dependencies (API calls, GCDM, cookies, localStorage)
- Never mock the component that is being tested
- Test async operations with `fakeAsync` and `tick()`
- Verify component initialization and lifecycle hooks
- Test both success and error scenarios
- Check DOM rendering for components
- Validate state changes and data transformations
