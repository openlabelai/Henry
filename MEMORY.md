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

## Roster Artist Backfill
- `rosterLinkingService.ts` — `relinkEntriesForRosterArtist()` auto-links unlinked RoyaltyEntry rows when artist is created/updated
- `relinkAllEntriesForOrg()` for admin bulk repair
- Hooked into `createRosterArtist()` and `updateRosterArtist()` in `rosterService.ts`

## Entity Cleanup on Report Delete
- `cleanupOrphanedEntities(orgId)` in `forensicCleanupService.ts`
- Deletes orphaned CanonicalTrack/CanonicalArtist when no RoyaltyEntry references them
- Called in `catalogStore.delete()` after forensic invalidation

## Chat Widget State
- Zustand store + AI SDK `useChat` have SEPARATE message states — must clear both
- `handleClearChat()` calls both `clearMessages()` (Zustand) and `setChatMessages([])` (AI SDK)
- Auth watcher: `useEffect` on `userId`/`orgId` from `useAuth()` with `authSessionRef` to skip first render

## OpenAI API
- GPT-4o-mini key quota exceeded as of 2026-03-13 — chat agent broken until credits added

## Daily Notes Reminder
- Raw chronology stays in `memory/YYYY-MM-DD.md`.
- Curated long-term knowledge stays in indexed memory files.
