# Websearch Skill

A comprehensive OpenCode skill for systematic web research that decomposes complex queries into simple questions, searches multiple sources efficiently, caches results, and synthesizes thorough answers with proper citations.

## Features

- **Query Decomposition**: Breaks complex queries into up to 6 simple questions
- **Multi-Engine Search**: Searches across Bing, DuckDuckGo, Brave, Baidu, CSDN, Juejin, and more
- **Smart Page Budget**: Distributes 24 pages across search phrases intelligently
- **Result Caching**: Stores answers in `.opencode/websearch/` to avoid duplicate searches
- **Specialized Fetchers**: Uses optimal tools for linux.do, CSDN, GitHub READMEs, and Juejin
- **Answer Synthesis**: Combines multiple sources into comprehensive, well-cited responses
- **Automatic Retry**: Fetches additional pages if initial results don't answer the question

## Prerequisites

### Required MCP Server

This skill requires the `open-webSearch` MCP server. Add it to your `~/.config/opencode/opencode.jsonc`:

```jsonc
{
  "mcp": {
    "websearch": {
      "type": "local",
      "command": [
        "npx",
        "-y",
        "open-websearch@latest"
      ],
      "env": {
        "MODE": "stdio"
      }
    }
  }
}
```

**With Proxy (for restricted regions):**
```jsonc
{
  "mcp": {
    "websearch": {
      "type": "local",
      "command": [
        "env",
        "USE_PROXY=true",
        "PROXY_URL=http://localhost:7890",
        "MODE=stdio",
        "npx",
        "-y",
        "open-websearch"
      ]
    }
  }
}
```

### OpenCode Skillful Plugin

This skill uses the OpenCode Skillful plugin for lazy loading. Install it:

```jsonc
{
  "plugin": ["@zenobius/opencode-skillful"]
}
```

## Usage

### Loading the Skill

```bash
# Find the skill
skill_find "websearch"

# Load it into your session
skill_use "websearch"
```

### Example Queries

```
User: What are the best practices for Docker security in production?

User: How do I configure Nginx as a reverse proxy with SSL?

User: Compare the performance of Redis vs Memcached for session storage
```

The skill will:
1. Break down your query into simple questions
2. Search multiple engines for each question
3. Extract relevant information from top pages
4. Cache answers for future queries
5. Synthesize a comprehensive final answer with citations

## Workflow

1. **Decomposition**: Query → Simple questions (max 6)
2. **Keywords**: Questions → Search phrases
3. **Budgeting**: Calculate pages per phrase (24 total ÷ phrases)
4. **Search Loop** (per phrase):
   - Check cache (`.opencode/websearch/`)
   - Search online if not cached
   - Fetch top N pages (N = 24 ÷ phrases)
   - Extract relevant content
   - Retry with 5 more pages if answer not found
   - Save answer to cache
5. **Synthesis**: Combine all answers → Final response with footnotes

## Cache Management

Answers are stored in `.opencode/websearch/` with the format:
```
YYYY-MM-DD_HH-mm-ss.SSS-{search-phrase}.md
```

Example:
```
2026-01-29_14-35-22.123-docker-security-best-practices.md
```

To clear the cache:
```bash
rm -rf .opencode/websearch/*.md
```

## Search Engine Selection

The skill intelligently selects engines based on query type:

- **General queries**: Bing, DuckDuckGo
- **Technical/code**: Bing, DuckDuckGo, Brave
- **Chinese content**: Baidu, CSDN, Juejin

## Specialized Content Fetchers

The skill uses optimized tools for specific domains:

| Domain | Tool | Notes |
|--------|------|-------|
| `linux.do` | `websearch_fetchLinuxDoArticle` | Forum posts |
| `csdn.net` | `websearch_fetchCsdnArticle` | Chinese developer blogs |
| `github.com` | `websearch_fetchGithubReadme` | Repository READMEs |
| `juejin.cn` | `websearch_fetchJuejinArticle` | Chinese tech articles |
| All others | `webfetch` | Generic markdown extraction |

## Output Format

The skill returns **only** the final answer with:
- Thorough but concise information
- Bullet points for complex topics
- Code examples and configurations
- Markdown footnote citations

No meta-commentary or disclaimers are included.

## Troubleshooting

### No Results Found

If you get "No info found, try again with a simpler question":
- Break down your query into smaller, more specific questions
- Try more common terminology
- Check if the cache has outdated information and clear it

### Proxy Issues

If searches are failing in restricted regions:
1. Ensure your proxy is running
2. Update `PROXY_URL` in the MCP configuration
3. Add `USE_PROXY=true` environment variable

### Tool Not Found

If websearch tools are unavailable:
1. Verify the MCP server is configured correctly
2. Restart OpenCode to reload MCP servers
3. Test with: `npx -y open-websearch@latest` manually

## Configuration

The skill works with default settings, but you can customize:

- **Cache directory**: Modify `.opencode/websearch/` paths in the skill
- **Page budget**: Change the 24-page limit in Step 1.3
- **Retry count**: Adjust the 5-page retry in Step 2.4
- **Max questions**: Modify the 6-question limit in Step 1.1

## Architecture

```
User Query
    ↓
Decompose → Simple Questions (max 6)
    ↓
Generate → Search Phrases
    ↓
Calculate → Pages per Phrase (24 ÷ phrases)
    ↓
For Each Search Phrase:
    ├─ Check Cache (.opencode/websearch/)
    ├─ Search Online (if not cached)
    ├─ Fetch Pages (specialized tools)
    ├─ Extract Relevant Content
    ├─ Retry if Needed (5 more pages)
    └─ Save to Cache
    ↓
Synthesize → Final Answer + Citations
    ↓
Output → Clean answer only
```

## References

- [open-webSearch MCP Server](https://github.com/Aas-ee/open-webSearch)
- [OpenCode Skillful Plugin](https://github.com/zenobi-us/opencode-skillful)
- [Anthropic Agent Skills Specification](https://github.com/anthropics/skills)
