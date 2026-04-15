# Wiki Test Results
*Run: 2026-04-16 · Scope: Karma Sutra (single source, fully ingested, Ch.1–9)*
*25 concepts · 4 entities · 15 stories · 3 practices · 3 quote files · 1 analogies file · 2 synthesis pages*

---

## Summary Scorecard

| Suite | Result | Issues Found |
|---|---|---|
| 1 — Structural Integrity | ✅ PASS | 2 stale stub labels in index |
| 2 — Link Health | ⚠️ PARTIAL | 2 missing concept pages; 5 expected future-source links |
| 3 — Source Fidelity | ⚠️ PARTIAL | 1 story paraphrased; verbatim check blocked (no raw/ folder) |
| 4 — Query Performance | ✅ PASS | 10/10 questions surfaced correct pages |
| 5 — Coverage Gaps | ⚠️ PARTIAL | 2 missing concept pages; stub labels stale |
| 6 — Style and Tone | ⚠️ PARTIAL | 1 generic phrase; story attribution format needs ruling |

---

## Suite 1 — Structural Integrity ✅ PASS

**1A Frontmatter completeness:** All pages across concepts/, entities/, sources/, stories/, practices/, synthesis/ have all 6 required keys (title, type, sources, related, created, updated). All `type` values are valid. **Zero failures.**

**1B Index completeness:** Bidirectional check passed. Every file on disk has an index entry; every index link resolves to an existing file. **Zero failures.**

**1C Stub labels:** Three pages marked `*(stub)*` in index.md: `concepts/samskars`, `entities/mahaguru`, `practices/sadhana`.

> [!warning] Stale stub labels
> `concepts/samskars` is 102 lines and fully developed (USB stick analogy, vicious circle, gyan break, next-time syndrome). `entities/mahaguru` is 117 lines with substantial content from Ch.1. Both are no longer stubs — their index descriptions should be updated. `practices/sadhana` at 49 lines is legitimately thin and correctly flagged.

**1D Log coverage:** 13 entries covering all ingests from Ch.1 through Ch.9 plus 2 structural updates. Log is complete.

---

## Suite 2 — Link Health ⚠️ PARTIAL PASS

**2A Broken links:** 19 broken `[[wiki links]]` found, falling into two distinct categories:

*Expected forward links (not defects — intentional per style guide):*
- `[[sources/aatma-sutra]]` — referenced in jivaatma.md, hingori.md, karma-sutra.md (5 occurrences)
- `[[sources/dream-sutra]]` — referenced in maya.md, hingori.md, mahaguru.md, karma-sutra.md (4 occurrences)
- `[[sources/guru-of-gurus]]` — referenced in hingori.md, mahaguru.md, karma-sutra.md (3 occurrences)
- `[[sources/guru-sutra]]` — referenced in guru-disciple.md, hingori.md, sadhana.md, karma-sutra.md (4 occurrences)
- `[[sources/witnessing-greatness]]` — referenced in hingori.md, mahaguru.md, karma-sutra.md (3 occurrences)

These are correct forward-links to future source ingests. No action needed.

*Genuine missing pages (defects):*

> [!warning] Missing: `concepts/avidya`
> Referenced in `concepts/kleshas.md` — both in `related:` frontmatter and in the body text, where avidya is described as the "father of ignorance" and the root of the klesha set, and in `concepts/asisa.md` cross-references. Avidya is one of the five kleshas (Patanjali set) and is central to the kleshas framework. Needs a concept page.

> [!warning] Missing: `concepts/karmayoga`
> Referenced in `quotes/karma.md` (body text and cross-ref block). Karmayoga is not peripheral — Gurudev's entire life is described as "karmayoga personified" in the source's preface and in `entities/mahaguru`. Needs a concept page, even if thin.

**2B Orphan pages:** Zero orphans. Every page is reachable from at least one other page. ✅

**2C Backlink symmetry:** 10/10 sampled concept pairs have reciprocal links. ✅

---

## Suite 3 — Source Fidelity ⚠️ PARTIAL

**3A Story format — block quote requirement:**

Of 15 stories, 5 correctly open with block quotes:
- `delhi-reader-plants-trees` ✅
- `fudge-lady-clinic-lonavala` ✅
- `grandfather-education-multiplier` ✅
- `pitra-peeda-sons-birth` ✅
- `sanjog-bird-cones-animal-hospital` ✅

10 stories open with a preamble line before the block quote. These fall into two sub-categories:

*Acceptable — source attribution only (e.g., "Told in 'A King's Tale' (*Karma Sutra*, Ch.1, p.15):"):*
`ashoka-kalinga-transformation`, `bada-guruvar-queue`, `guru-nanak-river-bain`, `gurus-umbrella-wife-delivery`, `hingori-arthritis-cure`, `marchant-planchette-healing`, `mr-x-correspondence`, `scooter-accident-vision`

These are borderline. The attribution line is useful metadata but is not part of the story. The style guide says keep stories verbatim — a source citation before the block quote is not narrative editorialising, so this is tolerable. However, it is inconsistent with the 5 pages that open cleanly with block quotes.

> [!warning] Genuine paraphrase — `stories/sadhu-blanket-clove`
> This story opens with **three paragraphs of third-person narrative paraphrase** before the first block quote. The actual source quote ("I learnt that not accepting a favour in return...") appears only after the paraphrase has already told the story. The style guide requires stories to be verbatim from the source. This page needs re-ingestion with a direct block quote of the narrative, not a paraphrase.

**3B Quote attribution:** All 48 quotes across three quote files (karma: 30, guru: 9, maya: 9) have proper attribution. Non-Hingori quotes (Kabir, Ghalib, Guru Nanak, Rig Veda) correctly omit page refs since they are not from the source text. ✅

**3C Verbatim verification:**

> [!question] Cannot complete — raw/ folder absent
> The raw source files are not present in the workspace. Verbatim checks for stories and quote accuracy against source page numbers cannot be done programmatically. Suites 3A and 3B above are structural checks only. A human spot-check against the Karma Sutra PDF is required to fully pass this suite.

---

## Suite 4 — Query Performance ✅ PASS (10/10)

Each question was tested by locating the expected pages and verifying the required content was present.

| # | Question | Pages Surfaced | Result |
|---|---|---|---|
| Q1 | What is karma, and how does it differ from kriyaman, sanchit, and prarabdh? | karma ✅, kriyaman-karma ✅, sanchit-karma ✅, prarabdh-karma ✅ | **PASS** |
| Q2 | Why does guilt increase karma rather than reduce it? | doer-ship ✅ (guilt-as-doer-ship mechanism present), non-doership ✅ | **PASS** |
| Q3 | What are the 5 categories of negative karma? | negative-karma ✅ — all 5 categories present with encashment rule | **PASS** |
| Q4 | What does a sadguru actually do, and why is finding one a lottery? | guru-disciple ✅ (lottery quote + umbrella metaphor cited), analogies ✅ (both Guru analogies present) | **PASS** |
| Q5 | How do samskars form, persist, and get erased? | samskars ✅, asisa ✅, vasna ✅, kaarna-sharir ✅, synthesis/samskar-loop ✅ | **PASS** |
| Q6 | What is non-doership and how does it relate to moksha? | non-doership ✅ (two paths + highway to moksha), attitude-to-deeds ✅ (three-stage map), moksha ✅ | **PASS** |
| Q7 | Give a story illustrating positive karma compounding across generations | grandfather-education-multiplier ✅, fudge-lady-clinic-lonavala ✅ | **PASS** |
| Q8 | What is pitra peeda and how is it remediated? | pitra-peeda ✅ (three astral worlds, shraadh, Gurudev's prescription), pitra-peeda-sons-birth ✅ | **PASS** |
| Q9 | How do gunas, koshas, and non-doership fit as one inward movement? | synthesis/inner-frameworks-convergence ✅ (four-framework convergence) | **PASS** |
| Q10 | What practical tools does the book give for reducing karmic debt? | karmic-worksheet ✅ (CCTV + scoring), tapasya ✅, seva ✅ | **PASS** |

---

## Suite 5 — Coverage Gaps ⚠️ PARTIAL

**Confirmed missing concept pages:**

| Missing Page | Severity | Where Referenced | Action |
|---|---|---|---|
| `concepts/karmayoga` | High | quotes/karma.md, entities/mahaguru (implicit) | Create — central concept |
| `concepts/avidya` | Medium | concepts/kleshas.md (frontmatter + body), concepts/asisa.md | Create — one of the 5 kleshas |

**Stub labels to update in index.md:**

| Page | Current Index Label | Reality |
|---|---|---|
| `concepts/samskars` | `*(stub)*` | 102 lines, fully developed — remove stub label |
| `entities/mahaguru` | `*(stub, expanded on later ingests)*` | 117 lines with preface + Ch.1 content — update label |

**Future source gaps (expected — not defects):** 5 sources linked but not ingested: aatma-sutra, dream-sutra, guru-of-gurus, guru-sutra, witnessing-greatness.

**Analogies:** 18 entries in analogies.md (log says 13 from Karma Sutra — 5 additional entries were added in Ch.8–9 ingests but the count in log.md was not updated). Content appears comprehensive.

**Practices:** seva, tapasya, karmic-worksheet are fully developed. sadhana is legitimately a stub pending guru-sutra ingestion. No missing practices identified from Ch.1–9 text.

**Entity coverage:** The 4 current entities (Mahaguru, Hingori, Ashoka, Guru Nanak) are the only named figures in Karma Sutra who receive sustained treatment. Mr Marchant is adequately covered in his story page. No entity gaps identified.

---

## Suite 6 — Style and Tone ⚠️ PARTIAL

**6A Generic language:** One instance found.

> [!warning] Generic phrase in `entities/ashoka.md`, line 53
> "it is worth noting that Hingori's Ashoka is used as a moral exemplar, not a historiographic claim." — the phrase "it is worth noting" is the only generic language flag across all 35+ pages. Low severity; easy fix.

**6B Callout usage:**
- 18 `[!question]` callouts — all appear at genuine open questions left unanswered by the source. ✅
- 1 `[!warning]` callout — in negative-karma.md for sexual assault as generating immeasurable karmic debt. Appropriate and justified. ✅
- 16 `[!tip]` callouts — reviewed across concepts and practices. No decorative or unjustified tips found. Content ranges from key strategic reframes to verbatim source quotes. ✅
- No empty callout blocks found. ✅

**6C Story format — attribution vs. paraphrase:**

The distinction matters. Stories that open with `Told in "Section Title" (*Source*, p.XX):` followed immediately by a block quote are acceptable — the attribution is metadata, not narrative. Stories that open with paraphrase are a violation of the style guide.

Only `stories/sadhu-blanket-clove` is a clear violation (three paragraphs of third-person retelling). The attribution-only openers are tolerable but inconsistent — a style decision is needed on whether to standardise all stories to open directly with the block quote and put the source citation in the Source section.

**6D Quote selectivity:** Sampled `quotes/karma.md` (30 entries). The selectivity criterion ("genuinely striking, precise, or irreplaceable") is largely met. The collection includes strong definitional quotes, strategic reframes, and classical couplets (Kabir, Ghalib). No padding detected. ✅

---

## Action List

Priority fixes (mechanical, do now):

1. **Create `concepts/karmayoga`** — central concept, explicitly named in source, Gurudev's life described as its personification
2. **Create `concepts/avidya`** — one of the 5 kleshas, referenced from kleshas.md and asisa.md with broken links
3. **Remove stub label from `concepts/samskars`** in index.md
4. **Update stub label for `entities/mahaguru`** in index.md (e.g., "partial — full treatment pending guru-of-gurus ingestion")
5. **Re-ingest `stories/sadhu-blanket-clove`** — open with verbatim block quote, not paraphrase
6. **Fix generic phrase in `entities/ashoka.md`** line 53 — replace "it is worth noting" with direct statement

Lower priority (style decision needed):

7. **Standardise story attribution format** — decide whether source attribution lines before block quotes are acceptable, and apply consistently across all 15 stories
8. **Run verbatim spot-check** against Karma Sutra PDF (requires source) — specifically for stories added before the re-ingest on 2026-04-14
9. **Update analogy count in log.md** — log says 13 analogies but analogies.md now has 18 entries

---

*Log entry appended to wiki/log.md*
