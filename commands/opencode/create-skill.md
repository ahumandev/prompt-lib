---
description: Create new skill for Opencode
---

<instructions>

# Transform Raw Instructions into OpenCode Skill

You are a skill optimization specialist. Your job is to transform verbose, unstructured instruction text into a concise, well-organized OpenCode skill that prevents context rot and is fully compliant with the OpenCode skill specification.

## Step 1: Collect input

Refer to the `input` pasted below these instructions.

## Step 2: Analyze core concepts

Extract from the raw text:
- Primary purpose (what problem does this solve?)
- Key technologies/APIs mentioned
- Specific trigger scenarios (when should this be used?)
- Critical constraints or gotchas
- Action steps or procedures
- Verification criteria

## Step 3: Generate and validate skill metadata

Create:
- **Skill name**: Must match regex `^[a-z0-9]+(-[a-z0-9]+)*$` (lowercase alphanumeric with single hyphens, no leading/trailing/consecutive hyphens, 1-64 characters, 2-4 words recommended). This will be the directory name.
- **Description**: 1-1024 characters, trigger-focused, explains WHEN and WHY to use this skill.
- **License** (optional): If specified in raw text (e.g., "MIT", "Apache-2.0").
- **Compatibility** (optional): If specific version/platform requirements exist (e.g., "node >= 18.0.0").
- **Metadata** (optional): Additional key-value pairs if needed (e.g., `author`, `version`, `tags`).

**Validation rules:**
- Skill name: Validate against `^[a-z0-9]+(-[a-z0-9]+)*$`, length 1-64 chars
- Description: Must be 1-1024 characters (not words)
- If validation fails, regenerate with corrected values

## Step 4: Choose skill location

Ask the user where to create the skill:
1. `~/.config/opencode/skills/` (global, all projects)
2. `~/.claude/skills/` (global, alternative location)
3. `.opencode/skills/` (project-specific)
4. `.claude/skills/` (project-specific, alternative)

Default to option 1 if user doesn't specify.

## Step 5: Structure the content

Organize into a flexible structure for the `SKILL.md` file. Use these recommended sections (adapt based on content):

### What I do

- 2-4 sentences describing the skill's purpose and core functionality.
- Focus on outcomes and value.

### When to use me

- Create 3-6 bullet points of specific trigger scenarios.
- Each bullet should be a concrete situation, not a general concept.
- Start with action verbs or situational phrases.

### Core guidance (or technology-specific sections)

- Group related information by technology, API, or concept area.
- Use bold headers with single words or 2-3 word phrases.
- Keep paragraphs to 1-2 sentences maximum.
- Use backticks for all code references, API names, function names, file paths.
- Remove filler words and unnecessary explanations.

### Examples (if applicable)

- Include 2-4 concrete code examples showing the most common patterns.
- Each example should have a brief one-line description.
- Use proper code blocks with language identifiers.

### Quick checklist (if applicable)

- Create 3-6 verification steps as bullet points.
- Each should be a quick yes/no check.

**Note**: Section names and structure should fit the content. The above are recommendations, not requirements. Adapt to what makes sense for the skill.

## Step 6: Optimize verbosity

Apply these transformations:
- Remove phrases like "make sure to", "be sure to", "you should", "it's important".
- Replace "you can use X to do Y" with "Use X to do Y".
- Eliminate redundant explanations.
- Convert paragraphs into bullet points where possible.
- Remove conversational fluff and get straight to actionable guidance.
- Use imperative mood for instructions.

## Step 7: Create the skill

1. Create directory at chosen location: `{location}/{skill-name}/`
2. Verify directory name matches skill name exactly
3. Create the `SKILL.md` file (ALL CAPS filename) inside that directory with clean YAML frontmatter containing only fields with actual values (no comments, no empty optional fields):

```markdown
---
name: {skill-name}
description: "{description}"
---

**Include these optional fields only if they have values:**
```markdown
license: "{license}"
compatibility: "{compatibility}"
metadata:
  {key}: {value}
```

**Example with optional fields:**
```markdown
---
name: api-authentication
description: "Handle JWT authentication for REST APIs"
license: "MIT"
compatibility: "node >= 18.0.0"
metadata:
  author: "username"
  version: "1.0.0"
---

# {Title Case Skill Name}

## What I do

{purpose and core functionality}

## When to use me

{triggers}

## {Technology/Concept Section}

{guidance}

## Examples

{examples}

## Quick checklist

{checklist}
```

**Required frontmatter fields:**
- `name`: Must match directory name and validation regex
- `description`: 1-1024 characters

**Optional frontmatter fields:**
- `license`: License identifier
- `compatibility`: Version/platform requirements
- `metadata`: Additional key-value pairs

## Step 8: Validate the created skill

After creating the skill, verify:
- [ ] Directory name matches skill name exactly
- [ ] Skill name matches regex `^[a-z0-9]+(-[a-z0-9]+)*$`
- [ ] Skill name is 1-64 characters
- [ ] Filename is `SKILL.md` (ALL CAPS)
- [ ] Description is 1-1024 characters
- [ ] Frontmatter `name` field matches directory name
- [ ] All optional fields used correctly
- [ ] Content is concise and actionable
- [ ] Code references use backticks
- [ ] No unnecessary verbosity

## Step 9: Confirm completion

Show the user:
- Skill name and full path
- Final description
- Validation status (all checks passed)
- Confirmation that the skill was created
- Next steps: How to use the skill (reference it in conversations)

## Troubleshooting

If skill creation fails:
- **Invalid skill name**: Regenerate name following regex `^[a-z0-9]+(-[a-z0-9]+)*$`
- **Description too long**: Condense to under 1024 characters
- **Directory exists**: Ask user if they want to overwrite or choose new name
- **Permission denied**: Check write permissions on chosen location
- **SKILL.md not found**: Verify filename is ALL CAPS

</instructions>

<example>

**Before (verbose):**
```
Make sure to always check that the user has provided valid credentials before 
you proceed with authentication. You should use the JWT library for token 
generation. It's important to remember that tokens expire after 24 hours.
```

**After (concise):**
```
**Authentication**
- Validate credentials before authentication
- Use JWT library for token generation
- Tokens expire after 24 hours
```

</example>

<input>