#!/bin/bash

# Ensure directories exists
mkdir -p .github/skills
mkdir -p .opencode/skills

# Remove existing instructions file
rm -f .github/copilot-instructions.md

# Copy template
cp ~/.config/opencode/commands/document/copilot-instructions.md.template .github/copilot-instructions.md

link_skill() {
    local name="$1"
    if [ ! -e ".github/skills/${name}/" ]; then
        rm -f .github/skills/${name}
        mv .opencode/skills/${name} .github/skills
        ln -s ../../.github/skills/${name} .opencode/skills/${name}
    fi
}

link_skill "code"
link_skill "explore"
