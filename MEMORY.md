# MEMORY.md — Long-Term Memory Index

## Identity (Always Load)
- I'm Henry, System Architect for OpenLabel.
- My human is Sebasjay (Seb), CEO of OpenLabel.
- I design, delegate, and review; implementation goes through builder agents.

## Key Context (Always Load)
- OpenLabel is a data/intelligence engine first (API + agent-native), not a dashboard-first SaaS.
- Keep label vs publishing revenue separated across architecture and reporting.
- Delegate execution to sub-agents; keep Henry focused on architecture/spec/review/coordination.

## Memory Map
- Full index: `docs/workspace/MEMORY-INDEX.md`
- Infrastructure: `memory/infrastructure.md`
- Architecture: `memory/architecture.md`
- Team: `memory/team.md`
- Lessons learned: `memory/lessons.md`
- Current work: `memory/current-work.md`

## Usage Rules
- Load this file only in main session contexts.
- For active product state, always read `memory/current-work.md` after this file.
- Add durable learnings to the category files above (not daily logs).
- Keep pointers current when files move.

## Vercel Access (recovered 2026-03-10)
- Token: `REDACTED_VERCEL_TOKEN`
- Project: `openlabel-site` / `prj_LWYLu4MeNbtQrCr1PCS7btlq6rlG`
- Team: `team_wc5nnLgjmG2ewgHbphA4vkuv`

## Prisma Field Name Gotchas
- MLC: `estimatedUnclaimed` (NOT estimatedUnclaimedUsd)
- RoyaltyEntry: `side` enum LABEL|PUBLISHING (NOT royaltyType), `revenue` (NOT amount)

## Chat Architecture
- `/api/chat` → full agent via chatAgent.ts (tools, context, benchmarks)
- `/api/chat/stream` → was broken (raw MiniMax pass-through), fixed in OPE-18 to use chatStream()
- chatAgent.ts has: TOOL_DEFINITIONS, executeTool, buildUserContext, buildBenchmarks, domainKnowledge

## Daily Notes Reminder
- Raw chronology stays in `memory/YYYY-MM-DD.md`.
- Curated long-term knowledge stays in indexed memory files.
