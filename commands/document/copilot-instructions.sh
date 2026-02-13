#!/bin/bash

# Ensure directories exists
mkdir -p .github/prompts
mkdir -p .opencode/skills

# Remove existing instructions file
rm -f .github/copilot-instructions.md

# Copy template
cp ~/.config/opencode/commands/document/copilot-instructions.md.template .github/copilot-instructions.md

link_skill() {
    local category="$1"
    local name="$2"
    if [ -e ".opencode/skills/${category}/${name}/SKILL.md" ]; then
        rm -f .github/prompts/${category}-${name}.md
        ln .opencode/skills/${category}/${name}/SKILL.md .github/prompts/${category}-${name}.md
    fi
}

link_skill "code" "common"
link_skill "code" "naming"
link_skill "code" "standards"
link_skill "code" "style"

link_skill "explore" "api"
link_skill "explore" "asset"
link_skill "explore" "data"
link_skill "explore" "error"
link_skill "explore" "integrations"
