# Blog Post Generator

Generate one Hingori Sutra blog post and save it to `wiki/blog/`.

**Usage:** `/blog-post [theme]`  
If a theme is given in $ARGUMENTS, use it. Otherwise pick one intelligently from the wiki.

**Audience:** Anyone — from first-time readers to long-time disciples. No hand-holding, but don't assume prior knowledge of terms.

---

## Step 1 — Choose a theme

If $ARGUMENTS is non-empty, treat it as the concept slug or name.

Otherwise:
1. Read `wiki/index.md` → full list of concepts
2. Read `wiki/blog/index.md` → themes already covered
3. Pick a concept that (a) has **not** been covered in any prior post, (b) has at least one story linked in the wiki, and (c) has quotes or analogies that can carry a post.
4. The post need not follow from a previous one — it can be entirely standalone. The only rule: **it must not feel repetitive** against existing posts, even if the concept is new.

---

## Step 2 — Gather source material

Read **all** of the following before writing a word:

- `wiki/blog/index.md` → load the `## Stories Used` list. These stories should be avoided as it can be repetitive to audience. It can still be used if atleast 3 months have passed by or absoultely necessary to explain a concept.
- `wiki/concepts/<slug>.md` — the full concept page
- Every `wiki/stories/` page linked from that concept (read them all), skipping those on the used list
- The most relevant `wiki/quotes/<theme>.md` file(s)
- `wiki/analogies.md` — scan for analogies tagged to this concept

Minimum haul before writing: **2 distinct stories not on the used list**, **2–3 quotes**, **1 analogy**.

---

## Step 3 — Write the post

Write entirely in **Hingori's voice**. Study his prose in the concept and story pages before starting — notice the directness, the warmth, the occasional wry aside.

**Voice rules:**
- Write in **first person as Hingori** — "I sat...", "I recall...", "I devised..." — as if Hingori is speaking directly to the reader. Not "Hingori found himself" — that is third person and creates distance.
- Write in Hingori's book language — full, flowing sentences; warm and direct; the tone of a knowing teacher writing to a sincere reader. Study the concept and story pages before starting and match that register.
- Speak to "you" and "we" — this is a letter, not a lecture
- Never open with a definition. Open with a story or a striking image
- Do NOT write in a fragmented, staccato, or cinematic style. No one-line dramatic pauses. No excessive `---` section dividers.
- Weave the analogy in naturally — don't announce it
- Let quotes arrive at the right moment, not front-loaded
- **Story handling: mix.** Tell stories in flowing prose (Hingori's voice), but preserve one or two key lines verbatim in italics — the line that cannot be paraphrased
- **Connectors between sections are mandatory.** Each bold subheading section must begin with a sentence that links it to the previous section (e.g. "To understand this more clearly...", "I recall how Gurudev demonstrated this...", "Understanding this is one thing; practicing it is another.")
- Close with one short, direct line — a call to awareness or action, the way Hingori ends his chapters
- **Length: let the story determine it.** A post may run 450 words or 750 — fit the material, never pad, never cut short.

**Structure:** Let the arc of the content determine the shape. You need: a hook (story or vivid image, no subheading), an unfolding of the concept, at least one analogy or illustration woven in naturally, at least one deeper story, and a clean closing line. Use light bold subheadings to give the reader handholds — but the number and naming of sections should serve the material, not a template.

**Inline references (not a footnote block):**
- Place `*(→ [[stories/<slug>|Story Title]])* ` or `*(→ [[concepts/<slug>]])* ` immediately after the paragraph where that story or concept is introduced.
- This allows readers to navigate directly from the point of relevance without scrolling to the bottom.
- Remove the large references block at the footer. Keep only the AI-generated notice.

---

## Step 4 — Format the post

```markdown
---
title: "<Post Title>"
date: <YYYY-MM-DD>
type: blog-post
theme: <concept-slug>
sources: [<source filenames from raw/>]
related: ["[[concepts/<slug>]]"]
created: <YYYY-MM-DD>
updated: <YYYY-MM-DD>
---

<post body — no h1, start directly>

---

*References: [[concepts/<slug>|<Concept Name>]] · [[stories/<slug>|<Story Title>]] · <Book Title>, Ch.<N>, p.<N> (where known).*

*Generated from the Hingori Sutras wiki.*
```

Save to: `wiki/blog/YYYY-MM-DD-<concept-slug>.md` (use today's date).

---

## Step 5 — Update the blog index

Append one line to `wiki/blog/index.md` under the `---` separator (before `## Stories Used`):

```
- [[blog/YYYY-MM-DD-<slug>|YYYY-MM-DD — <Post Title>]] — one-line description of the theme
```

Then append each story used in this post to the `## Stories Used` section in the same file:

```
- `<story-slug>` — <concept> (<YYYY-MM-DD>)
```

---

## Step 6 — Update wiki/index.md

If a Blog section does not yet exist in `wiki/index.md`, add it under Synthesis:

```markdown
## Blog
*Daily reflections from the tradition.*

- [[blog/index|Blog]] — All posts
```

If it already exists, add the new post link there too.

---

## Quality check before saving

- [ ] Post reads as a direct message, not a summary
- [ ] Tone matches Hingori's book language — flowing, warm, full sentences; no cinematic fragments or staccato breaks
- [ ] Structure is visible — light bold subheadings give shape
- [ ] At least one full story is present (told in prose, not just referenced)
- [ ] At least one key line preserved verbatim in italics
- [ ] At least one analogy is woven in naturally
- [ ] At least two quotes are included
- [ ] No more than one `---` divider (before the references footer)
- [ ] Footnotes cite the actual source pages
- [ ] AI-generated notice is in the footnote
- [ ] Length fits the material — no padding, no premature cuts
- [ ] Frontmatter is complete
- [ ] Does not feel repetitive against any existing post
