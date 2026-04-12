## Frontmatter (every page)

```yaml
---
title:
type: concept | entity | source | quote-collection | story | practice | synthesis
tags: []
sources: []       # raw/ filenames
related: []       # [[wiki-relative links]]
created: YYYY-MM-DD
updated: YYYY-MM-DD
---
```

Use `[[wiki/relative/path]]` for all internal links (Obsidian-compatible).

## Page Structures
**concepts/** — Definition · Core Teaching · Nuances · In Practice · Quotes · Cross-refs
**entities/** — Who/What · Role in Tradition · Key Teachings · Notable Stories · Quotes · Sources
**sources/** — Metadata · Overview · Key Themes · Notable Quotes (with page refs) · Stories extracted · New concepts · Contradictions with other sources
**quotes/** — One file per theme. Each entry:
```
> "Quote text."
> — Speaker, *Source*, p.XX
use relevant backlinks
```
**stories/** · Full Narrative · Source · Related Concepts/Entities
**practices/** — What it is · How to do it · Why/Purpose · Sources · Related Concepts
**synthesis/** — Free-form analytical pages. Always note date and available sources.

## Operations

### INGEST
1. Read source from `raw/`
2. Discuss key takeaways with user before writing anything. 
3. Create `sources/` page
4. Create/update `concepts/`, `entities/`, `quotes/`, `stories/`, `practices/` pages
5. Update `wiki/index.md`
6. Append to `wiki/log.md`: `## [YYYY-MM-DD] ingest | <Title>`
7. Update `wiki/overview.md` if synthesis meaningfully shifts.
8. Use backlinks heavily - even if the page is not created yet.
9. Dont add any extra information which can be retrieved during query time. 
10. Create a plan/todo before writing any file.

One source may touch 10–20 pages. Always cross-reference.

### QUERY
1. Read `wiki/index.md` → identify relevant pages → read them → synthesize with citations
2. Offer to file the answer as a `synthesis/` page
3. Append: `## [YYYY-MM-DD] query | <Question>`
4. Use the same tone as whats used in the source to answer the question. 

### LINT
Find: orphan pages · missing concept pages · contradictions · stale claims · gaps
Suggest: new questions · new sources
Append: `## [YYYY-MM-DD] lint | Health check`

## Style
- Use Hingori's writing style & tone when referring to his books. If its not his book, use the relevant style from the source. Cite sources with filename + page/section.
- Specific over general. Flag uncertainty with `> [!question]`, contradictions with `> [!warning]`, key insights with `> [!tip]`.
- Do not invent content.

## Index Conventions

Each entry: `- [[path/page|Title]] — one-line description`
Sections: Overview & Log · Concepts · Entities · Sources · Quotes · Stories · Practices · Synthesis

## Log Conventions

```
## [YYYY-MM-DD] <ingest|query|lint|update> | <title>
1–2 sentence summary.
```

Parse recent: `grep "^## \[" wiki/log.md | tail -10`
