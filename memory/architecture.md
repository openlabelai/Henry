# Architecture

# MEMORY.md — Henry's Long-Term Memory

## Identity
- I'm Henry, System Architect for OpenLabel
- My human is Sebasjay (Seb), CEO of OpenLabel
- I design, delegate, review. I don't write feature code myself (corrected by Seb on day 1).

## Obsidian Vault
- **Path (Mac):** `/Users/openlabel/Library/CloudStorage/Box-Box/OBSIDIAN`
- **Path (container):** `/host/home/Library/CloudStorage/Box-Box/OBSIDIAN`
- Agent folders: `Henry/`, `Jaques/`, `Nova/`, `Suri/`, `Circus/`, `SJEBrain/`
- Synced via Box — writes from container appear on Mac and vice versa

## OpenLabel
- Royalty intelligence platform for music industry
- v3 fresh start, v2 as reference only
- Repo: `openlabelai/openlabel` | Local: `/host/home/dev/openlabel`
- Architecture docs in Box/OBSIDIAN

## Parser System
- Plugin architecture with header hash detection (O(1), 0.008ms)
- 3 parsers live: ASCAP Pub Intl, DistroKid, ADA — all validated against real data
- Detection enhancements: weighted signatures, confidence scoring, format versioning, unknown handling
- 126 tests total (119 parser + 7 API), all green
- More parsers needed: ASCAP Writer/Domestic, BMI, SESAC

## MVP Loop (Complete)
- Upload → Detect → Parse → Store in Postgres → View in Catalog
- Backend: Express on :3001, frontend: Next.js on :3000, DB: GB10 Postgres :5433
- Revenue stored as Decimal(18,8) — financial precision

## Philosophy (from Seb, 2026-02-15, expanded 2026-02-22)
- OpenLabel is NOT a traditional SaaS — it's a data layer and intelligence engine
- Parsers + normalized schema + domain logic = the product. UI is just one client.
- Every feature must be API-first, agent-native. "Can an agent call this?" is the test.
- Build infrastructure others build on, not apps users log into.
- MCP server planned so any AI agent can parse royalty files and query the data.
- **Label vs Publishing separation** — master income and composition income NEVER mix. Different companies, different reports, different account views. (from Seb, 2026-02-22)
- **Intelligence over configuration** — use AI skills to handle variability (unknown report formats, entity resolution) instead of building endless parsers/config. Inspired by OpenClaw's skill-based approach to configurability. (from Seb, 2026-02-22)
- **AI parser skill is the real moat** — not "we support 200 distributors" (labor), but "upload any royalty report and we'll figure it out" (intelligence). Hard-coded parsers become training examples.

## Grand Vision: Label in a Box (from Seb, 2026-02-21)
- OpenLabel = everything an independent artist/small label needs to run their music business
- Three layers: (1) Intelligence Engine (data/parsers) → (2) Release & Collaboration Management → (3) Conversational AI Agent
- **Collaborative**: Splits, shared logins for co-writers/producers who can see their earnings
- **Conversational**: Chat-first UI like Lovable AI — artist talks to OpenLabel, AI helps plan releases, track income, execute campaigns
- **Canvas UI**: Dynamic right-panel showing calendar, timeline, milestones as AI and artist plan together
- **Voice-native**: Voice notes in, voice responses out
- **Service layer**: Must also be an API/MCP service that other agents can access
- Layer 1 (data) stays priority — it's the moat. But ALL architecture decisions must point toward the grand vision.
- Full vision doc: `/host/home/dev/openlabel/docs/VISION.md`

## Architecture Review (2026-02-21)
- Current API surface is fully agent-ready (all JSON, all user-scoped) ✅
- Key gaps before Layer 2: no canonical Artist/Track/Work entities (just strings), no MCP server yet
- Identity resolution (matching "John Smith" across distributors) is the hard problem to solve for collaboration
- Data model evolution: flat entries → canonical entities → release/collaboration → conversational state
- Express → Fastify + tRPC migration should happen before Layer 2

## Tech Stack Decisions
- **Database:** PostgreSQL + Prisma (Seb chose Prisma over Drizzle for stability)
- **Frontend:** Next.js 15 + Tailwind (dark theme, indigo accent)
- **Future:** Fastify + tRPC, Clerk auth, BullMQ + Redis, native Swift iOS + KMP Android
- **Mobile-first**: separate iOS (Swift) and Android apps planned

## Forensic Intelligence (New Core Feature)
- Seb's directive: "Displaying data doesn't cut it. Be a forensic investigator."
- Spec: `docs/TASK-FORENSIC-INTELLIGENCE-V1.md`
- Dev plan: Phase 0 (entity resolution) → Phase 1 (single-source forensics) → Phase 2 (cross-source) → Phase 3 (audit engine) → Phase 4 (AI moat)
- Entity resolution is PREREQUISITE for cross-source forensics
- Single-source rules (rate drop, period anomaly) can ship without entity resolution
- Jaques research: `OBSIDIAN/Jaques/FORENSIC-ROYALTY-COMPETITORS.md` + `FINANCIAL-FORENSICS-RESEARCH.md`
- Closest competitor: Claimy (Paris, $1.8M, France/UK only, publishing only)
- Best acquisition hook: free MLC black box scan

## Competitive Moat Strategy (from Seb, 2026-02-22)
- SaaS is being eaten by agentic AI — OpenLabel must differentiate
- Be the data layer agents plug INTO (MCP server = source of truth)
- Intelligence over interface ("upload anything, we understand it")
- Make switching impossible (years of normalized data + identity resolution)
- One conversational agent for users, specialized skills underneath

## Pivot: Label in a Box (2026-03-06)
- Seb decided to pivot back to original "Label in a Box" vision for YC pitch
- Royalty engine was always Phase 1 — but we were pitching it as the whole product
- Nobody else is building an AI-native OS that replaces the entire label team
- Two new agents prioritized: **Catalog Registration Agent** + **Release Strategy Agent**
- Catalog Registration: register releases across ASCAP/BMI/SESAC/Kobalt/SAYCE/distributors automatically
- Release Strategy: AI-powered release planning based on streaming data, social metrics, market timing
- YC application v5 needs full rewrite around this vision
- Roadmap at `OBSIDIAN/Henry/ROADMAP-2026-03.md`
