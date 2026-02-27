#!/bin/bash
# Henry workspace backup — redact secrets, commit, push
cd /host/home

# Redact secrets from all markdown files being tracked
for f in MEMORY.md memory.md memory/*.md TOOLS.md; do
  [ -f "$f" ] && sed -i \
    -e 's/github_pat_[A-Za-z0-9_]*/REDACTED_GITHUB_PAT/g' \
    -e 's/vcp_[A-Za-z0-9]*/REDACTED_VERCEL_TOKEN/g' \
    -e 's/ntn_[A-Za-z0-9]*/REDACTED_NOTION_TOKEN/g' \
    -e 's/8322478987:[A-Za-z0-9_-]*/REDACTED_TELEGRAM_TOKEN/g' \
    -e 's/sk_test_[A-Za-z0-9]*/REDACTED_CLERK_SECRET/g' \
    -e 's/MTQ3[A-Za-z0-9._-]*/REDACTED_DISCORD_TOKEN/g' \
    -e 's/NjO#@Fl5/REDACTED_NAS_PW/g' \
    -e 's/210322/REDACTED_GB10_PW/g' \
    -e 's/pk_test_[A-Za-z0-9]*/REDACTED_CLERK_PUB/g' \
    "$f"
done

git add .gitignore AGENTS.md SOUL.md MEMORY.md memory.md TOOLS.md USER.md IDENTITY.md HEARTBEAT.md memory/*.md scripts/backup.sh 2>/dev/null

# Only push if there are changes
if git diff --cached --quiet; then
  echo "No changes to backup"
  exit 0
fi

git commit -m "backup: $(date -u +%Y-%m-%d) — auto"
git push origin main 2>&1
