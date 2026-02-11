#!/bin/bash

# Ensure directories exists
mkdir -p .github
mkdir -p .opencode/skills

# Remove existing instructions file
rm -f .github/copilot-instructions.md

# Copy template
cp ~/.config/opencode/commands/copilot/copilot-instructions.md.template .github/copilot-instructions.md

# Create hardlink for skills if it doesn't exist
if [ ! -e ".github/copilot-skills" ]; then
    ln .opencode/skills .github/copilot-skills/code
fi
