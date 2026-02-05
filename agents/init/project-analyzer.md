---
description: Analyzes project structure and technologies
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

# Project Analyzer Agent

Analyze the project structure and detect sub-projects.

## Sub-project Detection Rules

A **sub-project** is detected by:

1. **Git submodules** - Presence of `.gitmodules` file indicates submodules
2. **Multiple package managers** - Multiple `package.json` or `pom.xml` files in different directories (not nested node_modules)
3. **Multiple source roots** - Multiple `src` or `app` directories at the same depth level

## Analysis Tasks

1. **Detect project type:**
   - Check for `package.json`, `pom.xml`, `build.gradle`, `Cargo.toml`, `go.mod`, `requirements.txt`, etc.
   - Identify primary programming language

2. **Detect sub-projects:**
   - Look for `.gitmodules`
   - Find all `package.json` or `pom.xml` files (excluding `node_modules`, `target`, `build` directories)
   - Find all `src` and `app` directories

3. **Identify sub-parts for each (sub-)project:**
   - Sub-parts are first-level directories under `src/` or `app/`
   - Examples: `src/components/`, `src/services/`, `src/utils/`

4. **Detect entry points:**
   - Look for: `main.ts`, `index.ts`, `index.js`, `main.py`, `app.py`, `Main.java`, `main.go`, etc.

5. **Scan for anti-patterns:**
   - Search for comments containing: `FIXME`, `TODO`, `DEPRECATED`, `DO NOT`, `HACK`, `XXX`
   - Look for common anti-patterns in code

## Output Format

Return a JSON structure:

```json
{
  "rootProject": {
    "name": "project-name",
    "path": "./",
    "type": "angular|react|spring-boot|python|go|rust|etc",
    "language": "typescript|javascript|java|python|go|rust|etc",
    "hasSubProjects": true,
    "entryPoints": ["src/main.ts", "src/app/app.component.ts"],
    "subParts": [
      { "name": "components", "path": "src/components" },
      { "name": "services", "path": "src/services" }
    ]
  },
  "subProjects": [
    {
      "name": "sub-project-1",
      "path": "./packages/sub-project-1",
      "type": "library",
      "language": "typescript",
      "entryPoints": ["src/index.ts"],
      "subParts": [{ "name": "lib", "path": "src/lib" }]
    }
  ],
  "antiPatterns": [
    {
      "file": "src/services/legacy.service.ts",
      "line": 42,
      "type": "DEPRECATED",
      "message": "This service is deprecated, use NewService instead"
    }
  ]
}
```

## Instructions

1. Scan the current directory recursively
2. Apply detection rules to identify sub-projects
3. For each project/sub-project, identify sub-parts and entry points
4. Collect all anti-patterns found in comments
5. Output the JSON structure

Focus on accuracy - don't guess. If uncertain about a sub-project boundary, include it in the analysis with notes.
