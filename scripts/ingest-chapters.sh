#!/usr/bin/env bash
# =============================================================================
# ingest-chapters.sh — Sequential chapter ingestion for a single book
#
# Usage:
#   ./scripts/ingest-chapters.sh                   # process all pending chapters
#   ./scripts/ingest-chapters.sh --chapter 7       # force-run a specific chapter
#   ./scripts/ingest-chapters.sh --dry-run         # print prompts, don't execute
#
# State lives in wiki/.ingest/<slug>.json — edit status field to re-run chapters.
# Valid status values: pending | done | needs-review | skipped
# =============================================================================

set -euo pipefail

# ── Constants ────────────────────────────────────────────────────────────────

WIKI_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MANIFEST="$WIKI_ROOT/wiki/.ingest/aatma-sutra.json"
RUN_LOG="$WIKI_ROOT/scripts/ingest-run.log"
CLAUDE_CMD="claude"

# Detect Python 3 — on Windows/Git Bash, 'python3' may point to the Windows
# Store stub while 'python' resolves to the real installation.
if python3 -c "import sys; assert sys.version_info[0]==3" 2>/dev/null; then
  PYTHON="python3"
elif python -c "import sys; assert sys.version_info[0]==3" 2>/dev/null; then
  PYTHON="python"
else
  echo "ERROR: Python 3 is required but not found on PATH." >&2
  exit 1
fi

MAX_RETRIES=3
WAIT_RATE_LIMIT=90       # seconds — token-per-minute hit
WAIT_OVERLOADED=300      # seconds — server overloaded
WAIT_QUOTA_MSG="Daily quota exceeded. Stopping — re-run after quota resets."

# ── Logging ──────────────────────────────────────────────────────────────────

log() {
  local msg="[$(date '+%Y-%m-%d %H:%M:%S')] $*"
  echo "$msg" | tee -a "$RUN_LOG"
}

log_err() {
  local msg="[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*"
  echo "$msg" | tee -a "$RUN_LOG" >&2
}

log_separator() {
  log "──────────────────────────────────────────────────────"
}

# ── Manifest helpers (Python) ─────────────────────────────────────────────────

# Prints "N|Title|line_start|line_end" for the next pending chapter.
# Prints nothing if all chapters are done.
get_next_chapter() {
  $PYTHON - "$MANIFEST" <<'EOF'
import json, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
for ch in data["chapters"]:
    if ch["status"] == "pending":
        print(f"{ch['n']}|{ch['title']}|{ch['lines'][0]}|{ch['lines'][1]}")
        break
EOF
}

# get_chapter_by_n N — same format, regardless of status
get_chapter_by_n() {
  local n=$1
  $PYTHON - "$MANIFEST" "$n" <<'EOF'
import json, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
n = int(sys.argv[2])
for ch in data["chapters"]:
    if ch["n"] == n:
        print(f"{ch['n']}|{ch['title']}|{ch['lines'][0]}|{ch['lines'][1]}")
        break
EOF
}

update_chapter() {
  local n=$1 status=$2 sha=${3:-}
  $PYTHON - "$MANIFEST" "$n" "$status" "$sha" <<'EOF'
import json, sys
path = sys.argv[1]
n, status, sha = int(sys.argv[2]), sys.argv[3], sys.argv[4] if len(sys.argv) > 4 else None
with open(path) as f:
    data = json.load(f)
for ch in data["chapters"]:
    if ch["n"] == n:
        ch["status"] = status
        if sha:
            ch["git_sha"] = sha
        break
with open(path, "w") as f:
    json.dump(data, f, indent=2)
EOF
}

print_manifest_status() {
  $PYTHON - "$MANIFEST" <<'EOF'
import json, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
print(f"\n  Book: {data['title']}")
print(f"  {'Ch':<4} {'Title':<40} {'Status':<14} {'SHA'}")
print(f"  {'--':<4} {'-----':<40} {'------':<14} {'---'}")
for ch in data["chapters"]:
    sha = (ch.get("git_sha") or "")[:8] or "—"
    print(f"  {ch['n']:<4} {ch['title']:<40} {ch['status']:<14} {sha}")
print()
EOF
}

# ── Prompt builder ─────────────────────────────────────────────────────────────

build_prompt() {
  local ch_n=$1 ch_title=$2 line_start=$3 line_end=$4

  cat <<PROMPT
You are running an automated ingestion of Chapter ${ch_n}: "${ch_title}" from Aatma Sutra into a spiritual wiki.

━━━ PATHS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Wiki root   : ${WIKI_ROOT}
Source file : ${WIKI_ROOT}/raw/aatma-sutra.md
Chapter     : lines ${line_start}–${line_end} of the source file
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

━━━ WHAT TO DO (in order) ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. Read ${WIKI_ROOT}/CLAUDE.md — this defines the complete INGEST protocol.
2. Read ${WIKI_ROOT}/wiki/sources/aatma-sutra.md — understand what has been
   ingested in previous chapters: concepts created, open questions, themes.
3. Read ${WIKI_ROOT}/wiki/log.md — skim the last 10 entries for recent context.
4. Read ${WIKI_ROOT}/wiki/index.md — know the full current state of the wiki.
5. Read lines ${line_start}–${line_end} of ${WIKI_ROOT}/raw/aatma-sutra.md
   — this is the chapter content to ingest.
6. Execute INGEST Phase 2 (Create / Update) and Phase 3 (Verify & Log) exactly
   as defined in CLAUDE.md.

━━━ RULES FOR THIS AUTOMATED RUN ━━━━━━━━━━━━━━━━━━━━━━
- Skip Phase 1 (Plan / Discuss). Proceed directly to execution.
- Complete every sub-step without skipping: create/update concept pages,
  entity pages, story pages, practice pages; add analogies to analogies.md;
  update quotes/ files; backlink pass; synthesis scan; update
  sources/aatma-sutra.md ingestion status; run the full Verification Checklist;
  append to log.md; update index.md.
- The backlink pass and Verification Checklist are mandatory — do not skip them.
- For stories: substantial (multi-paragraph) → own stories/ page verbatim.
  Short anecdotes (single paragraph) → inline block quote in the concept page.
  Never drop a story.
- Use Hingori's tone and language throughout.
- Do not invent content. Flag uncertainty with > [!question].
PROMPT
}

# ── Verification ──────────────────────────────────────────────────────────────

verify_ingestion() {
  local ch_n=$1 ch_title=$2

  cd "$WIKI_ROOT"

  # Primary check: did anything in wiki/ actually change?
  local changed
  changed=$(git status --short | grep -c "wiki/" || true)
  if [[ "$changed" -eq 0 ]]; then
    log_err "Verification FAILED: no wiki/ files were modified for Ch.${ch_n}"
    return 1
  fi

  # Secondary check (soft warning): log.md updated today
  local today
  today=$(date '+%Y-%m-%d')
  if ! grep -q "^\#\# \[${today}\]" "${WIKI_ROOT}/wiki/log.md" 2>/dev/null; then
    log "  ⚠ Warning: no log.md entry found for today (${today}) — may have used a different date format"
  fi

  # Secondary check (soft warning): sources page status updated
  if ! grep -qi "Chapter ${ch_n}.*ingested\|Ch.*${ch_n}.*ingested\|chapter ${ch_n}.*done" \
       "${WIKI_ROOT}/wiki/sources/aatma-sutra.md" 2>/dev/null; then
    log "  ⚠ Warning: sources/aatma-sutra.md may not show Ch.${ch_n} as ingested — check manually"
  fi

  log "Verification PASSED: ${changed} wiki/ file(s) changed for Ch.${ch_n} (${ch_title})"
  return 0
}

# ── Git helpers ───────────────────────────────────────────────────────────────

git_commit_and_push() {
  local ch_n=$1 ch_title=$2

  cd "$WIKI_ROOT"
  log "Staging all changes..."
  git add -A

  log "Committing..."
  git commit -m "$(cat <<EOF
ingest: Aatma Sutra Ch.${ch_n} — ${ch_title}

Automated ingestion via scripts/ingest-chapters.sh
Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"

  local sha
  sha=$(git rev-parse HEAD)
  log "Committed at ${sha:0:8}"

  log "Pushing to origin..."
  git push origin HEAD
  log "Push complete."

  echo "$sha"
}

# ── Core: ingest one chapter ──────────────────────────────────────────────────

ingest_one_chapter() {
  local ch_n=$1 ch_title=$2 line_start=$3 line_end=$4
  local dry_run=${5:-false}

  log_separator
  log "Chapter ${ch_n}: ${ch_title}  (lines ${line_start}–${line_end})"
  log_separator

  # Build prompt → write to temp file to avoid shell escaping issues
  local prompt_file
  prompt_file=$(mktemp /tmp/ingest-prompt-XXXXXX.txt)
  build_prompt "$ch_n" "$ch_title" "$line_start" "$line_end" > "$prompt_file"

  if [[ "$dry_run" == "true" ]]; then
    log "[DRY RUN] Prompt written to $prompt_file — skipping execution"
    cat "$prompt_file"
    return 0
  fi

  local attempt=1
  local output exit_code

  while [[ $attempt -le $MAX_RETRIES ]]; do
    log "Running claude (attempt ${attempt}/${MAX_RETRIES})..."

    output=""
    exit_code=0
    output=$(cd "$WIKI_ROOT" && $CLAUDE_CMD --dangerously-skip-permissions \
             -p "$(cat "$prompt_file")" 2>&1) || exit_code=$?

    # ── Rate limit / quota ──────────────────────────────────────────────────
    if echo "$output" | grep -qi "rate.limit\|429\|too.many.requests"; then
      if echo "$output" | grep -qi "daily\|quota.*exceed\|24.hour\|per.day"; then
        log_err "$WAIT_QUOTA_MSG"
        rm -f "$prompt_file"
        return 2   # caller treats 2 as "stop entirely"
      fi
      log "Rate limit (TPM) hit — waiting ${WAIT_RATE_LIMIT}s..."
      sleep "$WAIT_RATE_LIMIT"
      (( attempt++ )); continue
    fi

    # ── Overloaded / 5xx ───────────────────────────────────────────────────
    if echo "$output" | grep -qi "overloaded\|529\|503\|service.unavailable"; then
      log "API overloaded — waiting ${WAIT_OVERLOADED}s..."
      sleep "$WAIT_OVERLOADED"
      (( attempt++ )); continue
    fi

    # ── Non-zero exit (other error) ────────────────────────────────────────
    if [[ $exit_code -ne 0 ]]; then
      log_err "claude exited ${exit_code} on attempt ${attempt}"
      echo "--- stdout/stderr dump ---" >> "$RUN_LOG"
      echo "$output" >> "$RUN_LOG"
      if [[ $attempt -lt $MAX_RETRIES ]]; then
        log "Retrying in ${WAIT_RATE_LIMIT}s..."
        sleep "$WAIT_RATE_LIMIT"
        (( attempt++ )); continue
      else
        log_err "All ${MAX_RETRIES} attempts failed — marking Ch.${ch_n} as needs-review"
        rm -f "$prompt_file"
        return 1
      fi
    fi

    # ── Success: save output, verify ───────────────────────────────────────
    echo "--- Ch.${ch_n} claude output (attempt ${attempt}) ---" >> "$RUN_LOG"
    echo "$output" >> "$RUN_LOG"
    log "Claude finished. Verifying..."

    if verify_ingestion "$ch_n" "$ch_title"; then
      rm -f "$prompt_file"
      return 0
    else
      # Verification failure = something is wrong with the run, not a transient
      # API issue. Don't retry (risk double-writing). Stop and flag.
      log_err "Verification failed — marking Ch.${ch_n} as needs-review for manual inspection"
      rm -f "$prompt_file"
      return 1
    fi

  done

  rm -f "$prompt_file"
  return 1
}

# ── Main loop ─────────────────────────────────────────────────────────────────

main() {
  local force_chapter="" dry_run="false"

  # Parse args
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --chapter) force_chapter="$2"; shift 2 ;;
      --dry-run) dry_run="true"; shift ;;
      *) echo "Unknown arg: $1. Usage: $0 [--chapter N] [--dry-run]"; exit 1 ;;
    esac
  done

  mkdir -p "$(dirname "$RUN_LOG")"

  log "=========================================="
  log "Aatma Sutra — chapter ingestion started"
  log "Manifest: $MANIFEST"
  log "=========================================="
  print_manifest_status

  while true; do
    # Determine which chapter to run
    local row=""
    if [[ -n "$force_chapter" ]]; then
      row=$(get_chapter_by_n "$force_chapter")
      force_chapter=""   # only force the first iteration
    else
      row=$(get_next_chapter)
    fi

    if [[ -z "$row" ]]; then
      log "No pending chapters found — all done."
      print_manifest_status
      break
    fi

    IFS='|' read -r ch_n ch_title line_start line_end <<< "$row"

    # Run ingestion
    local result=0
    ingest_one_chapter "$ch_n" "$ch_title" "$line_start" "$line_end" "$dry_run" || result=$?

    if [[ "$dry_run" == "true" ]]; then
      log "[DRY RUN] Would have processed Ch.${ch_n}. Stopping after first chapter in dry-run mode."
      break
    fi

    if [[ $result -eq 2 ]]; then
      # Daily quota exhausted
      log_err "Stopping due to daily quota. Re-run the script tomorrow to continue from Ch.${ch_n}."
      exit 2
    fi

    if [[ $result -ne 0 ]]; then
      # Ingestion or verification failure
      update_chapter "$ch_n" "needs-review"
      log_err "Ch.${ch_n} failed — marked as needs-review. Fix manually then set status back to pending and re-run."
      print_manifest_status
      exit 1
    fi

    # ── Success path ────────────────────────────────────────────────────────
    log "Ch.${ch_n} ingested successfully. Committing and pushing..."
    local sha
    sha=$(git_commit_and_push "$ch_n" "$ch_title") || {
      log_err "Git commit/push failed for Ch.${ch_n}. Stopping to avoid losing work."
      update_chapter "$ch_n" "needs-review"
      exit 1
    }

    update_chapter "$ch_n" "done" "$sha"
    log "Ch.${ch_n} complete. SHA: ${sha:0:8}"
    print_manifest_status

    # Brief pause before next chapter — lets any in-flight API state settle
    log "Waiting 10s before next chapter..."
    sleep 10

  done

  log "=========================================="
  log "All done."
  log "=========================================="
}

main "$@"
