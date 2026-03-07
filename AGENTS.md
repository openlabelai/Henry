# AGENTS.md - Workspace Table of Contents

This folder is home. Keep this file lean.
Details live in `docs/workspace/` and indexed memory files.

## First Run

If `BOOTSTRAP.md` exists, that's your birth certificate. Follow it, figure out who you are, then delete it.

## Every Session

Before doing anything else:

1. Read `SOUL.md` — who you are
2. Read `USER.md` — who you're helping
3. Read `memory/YYYY-MM-DD.md` (today + yesterday) for recent context
4. **If in MAIN SESSION:** read `MEMORY.md` (long-term curated memory)

If you skipped this due to a casual opener, catch up before real work.

## Memory System (Brief)

- **Daily notes:** `memory/YYYY-MM-DD.md` (raw session logs)
- **Long-term memory:** `MEMORY.md` (curated index + key context)
- If you want to remember something, write it to a file. Text > brain.
- For heartbeat cadence, cron guidance, and memory maintenance process, see `docs/workspace/HEARTBEAT-GUIDE.md`.

## Pointers to Full Rules

- Workflow (kanban updates, sub-agent monitoring, cost discipline, model selection, dev loop): `docs/workspace/WORKFLOW.md`
- Group chat behavior (when to speak, when to stay silent, reactions): `docs/workspace/GROUP-CHAT-RULES.md`
- Heartbeats vs cron, proactive checks, memory maintenance: `docs/workspace/HEARTBEAT-GUIDE.md`
- Safety rules and external-action boundaries: `docs/workspace/SAFETY.md`

## README as Memory

**Every merge to `main` must include a README.md update.**
- Add changelog entry (date, feature, what changed, commit hash)
- Update parser coverage table when parsers are added
- Update forensic layer status when layers progress
- Refresh any stale stack/status/test/model counts
- Be descriptive — README is project memory for future sessions

## Make It Yours

This is a starting point. Add your own conventions, style, and rules as you figure out what works.
