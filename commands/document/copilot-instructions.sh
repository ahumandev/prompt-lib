#!/bin/bash

# Ensure directories exists
mkdir -p .github/prompts
mkdir -p .opencode/skills

# Remove existing instructions file
rm -f .github/copilot-instructions.md

# Copy template
cp ~/.config/opencode/commands/document/copilot-instructions.md.template .github/copilot-instructions.md

# Create hardlink for skills if it doesn't exist
if [ ! -e ".github/prompts/naming.md" ]; then
    touch .opencode/skills/code/naming/SKILL.md
    ln .opencode/skills/code/naming/SKILL.md .github/prompts/naming.md
fi
