# Team

## Team
- Linus (backend), Nova (frontend), Jaques (research), Suri (TBD)
- All on Claude Sonnet 4 (`anthropic/claude-sonnet-4-20250514`), switched from MiniMax M2 on 2026-02-21
- Communicate via sessions_spawn (Henry-initiated only)
- Dev loop: Henry specs on Opus → agents build on Sonnet → Henry reviews on Opus → Seb approves merge
- Sub-agent spawning requires device pairing — fixed on 2026-02-21 by approving pending device request in `~/.openclaw/devices/pending.json` (needed `operator.write` scope)

## Dex (Codex Agent)
- Codex CLI v0.104.0 at `/opt/homebrew/bin/codex` on Mac Mini
- `codex review` for PR reviews, `codex exec` for tasks
- Access: `ssh -i ~/.ssh/id_ed25519 openlabel@192.168.100.238`

## Dex (Codex 5.3 Agent)
- Model: `openai/gpt-5.3-codex` via existing OpenAI API key (no OAuth needed)
- Role: Senior Engineer — entity resolution, architectural work
- Added to `openclaw.json` in both `/app/openclaw-state/` AND `/home/node/.openclaw/` (gateway reads latter)
- Config gotcha: TWO config file locations must stay in sync

## Sub-Agent Auth Fix (2026-02-22)
- OAuth tokens expire every ~12h, sub-agents couldn't self-refresh
- Fixed by symlinking all sub-agent auth-profiles.json → Henry's in /app/openclaw-state
- When Henry auto-refreshes, all agents get the new token instantly

## Discord as System of Record
- Every task, decision, update MUST be logged on Discord
- Agents have AGENTS.md requiring them to log in their channel
- Bot-to-bot Discord doesn't work — use sessions_spawn for agent-to-agent
- Henry posts via curl (Bot token + REST API)
- All bots have AI Agent role for Team Internal access

## Agent Performance Notes
- **Nova is unreliable.** Failed completely on frontend task — no output. Build frontend myself.
- **Linus delivers 7-8/10** on Sonnet. Solid but needs review for: missing tests, copy-paste bugs, consistency gaps.
- **Jaques delivers well.** Now has write access to `/host/home/Library/CloudStorage/Box-Box/OBSIDIAN/Jaques/`.
- **Never implement quick fixes.** Seb explicitly said this (2026-02-24). Always understand root cause.
- **Don't adopt framework versions before auth providers support them.** Next.js 16 broke Clerk — 4 days old, no Clerk support yet.
- **Every new backend route needs TWO frontend changes**: (1) rewrite in `next.config.ts`, (2) public route in `middleware.ts`. Miss either = 404 or auth redirect.
- **Dex (Codex 5.3) is viable for frontend.** 7/10 first pass, fixes cleanly on review. Main weakness: field name mismatches with Prisma schema. Include exact field names in specs.
- **Clerk middleware intercepts before Next.js rewrites.** Backend-proxied API routes must be in `isPublicRoute` — backend handles its own auth via
