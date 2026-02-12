#!/bin/bash

# Ensure directories exists
mkdir -p .github/prompts
mkdir -p .opencode/skills

# Remove existing instructions file
rm -f .github/copilot-instructions.md

# Copy template
cp ~/.config/opencode/commands/document/copilot-instructions.md.template .github/copilot-instructions.md

# Create hardlink for skills if it doesn't exist
if [ ! -e ".github/prompts/api.md" ]; then
    touch .opencode/skills/explore/api/SKILL.md
    ln .opencode/skills/explore/api/SKILL.md .github/prompts/api.md
fi

if [ ! -e ".github/prompts/assets.md" ]; then
    touch .opencode/skills/explore/assets/SKILL.md
    ln .opencode/skills/explore/assets/SKILL.md .github/prompts/assets.md
fi

if [ ! -e ".github/prompts/data.md" ]; then
    touch .opencode/skills/explore/data/SKILL.md
    ln .opencode/skills/explore/data/SKILL.md .github/prompts/data.md
fi

if [ ! -e ".github/prompts/error.md" ]; then
    touch .opencode/skills/explore/error/SKILL.md
    ln .opencode/skills/explore/error/SKILL.md .github/prompts/error.md
fi

if [ ! -e ".github/prompts/integrations.md" ]; then
    touch .opencode/skills/explore/integrations/SKILL.md
    ln .opencode/skills/explore/integrations/SKILL.md .github/prompts/integrations.md
fi

if [ ! -e ".github/prompts/naming.md" ]; then
    touch .opencode/skills/explore/naming/SKILL.md
    ln .opencode/skills/explore/naming/SKILL.md .github/prompts/naming.md
fi

if [ ! -e ".github/prompts/standards.md" ]; then
    touch .opencode/skills/explore/standards/SKILL.md
    ln .opencode/skills/explore/standards/SKILL.md .github/prompts/standards.md
fi

if [ ! -e ".github/prompts/style.md" ]; then
    touch .opencode/skills/explore/style/SKILL.md
    ln .opencode/skills/explore/style/SKILL.md .github/prompts/style.md
fi
