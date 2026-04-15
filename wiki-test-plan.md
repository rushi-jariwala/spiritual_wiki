# Wiki Test Plan
*spiritual_wiki — Karma Sutra (single source, fully ingested)*
*Drafted: 2026-04-16*

---

## Overview

Six test suites covering structural integrity, source fidelity, link health, query performance, coverage, and style. Run them in this order — earlier suites surface problems that would distort later results.

Current scope: 1 source (Karma Sutra, Ch.1–9), 25 concepts, 4 entities, 15 stories, 3 practices, 3 quote files, 1 analogies file, 2 synthesis pages.

---

## Suite 1 — Structural Integrity (Mechanical)

**Goal:** Confirm every page is well-formed and correctly registered.

**Checks:**

1. **Frontmatter completeness** — Every `.md` file in `concepts/`, `entities/`, `sources/`, `stories/`, `practices/`, `synthesis/` has all required frontmatter keys: `title`, `type`, `sources`, `related`, `created`, `updated`. Flag any missing or mis-typed `type` value against the allowed set (concept | entity | source | quote-collection | analogy-collection | story | practice | synthesis).

2. **Index completeness** — Every page that exists on disk has a corresponding entry in `wiki/index.md`. Conversely, every link in `index.md` resolves to an actual file. Check both directions.

3. **Log coverage** — Every ingest/update event visible in the file system has a corresponding entry in `wiki/log.md`. No silent edits.

4. **Stubs flagged** — Pages marked `*(stub)*` in index.md are known and intentional. Verify each one is still a stub on disk (hasn't been filled without the index being updated) and vice versa.

**Pass criterion:** Zero unregistered pages, zero broken index entries, zero missing frontmatter keys.

---

## Suite 2 — Link Health

**Goal:** Confirm the wiki is a web, not a collection of silos.

**Checks:**

1. **No broken `[[wiki links]]`** — Collect every `[[...]]` link across all pages. Resolve each against the file system. List any that point to a path that doesn't exist yet.

2. **Orphan detection** — List any page that has zero inbound links from other pages. Cross-reference: is it in the index? If yes, not a true orphan — flag as index-only. If no, it's an orphan.

3. **Backlink symmetry** — For any forward-link from page A to page B, check that page B has a reciprocal mention or backlink to A (either in `related` frontmatter or in body text). Sample 10 random concept→concept links for this check.

4. **`related` frontmatter vs body links** — Check that the `related:` list is not the only form of cross-referencing (i.e., that at least one in-body `[[link]]` exists per concept page).

**Pass criterion:** All `[[links]]` resolve; no true orphans; backlink symmetry holds on sampled pairs.

---

## Suite 3 — Source Fidelity

**Goal:** Confirm that what was ingested faithfully represents the raw source — no paraphrase, no invention, no dropped stories.

**Checks (requires access to Karma Sutra PDF/text):**

1. **Story verbatim check** — Pick 5 stories at random from `stories/`. Find the corresponding passage in the source. Verify the text matches verbatim (the style guide requires this for stories). Flag any paraphrasing or compression.

2. **Quote accuracy** — Pick 10 quotes from `quotes/karma.md`, `quotes/guru.md`, `quotes/maya.md`. Verify exact wording and page numbers against the source.

3. **Concept attribution** — Pick 5 concepts. For each, verify that the source citations (filename + page) in the page body are accurate and traceable.

4. **Story census** — Manually count all named stories/anecdotes in Karma Sutra Ch.1–9. Compare against the 15 story pages in the wiki. Identify any that were not ingested, and decide whether they meet the threshold for inclusion.

5. **No invented content** — For any claim or nuance in a concept page that cannot be traced to a quote or citation, flag it as potentially invented.

**Pass criterion:** Stories verbatim; quotes exact with correct page refs; no traceable invented content.

---

## Suite 4 — Query Performance

**Goal:** Confirm the wiki actually helps you think — that it surfaces the right material and synthesises faithfully.

**Test questions (run each as a live QUERY against the wiki, then grade):**

| # | Question | Expected pages to surface | Grading criteria |
|---|---|---|---|
| Q1 | What is karma, and how does it differ from kriyaman, sanchit, and prarabdh? | `concepts/karma`, `kriyaman-karma`, `sanchit-karma`, `prarabdh-karma` | All 4 surfaced; distinctions accurate; no conflation |
| Q2 | Why does guilt increase karma rather than reduce it? | `concepts/doer-ship`, `concepts/non-doership` | Both surfaced; guilt-as-doer-ship mechanism explained accurately |
| Q3 | What are the 5 categories of negative karma? | `concepts/negative-karma` | All 5 present; encashment rule included |
| Q4 | What does a sadguru actually do, and why is finding one described as a lottery? | `concepts/guru-disciple`, `entities/mahaguru`, `analogies` | Lottery analogy surfaced; umbrella metaphor present |
| Q5 | How do samskars form, persist, and get erased? | `concepts/samskars`, `concepts/asisa`, `concepts/vasna`, `concepts/kaarna-sharir`, `synthesis/samskar-loop` | Full loop (formation → storage → fructification → rebirth → break) represented |
| Q6 | What is non-doership, and how does it relate to moksha? | `concepts/non-doership`, `concepts/moksha`, `concepts/attitude-to-deeds` | Three-stage attitude map present; non-doership as highway to moksha cited |
| Q7 | Give me a story that illustrates positive karma compounding across generations. | `stories/grandfather-education-multiplier`, `stories/fudge-lady-clinic-lonavala` | At least one surfaced verbatim |
| Q8 | What is pitra peeda and how can it be remediated? | `concepts/pitra-peeda`, `stories/pitra-peeda-sons-birth` | Three astral worlds present; shraadh remediation present; story surfaced |
| Q9 | How do the gunas, koshas, and non-doership fit together as a single inward movement? | `synthesis/inner-frameworks-convergence` | Synthesis page surfaced; four-framework convergence articulated |
| Q10 | What practical tools does the book give for reducing karmic debt? | `practices/karmic-worksheet`, `practices/tapasya`, `practices/seva` | All 3 practices surfaced; CCTV principle and scoring system mentioned |

**Grading scale per question:** Pass / Partial / Fail  
**Suite pass criterion:** ≥8/10 Pass, zero Fails.

---

## Suite 5 — Coverage Gaps

**Goal:** Confirm that everything significant from the source made it in — and that nothing was over-indexed.

**Checks:**

1. **Chapter-by-chapter concept census** — For each of Ch.1–9, list the concepts named in that chapter. Check each against the wiki. Create a gap list of concepts that appear in the source but have no page.

2. **Entity completeness** — The source mentions several figures beyond the 4 currently indexed (Mahaguru, Hingori, Ashoka, Guru Nanak). Check: Is Mr Marchant an entity or adequately covered in his story page? Are any teachers, saints, or lineage figures named in Ch.1–9 that deserve an entity page?

3. **Analogy census** — The analogies file lists 13 analogies from Karma Sutra. Manually scan Ch.1–9 for named metaphors or extended analogies not currently listed. Verify none were dropped.

4. **Practices completeness** — Current practices: seva, tapasya, sadhana (stub), karmic-worksheet. Check Ch.7 (Afterthoughts) and Ch.6 in particular: are there any other prescribed practices (e.g., mantra, specific shraadh rituals) that deserve their own page vs. being embedded in concept pages?

5. **Over-indexing check** — Scan the index for entries that are essentially restatements of a parent concept (e.g., does `pitra-peeda` warrant its own page separate from the broader `karmic-debt` framework, or does it create redundancy?). Flag any pages where content could be collapsed without loss.

**Pass criterion:** Gap list produced and triaged (each gap marked: omit / create stub / create full page); no confirmed over-indexing.

---

## Suite 6 — Style and Tone Consistency

**Goal:** Confirm the wiki preserves Hingori's voice, not an encyclopaedic paraphrase of it.

**Checks:**

1. **Tone sampling** — Pick one passage from the source (e.g., the opening of Ch.1, or any section from Ch.5). Then read the corresponding concept or synthesis page. Does the wiki page feel like it belongs to the same universe — specific, direct, occasionally sardonic, never academic?

2. **Generic language scan** — Search concept pages for phrases like "it is important to note", "in summary", "this concept refers to", "overall". These are signs of AI-generic or encyclopaedic voice. Flag and rewrite.

3. **Callout usage** — Verify that `> [!question]`, `> [!warning]`, `> [!tip]` callouts are used where genuinely warranted and not over-used as decoration. Check that every `> [!warning]` (contradiction) has a real contradiction, not just a nuance.

4. **Quote selectivity** — The style guide says: "Only include a quote if it is genuinely striking, precise, or irreplaceable." Sample `quotes/karma.md`. Are all quotes there by that standard, or have some been included just to populate the file?

5. **Stories not paraphrased** — Spot-check that no story page opens with a summary sentence before the block quote. The style guide says keep them verbatim — summaries before the quote are a form of editorialising.

**Pass criterion:** No generic language found; all callouts justified; story pages open with block quotes not summaries.

---

## Scoring Summary

| Suite | Tests | Pass Criterion | Status |
|---|---|---|---|
| 1 — Structural Integrity | 4 checks | Zero broken pages or missing metadata | ☐ |
| 2 — Link Health | 4 checks | All links resolve; no true orphans | ☐ |
| 3 — Source Fidelity | 5 checks | Stories verbatim; quotes exact | ☐ |
| 4 — Query Performance | 10 questions | ≥8/10 Pass | ☐ |
| 5 — Coverage Gaps | 5 checks | Gap list produced and triaged | ☐ |
| 6 — Style and Tone | 5 checks | No generic language; quotes selective | ☐ |

---

## Next Steps After Running Tests

- All failures from Suites 1–2 → fix immediately (mechanical, no judgment calls)
- Failures from Suite 3 → re-ingest affected pages from source
- Failures from Suite 4 → diagnose: is the page missing, incomplete, or are links broken?
- Gaps from Suite 5 → triage and schedule as follow-up ingests
- Failures from Suite 6 → targeted rewrites, not full re-ingestion

Log each test run in `wiki/log.md` as:
```
## [YYYY-MM-DD] lint | Test Plan Run — <suite(s) run>
Summary of findings.
```
