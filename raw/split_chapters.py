"""Split guru_sutra_book.md and witnessing_greatness.md into per-chapter files."""
import os

RAW = os.path.dirname(os.path.abspath(__file__))

# ---------------------------------------------------------------------------
# Guru Sutra — chapters 6-19 only (1-5 already ingested)
# (line numbers are 1-based from grep output)
# ---------------------------------------------------------------------------
GS_CHAPTERS = [
    (6,  1802, "ch-06-journey-towards-disciplehood"),
    (7,  2507, "ch-07-guru-disciple-relationship"),
    (8,  2724, "ch-08-facets-of-faith"),
    (9,  2984, "ch-09-surrender"),
    (10, 3612, "ch-10-diksha"),
    (11, 3797, "ch-11-customised-guidance"),
    (12, 4291, "ch-12-guru-kripa-dakshina-awelna"),
    (13, 4723, "ch-13-transmission-of-power"),
    (14, 5430, "ch-14-guru-vandana"),
    (15, 5830, "ch-15-maturity-of-a-guru"),
    (16, 6474, "ch-16-guru-by-destiny"),
    (17, 6666, "ch-17-imagine-yourself-as-deity-or-guru"),
    (18, 6741, "ch-18-self-is-guru"),
    (19, 6815, "ch-19-the-treasure-hunt"),
]

# ---------------------------------------------------------------------------
# Witnessing Greatness — all 20 chapters
# ---------------------------------------------------------------------------
WG_CHAPTERS = [
    (1,  217,  "ch-01-back-to-the-future"),
    (2,  695,  "ch-02-invisibly-yours-buddhe-baba"),
    (3,  1165, "ch-03-impossible-is-possible"),
    (4,  1789, "ch-04-saint-maker"),
    (5,  2183, "ch-05-seva"),
    (6,  2727, "ch-06-roots-to-wings"),
    (7,  3352, "ch-07-deception-of-perception"),
    (8,  3673, "ch-08-cosmic-collaborators"),
    (9,  4444, "ch-09-sage-of-solace"),
    (10, 5371, "ch-10-peerless-mentorship"),
    (11, 5669, "ch-11-sacred-syllables"),
    (12, 6212, "ch-12-elemental-symphony"),
    (13, 6796, "ch-13-training-trails"),
    (14, 7252, "ch-14-master-of-moods"),
    (15, 7622, "ch-15-timeless-tuning"),
    (16, 8228, "ch-16-in-his-shoes"),
    (17, 8609, "ch-17-shiv"),
    (18, 8993, "ch-18-spiritual-oversight"),
    (19, 9344, "ch-19-humble-titan"),
    (20, 9709, "ch-20-sculpting-divinity"),
]


def split_file(src_path, chapters, out_dir):
    with open(src_path, encoding="utf-8") as f:
        lines = f.readlines()
    total = len(lines)

    for i, (num, start_line, slug) in enumerate(chapters):
        start_idx = start_line - 1          # convert to 0-based
        if i + 1 < len(chapters):
            end_idx = chapters[i + 1][1] - 1
        else:
            end_idx = total

        chunk = lines[start_idx:end_idx]
        out_path = os.path.join(out_dir, f"{slug}.md")
        with open(out_path, "w", encoding="utf-8") as f:
            f.writelines(chunk)
        size = end_idx - start_idx
        print(f"  ch-{num:02d}  {size:5d} lines  ->  {slug}.md")


print("=== Guru Sutra (ch 6–19) ===")
split_file(
    os.path.join(RAW, "guru_sutra_book.md"),
    GS_CHAPTERS,
    os.path.join(RAW, "guru-sutra-chapters"),
)

print("\n=== Witnessing Greatness (ch 1–20) ===")
split_file(
    os.path.join(RAW, "witnessing_greatness.md"),
    WG_CHAPTERS,
    os.path.join(RAW, "witnessing-greatness-chapters"),
)

print("\nDone.")
