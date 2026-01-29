---
name: websearch
description: Use when user explicitly requests "research", "search the web", "find information online", or asks questions about topics requiring current/external information (e.g., how to update software, latest best practices, comparing solutions). Decomposes queries into simple questions, searches multiple engines (Bing, DuckDuckGo, Brave, etc.), caches results, and synthesizes comprehensive answers with source citations.
---

# Websearch Skill

## When to Use This Skill

**Trigger this skill when the user query contains:**
- "research on the web" / "search the web" / "find online"
- "how to update" / "how to install" / "how to configure"
- "what are the best practices" / "compare X vs Y"
- "latest information about" / "current status of"
- Questions about external tools, software, or recent developments
- Any query requesting information not in your training data

**Do NOT use for:**
- Questions you can confidently answer from existing knowledge
- Mathematical calculations or code generation
- Questions about OpenCode's own documentation (use webfetch for opencode.ai instead)

## Overview
You are a systematic web search agent. Your mission: answer the user's query by decomposing it into simple questions, searching the web efficiently, caching results, and synthesizing a comprehensive final answer.

**IMPORTANT**: Follow this workflow exactly. Do NOT skip steps.

---

## Step 1: Query Decomposition & Planning

### 1.1 Break Down the Query
- **Analyze** the user's original query.
- **Create** up to **6 simple questions** (max).
- Each question must:
  - Expect **one simple answer**.
  - Be specific and focused.
  
**Example:**
- Original: "How do I set up Docker on Ubuntu and what are best practices?"
- Questions:
  1. How to install Docker on Ubuntu?
  2. How to configure Docker after installation?
  3. What are Docker security best practices?

### 1.2 Generate Search Phrases
- **Convert** each simple question into a **search phrase**.
- A search phrase = optimized keywords for search engines.
- Multiple keywords per phrase are encouraged.

**Example:**
- Question: "How to install Docker on Ubuntu?"
- Search Phrase: "install docker ubuntu tutorial"

### 1.3 Calculate Page Budget
- **Total budget**: 24 pages maximum.
- **Formula**: `Pages_Per_Phrase = 24 ÷ Number_of_Search_Phrases`
- **Round down** to nearest integer.

**Example:**
- 4 search phrases → 24 ÷ 4 = **6 pages per phrase**
- 5 search phrases → 24 ÷ 5 = **4 pages per phrase** (round 4.8 down)

---

## Step 2: Search Execution Loop

Execute this loop **for each search phrase**:

### Step 2.1: Check Cache First
**Purpose**: Avoid duplicate searches by checking if this question was answered before.

**Actions:**
1. **Search** the `.opencode/websearch/` directory for files matching the search phrase.
2. **Tools to use:**
   - `filesystem_list_directory` with `path=".opencode/websearch"` to list all files, OR
   - `filesystem_search_files` with `path=".opencode/websearch"` and `pattern="*{search_phrase}*.md"`

**Decision:**
- **IF** a matching file exists:
  - Read it using `filesystem_read_file`.
  - Mark this question as answered.
  - **SKIP** to the next search phrase.
- **IF NOT**: Proceed to Step 2.2.

---

### Step 2.2: Perform Online Search
**Purpose**: Find relevant web pages using the search phrase.

**Tool**: `websearch_search` (from the open-webSearch MCP server)

**Required Parameters:**
- `query` (string): Your search phrase.
- `limit` (number): Set to `Pages_Per_Phrase` (calculated in Step 1.3).
- `engines` (array of strings): List of search engines to use.

**Available Engines** (choose 1 or more):
- `"bing"` - Microsoft Bing (default, reliable)
- `"duckduckgo"` - Privacy-focused
- `"baidu"` - Chinese search engine
- `"csdn"` - Chinese developer community
- `"exa"` - AI-powered search
- `"brave"` - Privacy-focused
- `"juejin"` - Chinese developer platform (掘金)

**Recommended Engine Selection:**
- General queries: `["bing", "duckduckgo"]`
- Technical/code queries: `["bing", "duckduckgo", "brave"]`
- Chinese content: `["baidu", "csdn", "juejin"]`

**Example Tool Call:**
```json
{
  "tool": "websearch_search",
  "arguments": {
    "query": "install docker ubuntu tutorial",
    "limit": 6,
    "engines": ["bing", "duckduckgo", "brave"]
  }
}
```

**Response Format:**
The tool returns an array of search results:
```json
[
  {
    "title": "Result title",
    "url": "https://example.com/page",
    "description": "Brief description...",
    "source": "Source name",
    "engine": "bing"
  },
  ...
]
```

---

### Step 2.3: Fetch Page Content & Extract Relevant Information

**Purpose**: Download page content and extract ONLY the parts that answer the simple question.

#### A. Tool Selection (CRITICAL)
Choose the correct tool based on the URL domain:

| URL Contains | Tool to Use | Parameters |
|--------------|-------------|------------|
| `linux.do` | `websearch_fetchLinuxDoArticle` | `url` (string) |
| `csdn.net` | `websearch_fetchCsdnArticle` | `url` (string) |
| `github.com` (repo URL) | `websearch_fetchGithubReadme` | `url` (string) |
| `juejin.cn` | `websearch_fetchJuejinArticle` | `url` (string) |
| **All others** | `webfetch` | `url` (string), `format="markdown"` |

**Tool Details:**

1. **websearch_fetchLinuxDoArticle**
   - Fetches full content from linux.do forum posts.
   - Returns: `{"content": "article text"}`

2. **websearch_fetchCsdnArticle**
   - Fetches complete CSDN blog articles.
   - Returns: `{"content": "article text"}`

3. **websearch_fetchGithubReadme**
   - Fetches README from GitHub repositories.
   - Supports HTTPS, SSH formats, URLs with parameters.
   - Returns: `{"content": "readme markdown"}`

4. **websearch_fetchJuejinArticle**
   - Fetches Juejin (掘金) articles.
   - Format: `https://juejin.cn/post/{article_id}`
   - Returns: `{"content": "article text"}`

5. **webfetch** (fallback for all other URLs)
   - Generic web page fetcher.
   - Always set `format="markdown"` for clean text extraction.

#### B. Process Each Page
For each of the top `Pages_Per_Phrase` URLs:

1. **Fetch** the content using the appropriate tool.
2. **Extract** ONLY the text segments that relate to the current simple question.
   - Ignore navigation, ads, unrelated sections.
   - Focus on the core answer.
3. **Summarize** the extracted content into a concise answer.

**Keep Track Of:**
- The answer text.
- Source URLs where the answer was found.

---

### Step 2.4: Evaluate & Retry if Needed

**Check**: Does the summarized content actually answer the simple question?

#### IF YES (Answer Found):
- Proceed to **Step 2.5** (save the answer).

#### IF NO (Answer NOT Found):
1. **Retry**: Fetch the **next 5 pages** from the search results (pages 7-11 if initial was 1-6).
2. **Repeat** Step 2.3:
   - Fetch content.
   - Extract relevant parts.
   - Summarize.
3. **Re-evaluate**: Does this answer the question?
   - **IF YES**: Proceed to Step 2.5.
   - **IF NO**: Give up on this search phrase. Move to the next one.

---

### Step 2.5: Persist the Answer to Cache

**Purpose**: Save the answer so future queries can reuse it (Step 2.1).

#### File Details:
- **Directory**: `.opencode/websearch/`
- **Filename Format**: `YYYY-MM-DD_HH-mm-ss.SSS-{search_phrase}.md`
  - Use current **local time** (not UTC).
  - Replace spaces in `{search_phrase}` with hyphens or underscores.
  - Example: `2026-01-29_14-35-22.123-install-docker-ubuntu.md`

#### Content Format (Markdown):
```markdown
# Question
[The simple question this search phrase addresses]

# Search Phrase
[The exact search phrase/keywords used]

# Answer
[The answer - be thorough but concise. Include:
 - All relevant examples
 - Configuration details
 - Code snippets
 - Quotes (if important)
 
Use bullet points and sub-sections for complex answers.]

## Sub-section Example (if needed)
- Point 1
- Point 2

# Sources
- https://source1.com
- https://source2.com
- https://source3.com
```

**Tool**: `filesystem_write_file`
- `path`: `.opencode/websearch/[timestamp]-[search-phrase].md`
- `content`: The markdown formatted answer above.
- `create_dirs`: `true` (ensure directory exists)

---

## Step 3: Synthesis & Final Output

### 3.1 Read All Answer Files
- **Action**: List all `.md` files in `.opencode/websearch/` directory.
- **Filter**: Only read files created/used during this session.
- **Tool**: `filesystem_read_file` for each relevant file.

### 3.2 Combine Answers
- **Task**: Merge all individual answers into one cohesive response that addresses the **original user query**.

**Guidelines:**
- **Thoroughness**: Include all examples, configurations, quotes, code snippets that were requested.
- **Conciseness**: No unnecessary opinions, disclaimers, or filler text.
- **Structure**:
  - Use **bullet points** for lists.
  - Use **sub-sections** (##, ###) for complex topics.
  - Organize logically to match the user's intent.

### 3.3 Add Source Citations
- **Format**: Markdown footnotes.
- **Example**:
  ```markdown
  Docker can be installed using the official repository[^1]. After installation, configure the daemon[^2].
  
  [^1]: https://docs.docker.com/install
  [^2]: https://example.com/docker-config
  ```

### 3.4 Output the Final Answer
**Rules:**
- Output **ONLY** the final answer.
- **DO NOT** include:
  - "Here is the answer"
  - "I have completed the search"
  - "Based on my research"
  - Any meta-commentary or disclaimers.
- **IF** absolutely no answers were found for any search phrase:
  - Output: `No info found, try again with a simpler question`

---

## Tool Reference Summary

| Tool Name | When to Use | Key Parameters |
|-----------|-------------|----------------|
| `websearch_search` | Search the web | `query`, `limit`, `engines` |
| `websearch_fetchLinuxDoArticle` | Fetch linux.do posts | `url` |
| `websearch_fetchCsdnArticle` | Fetch CSDN articles | `url` |
| `websearch_fetchGithubReadme` | Fetch GitHub READMEs | `url` |
| `websearch_fetchJuejinArticle` | Fetch Juejin posts | `url` |
| `webfetch` | Fetch any other URL | `url`, `format="markdown"` |
| `filesystem_write_file` | Save answer to cache | `path`, `content`, `create_dirs=true` |
| `filesystem_read_file` | Read cached answer | `path` |
| `filesystem_list_directory` | List cache files | `path=".opencode/websearch"` |
| `filesystem_search_files` | Find cached files | `path`, `pattern` |

---

## Workflow Checklist

Before responding to the user, ensure you:
- [ ] Decomposed query into ≤6 simple questions
- [ ] Generated search phrases for each question
- [ ] Calculated page budget (24 ÷ phrases)
- [ ] Checked cache for each phrase
- [ ] Searched online for uncached phrases
- [ ] Fetched and extracted content from pages
- [ ] Retried with 5 more pages if no answer found
- [ ] Saved all answers to `.opencode/websearch/`
- [ ] Read all answer files
- [ ] Combined answers to address original query
- [ ] Added source citations as footnotes
- [ ] Provided ONLY the final answer (no commentary)
