## Frontmatter (every page)

```yaml
---
title:
type: concept | entity | source | quote-collection | story | practice | synthesis
sources: []       # raw/ filenames
related: []       # [[wiki-relative links]]
created: YYYY-MM-DD
updated: YYYY-MM-DD
---
```
Use `[[wiki/relative/path]]` for all internal links (Obsidian-compatible).

## Page Structures
**concepts/** — Definition · Quotes ·  Core Teaching · Nuances · In Practice · Cross-refs
**entities/** — Who/What · Key Teachings · Notable Stories · Quotes · Sources
**sources/** — Metadata · Overview · Ingestion Status · Key Themes · Notable Quotes (with page refs) · Stories extracted · New concepts · Contradictions with other sources
**quotes/** — One file per theme. Each entry:
```
> "Quote text."
> — Speaker, *Source*, p.XX
use relevant backlinks
```
Only include a quote if it is genuinely striking, precise, or irreplaceable — do not add quotes just to populate the section.

**stories/** · Full Narrative · Source · Related Concepts/Entities
Keep stories verbatim from the text. Never paraphrase. Mark them as block quotes in .md syntax.
**practices/** — What it is · How to do it · Why/Purpose · Sources · Related Concepts
**synthesis/** — Free-form analytical pages. Always note date and available sources.

This is a guide. You can add more categories & sections if needed. 

## INGEST
1. Read source from `raw/`
2. Discuss the plan/todo before making any edits. 
3. Instructions: Use links & backlinks heavily — forward-link to related pages and add backlinks from those pages too, even if the target page does not exist yet. Dont add any extra information which can be retrieved during query time. Don't speculatively cross-reference or interpret beyond what the source says. Use the same tone/language as mentioned in the source for filing into the wiki.
4. After creating pages, scan across existing concepts for structural patterns — shared mechanisms, tensions, inversions, or progressions. Flag these in the relevant cross-refs sections or open a `synthesis/` page if the pattern is significant.
5. Create `sources/` page
6. Create/update `concepts/`, `entities/`, `quotes/`, `stories/`, `practices/` pages
7. Update `wiki/index.md`
8. Append to `wiki/log.md`: `## [YYYY-MM-DD] ingest | <Title>`
9. Update `wiki/overview.md` if synthesis meaningfully shifts.

## QUERY
1. Read `wiki/index.md` → identify relevant pages → read them → synthesize with citations
2. Offer to file the answer as a `synthesis/` page
3. Append: `## [YYYY-MM-DD] query | <Question>`
4. Use the same tone as whats used in the source to answer the question. 

## LINT
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
