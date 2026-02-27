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

## Team
- Linus (backend), Nova (frontend), Jaques (research), Suri (TBD)
- All on Claude Sonnet 4 (`anthropic/claude-sonnet-4-20250514`), switched from MiniMax M2 on 2026-02-21
- Communicate via sessions_spawn (Henry-initiated only)
- Dev loop: Henry specs on Opus → agents build on Sonnet → Henry reviews on Opus → Seb approves merge
- Sub-agent spawning requires device pairing — fixed on 2026-02-21 by approving pending device request in `~/.openclaw/devices/pending.json` (needed `operator.write` scope)

## Parser System
- Plugin architecture with header hash detection (O(1), 0.008ms)
- 3 parsers live: ASCAP Pub Intl, DistroKid, ADA — all validated against real data
- Detection enhancements: weighted signatures, confidence scoring, format versioning, unknown handling
- 126 tests total (119 parser + 7 API), all green
- More parsers needed: ASCAP Writer/Domestic, BMI, SESAC

## MVP Loop (Complete)
- Upload → Detect → Parse → Store in Postgres → View in Catalog
- Backend: Express on :3001, frontend: Next.js on :3000, DB: Synology Postgres :5433
- Revenue stored as Decimal(18,8) — financial precision

## Git
- Working token (2026-02-14): `REDACTED_GITHUB_PAT`
- New token provided 2026-02-15 (Seb said not to store it when I asked)
- Branches: main (full MVP loop), feature/csv-export (still unmerged)

## NVIDIA GB10
- IP: `192.168.100.3`, hostname `promaxgb10-4c73`, user `sebasjay` / `210322`
- Ubuntu 24.04 ARM64, 20-core, 119GB unified RAM, 3.4TB NVMe, CUDA 13.0
- Ollama v0.17.1-rc2 at `http://192.168.100.3:11434`
- **Qwen 3.5 122B-A10B**: 81GB, 21 tok/s — PRIMARY MODEL for chat + parsing
- **Qwen 3 8B**: 5.2GB, 906 tok/s on vLLM (benchmark only)
- **Llama 3.3 70B**: 42GB, superseded by Qwen 3.5
- SSH key copied from Henry's container
- **vLLM trick**: Swap Triton's ptxas with `/usr/local/cuda-13.0/bin/ptxas` for sm_121 CUDA graph compilation
- vLLM Docker: `vllm/vllm-openai:latest` with `--gpus all` and ptxas mount
- FP4/NVFP4 blocked (kernel binaries not compiled for sm_121), Qwen 3.5 arch not in vLLM yet

## Dex (Codex Agent)
- Codex CLI v0.104.0 at `/opt/homebrew/bin/codex` on Mac Mini
- `codex review` for PR reviews, `codex exec` for tasks
- Access: `ssh -i ~/.ssh/id_ed25519 openlabel@192.168.100.238`

## Infrastructure
- Synology NAS: 192.168.100.200, SSH user henry / NjO#@Fl5
- Docker needs `sudo -S` + full path `/usr/local/bin/docker`
- **openlabel-v3-postgres**: dedicated container, port 5433, user `openlabel_v3` / `OL3_xK9mP2vR7nQ`, DB `openlabel_v3`
- Old container `openlabel-postgres` (port 25432) has other project data — DO NOT TOUCH

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

## Telegram
- Bot token: `REDACTED_TELEGRAM_TOKEN`
- Seb's Telegram ID: `792981796` — paired and working

## Lessons Learned
- Don't code directly — design and delegate to agents
- Don't run app logic — write code and tests, let the app process
- Always validate parsers against real data, not assumptions
- v2 parser bugs were caused by mismatched column names between parser and verifier
- When delegating to Linus: write detailed specs with exact column mappings, file paths, and constraints. Review output for gaps (e.g., missing rawData fields). First delegation went well.
- **NEVER manually analyze data.** Don't write ad-hoc scripts, don't inspect CSVs, don't figure out patterns by hand. Spec a tool, have it built, let the app discover everything. Seb corrected me on this — I was running node one-liners to analyze DistroKid files instead of building the analysis into the app. The app must be self-sufficient. Henry builds tools, not BE the tool.
- **Linus is the strongest agent.** Ships spec-accurate code, proper ESM, good tests. Minimal review corrections.
- **Nova needs exact interfaces, not prose.** Type mismatches on first frontend task. Fix: backend-first sequencing + shared types package. Seb said discard her code and use Linus's.
- **Always review every line of agent code.** Seb explicitly requested this. Found real issues in both Linus (vitest/jest mismatch) and Nova (wrong field names) on review.
- **Don't run agents in parallel when outputs depend on each other.** Backend must land first so frontend gets exact types.
- **Sub-agent pairing fix:** If spawning fails with "pairing required", check `~/.openclaw/devices/pending.json` for pending requests and approve them (add scopes to paired.json, clear pending). Gateway restart may also generate new pairing requests.

## Landing Page
- **Live at:** https://openlabel-site.vercel.app + openlabelai.com (pending DNS)
- Repo: `openlabelai/openlabel-site` (private)
- Vercel token: `REDACTED_VERCEL_TOKEN`
- Supabase: project `xpuhbtbftrtdawaehtda`, pooler `aws-1-us-east-1.pooler.supabase.com:6543`, user `postgres.xpuhbtbftrtdawaehtda`, pass `jpc2kqy_ajg8gbw6FKZ`
- Next.js 15.5.12 (Vercel blocks <15.5.x for CVE), dark theme, waitlist with referral system
- Cloudflare DNS needed: A record `openlabelai.com` → `76.76.21.21`

## Dex (Codex 5.3 Agent)
- Model: `openai/gpt-5.3-codex` via existing OpenAI API key (no OAuth needed)
- Role: Senior Engineer — entity resolution, architectural work
- Added to `openclaw.json` in both `/app/openclaw-state/` AND `/home/node/.openclaw/` (gateway reads latter)
- Config gotcha: TWO config file locations must stay in sync

## Forensic Intelligence (New Core Feature)
- Seb's directive: "Displaying data doesn't cut it. Be a forensic investigator."
- Spec: `docs/TASK-FORENSIC-INTELLIGENCE-V1.md`
- Dev plan: Phase 0 (entity resolution) → Phase 1 (single-source forensics) → Phase 2 (cross-source) → Phase 3 (audit engine) → Phase 4 (AI moat)
- Entity resolution is PREREQUISITE for cross-source forensics
- Single-source rules (rate drop, period anomaly) can ship without entity resolution
- Jaques research: `OBSIDIAN/Jaques/FORENSIC-ROYALTY-COMPETITORS.md` + `FINANCIAL-FORENSICS-RESEARCH.md`
- Closest competitor: Claimy (Paris, $1.8M, France/UK only, publishing only)
- Best acquisition hook: free MLC black box scan

## Current Work (2026-02-27)
- Query Layer V2: MERGED to main ✅ (8 new endpoints, 236 tests)
- Release Module V1: MERGED to main ✅ (templates, releases, milestones, calendar, 240 tests)
- Frontend Catalog Redesign: MERGED to main ✅ (unified earnings page, group-by, detail pages)
- Royalty Side Tagging: MERGED to main ✅ (25 new tests, label/publishing separation complete)
- Entity Resolution V1: MERGED to main ✅ (canonical tracks/artists, ISRC/fuzzy matching, 228 tests)
- Forensic Intelligence V1: MERGED to main ✅ (rate-drop + period-anomaly, 470 tests)
- AI Parser Skill: DESIGNING 🔮 (spec in progress)
- **Clerk Auth: WORKING** ✅ — middleware.ts on Next.js 15.3.3, explicit redirectToSignIn()
- **Chat as default route** ✅ — `/` → `/chat`, sidebar nav to analytics/earnings/catalog/upload
- **Iframe embed fix** ✅ — NavBar hides via `?embed=1` param, no duplicate headers
- App running on Synology Docker at http://192.168.100.200:3000
- 3 reports uploaded: 2 ADA (Dec 2025, Jan 2026) + 1 DistroKid (Apr 2024)
- STT/voice notes working via OpenAI gpt-4o-mini-transcribe on Telegram
- **Next.js pinned to 15.3.3** — Clerk doesn't support Next 16 proxy.ts yet (upgrade when they do)
- **Backend wired to GB10 Ollama** — native `/api/chat` (not `/v1` which is broken for Qwen 3.5 thinking)
- **Ollama optimized**: flash attention, 4 parallel, 0.0.0.0 bind, 24h keep-alive → 24.5 tok/s
- **Linus upgraded to Opus 4.6** (was Sonnet 4) — approved by Seb 2026-02-27
- Frontend for forensics + entities: PLANNING (Jaques researching UX patterns)
- **DB only has 729 test entries** — original data wiped by force-reset, need re-upload
- **vLLM nightly works** but OOM at BF16 — waiting for quantized safetensors (GPTQ/AWQ)
- **25 Prisma models, 797 test cases, 20 route files, 60+ endpoints**

## Sub-Agent Auth Fix (2026-02-22)
- OAuth tokens expire every ~12h, sub-agents couldn't self-refresh
- Fixed by symlinking all sub-agent auth-profiles.json → Henry's in /app/openclaw-state
- When Henry auto-refreshes, all agents get the new token instantly

## Infrastructure
- Synology NAS: 192.168.100.200, SSH user henry / NjO#@Fl5
- Docker needs `sudo -S` + full path `/usr/local/bin/docker`
- **openlabel-app**: node:20-slim container, --network host, workspace at /volume1/docker/claude-code-workspace
- **openlabel-v3-postgres**: port 5433, user `openlabel_v3` / `OL3_xK9mP2vR7nQ`, DB `openlabel_v3`
- **openlabel-v3-redis**: port 6380
- After container restart: must reinstall git + openssl, then start backend + frontend manually
- Backend .env needs CLERK_PUBLISHABLE_KEY in addition to SECRET_KEY

## Discord as System of Record
- Every task, decision, update MUST be logged on Discord
- Agents have AGENTS.md requiring them to log in their channel
- Bot-to-bot Discord doesn't work — use sessions_spawn for agent-to-agent
- Henry posts via curl (Bot token + REST API)
- All bots have AI Agent role for Team Internal access

## Competitive Moat Strategy (from Seb, 2026-02-22)
- SaaS is being eaten by agentic AI — OpenLabel must differentiate
- Be the data layer agents plug INTO (MCP server = source of truth)
- Intelligence over interface ("upload anything, we understand it")
- Make switching impossible (years of normalized data + identity resolution)
- One conversational agent for users, specialized skills underneath

## Agent Performance Notes
- **Nova is unreliable.** Failed completely on frontend task — no output. Build frontend myself.
- **Linus delivers 7-8/10** on Sonnet. Solid but needs review for: missing tests, copy-paste bugs, consistency gaps.
- **Jaques delivers well.** Now has write access to `/host/home/Library/CloudStorage/Box-Box/OBSIDIAN/Jaques/`.
- **Never implement quick fixes.** Seb explicitly said this (2026-02-24). Always understand root cause.
- **Don't adopt framework versions before auth providers support them.** Next.js 16 broke Clerk — 4 days old, no Clerk support yet.
- **Every new backend route needs TWO frontend changes**: (1) rewrite in `next.config.ts`, (2) public route in `middleware.ts`. Miss either = 404 or auth redirect.
- **Dex (Codex 5.3) is viable for frontend.** 7/10 first pass, fixes cleanly on review. Main weakness: field name mismatches with Prisma schema. Include exact field names in specs.
- **Clerk middleware intercepts before Next.js rewrites.** Backend-proxied API routes must be in `isPublicRoute` — backend handles its own auth via Clerk session cookies.
