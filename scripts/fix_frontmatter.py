"""
Fix YAML frontmatter in wiki files so [[wikilinks]] in list fields
are properly quoted, making them valid YAML for Quartz / gray-matter.

Before: related: [[concepts/karma]], [[concepts/maya]]
After:  related: ["[[concepts/karma]]", "[[concepts/maya]]"]
"""

import re
import sys
from pathlib import Path

WIKI_DIR = Path(__file__).parent.parent / "wiki"
FRONTMATTER_RE = re.compile(r"^---\n(.*?)\n---", re.DOTALL)
WIKILINK_LINE_RE = re.compile(r"^(\w[\w-]*):\s*(\[\[.*)$")


def fix_wikilink_value(value: str) -> str:
    """Convert a comma-separated wikilink string to a quoted YAML flow seq."""
    items = [v.strip() for v in value.split(",") if v.strip()]
    quoted = [f'"{item}"' for item in items]
    return "[" + ", ".join(quoted) + "]"


def fix_frontmatter(text: str) -> tuple[str, bool]:
    match = FRONTMATTER_RE.match(text)
    if not match:
        return text, False

    fm_block = match.group(1)
    changed = False
    new_lines = []

    for line in fm_block.split("\n"):
        m = WIKILINK_LINE_RE.match(line)
        if m:
            key, value = m.group(1), m.group(2)
            fixed = fix_wikilink_value(value)
            new_line = f"{key}: {fixed}"
            if new_line != line:
                changed = True
                new_lines.append(new_line)
            else:
                new_lines.append(line)
        else:
            new_lines.append(line)

    if not changed:
        return text, False

    new_fm = "\n".join(new_lines)
    new_text = text[: match.start(1)] + new_fm + text[match.end(1) :]
    return new_text, True


def main():
    files = list(WIKI_DIR.rglob("*.md"))
    fixed = 0
    for path in files:
        original = path.read_text(encoding="utf-8")
        updated, changed = fix_frontmatter(original)
        if changed:
            path.write_text(updated, encoding="utf-8")
            print(f"  fixed: {path.relative_to(WIKI_DIR)}")
            fixed += 1
    print(f"\nDone — {fixed}/{len(files)} files updated.")


if __name__ == "__main__":
    main()
