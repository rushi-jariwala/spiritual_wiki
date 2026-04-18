## Frontmatter (every page)

```yaml
---
title:
type: concept | entity | source | quote-collection | analogy-collection | story | practice | synthesis
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
**analogies.md** — One file. Each entry: analogy name · what it illuminates · quote + page ref · backlinks to concepts. Organised by concept cluster.

## INGEST

### Phase 1 — Plan
1. Read the source chapter(s) from `raw/`.
2. **Inventory** every distinct element in the chapter before editing anything:
   - Concepts (new or extensions of existing)
   - Entities (people, places, texts mentioned)
   - Stories / anecdotes / personal testimonies — **every one**, even single-paragraph ones
   - Embedded texts (poems, letters, worksheets, channelled messages, dialogues)
   - Analogies and metaphors
   - Notable quotes
   - Tensions or contradictions with previously ingested material
3. Discuss the plan with the user. Present the inventory — do not skip items silently.

### Phase 2 — Create / Update
4. Create/update `concepts/`, `entities/`, `stories/`, `practices/` pages.
   - **Substantial stories** (multi-paragraph narratives) → own `stories/` page, verbatim as block quotes.
   - **Short anecdotes** (single paragraph) → quoted inline in the relevant `concepts/` page. Never drop them.
   - **Embedded texts** (poems, letters, worksheets, channelled messages) → dedicated page under `stories/`, preserved verbatim.
5. Add new analogies to `wiki/analogies.md`.
6. Create/update `quotes/` pages (one per theme). Don't skip even if quotes also appear in concept pages.
7. Create or update `sources/<book>.md`. **Update the Contradictions / Tensions section** if the chapter has any tension with earlier chapters or other sources — flag as `> [!warning]`.
8. **Backlink pass**: for every new page created, edit at least one related *existing* page to link back to it. Forward-linking inside the new page is not sufficient — old pages must be edited.
9. **Synthesis pass**: scan across existing concepts for structural patterns — shared mechanisms, tensions, inversions, progressions. Significant patterns → open a `synthesis/` page. Minor ones → `> [!tip]` flag in cross-refs.
10. Update `wiki/index.md` — every new concept, entity, story, synthesis, and quote-collection gets an entry.

### Phase 3 — Verify & Log
11. **Run the Verification Checklist below.** Do not skip — most ingestion gaps come from here.
12. Append to `wiki/log.md`: `## [YYYY-MM-DD] ingest | <Title>`
13. Update `wiki/overview.md` if the synthesis meaningfully shifts.

### INGEST Verification Checklist

Re-read the chapter with these questions. If any item fails, fix before marking done.

- [ ] Every story, anecdote, testimony from the chapter is captured — own page OR inline block quote. Nothing silently dropped.
- [ ] Every embedded text (poem, letter, worksheet, channelled message, dialogue) preserved verbatim in a dedicated page.
- [ ] Every new page has at least one existing page edited to link back to it.
- [ ] New analogies added to `wiki/analogies.md` (even brief metaphors like "pendulum of duality").
- [ ] `sources/<book>.md` Contradictions/Tensions section reviewed — any new tensions flagged as `> [!warning]`.
- [ ] Synthesis scan done — cross-source or cross-chapter patterns → `synthesis/` page or `> [!tip]`.
- [ ] `index.md` has entries for every new concept, entity, story, synthesis, quote-collection.
- [ ] Frontmatter `sources:` and `related:` fields updated on any page whose scope has expanded.

### Instructions (apply throughout)
- Use links and backlinks heavily. Forward-link to related pages AND edit those pages to link back, even if a target does not yet exist.
- Don't add information that can be retrieved at query time.
- Don't speculatively cross-reference or interpret beyond what the source says.
- Use the source's tone/language when filing into the wiki.

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
Sections: Overview & Log · Concepts · Entities · Sources · Analogies · Quotes · Stories · Practices · Synthesis

## Log Conventions
```
## [YYYY-MM-DD] <ingest|query|lint|update> | <title>
1–2 sentence summary.
```

Parse recent: `grep "^## \[" wiki/log.md | tail -10`
