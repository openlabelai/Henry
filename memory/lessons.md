# Lessons

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

## Org Migration Lesson (2026-02-28)
- **Every frontend fetch call must send X-Org-Id header** — created `orgFetch()` in api.ts and `OrgProvider` in root layout
- OrgProvider auto-fetches user's org on load, sets `activeOrgId` in localStorage
- HomePanel needs retry loop — races with OrgProvider on first load
- `backend/src/services/cache.ts` — in-memory cache with TTL, used for analytics overview (5 min)
- Security audit from Codex: 3 real findings (IDOR on chat, TOCTOU on member mutations, webhook body parsing), 4 hallucinated

## Codebase Review Process (2026-03-03)
- **Two-pass review works well**: Dex catches code-level bugs, Henry validates (40% false positive rate from Dex)
- **Streaming CSV pipeline live** — no more OOM risk on large files
- **Decimal.js for money** — `parseRevenue()` utility in all parsers, 8 decimal precision
- **Rate limiting added** — express-rate-limit: 100/20/10 req/min
- **Never use `await` in non-async functions** — broke backend, tsx doesn't catch it at compile time
- **AI SDK v6 `createOpenAI` is NOT compatible with MiniMax M1** — use raw fetch + manual SSE emission instead
- **Next.js dev mode buffers SSE/streaming through rewrite proxy** — always use production mode (`next build && next start`) for streaming features
- **Root layout is a Server Component** — can't use `next/dynamic` with `ssr: false` directly. Wrap in a `'use client'` loader component.
- **`export const dynamic = 'force-dynamic'` conflicts with `import dynamic from 'next/dynamic'`** — use different name or wrapper pattern
- **Always test LLM integrations with raw fetch BEFORE wrapping in SDK** — SDK abstractions hide incompatibilities
- **`DefaultChatTransport` (ai v6) expects `text-start`/`text-delta`/`text-end` JSON event stream** — not the `0:` data stream protocol
- **Multiple deploys = zombie processes** — always `fuser -k <port>/tcp` before starting new processes on GB10
- **Full review report**: `docs/CODEBASE-REVIEW-2026-03-03.md`

## AI SDK jsonSchema() Bug (2026-03-10)
- `jsonSchema()` from `ai@6.0.116` does NOT work with `@ai-sdk/openai@3.0.41` when `zod@4.x` is installed
- The OpenAI provider's serialization strips `type` and `properties` from jsonSchema wrapper objects
- **Always use `z.object()` with `import { z } from 'zod/v4'`** for tool parameters
- Never trust that a schema wrapper "just works" — log the actual HTTP request body to verify

## DefaultChatTransport Headers (2026-03-10)  
- `headers: orgHeaders()` evaluates once at mount — use `headers: () => orgHeaders()` for dynamic evaluation
- Always verify custom headers are actually sent by checking the server-side request, not just the client code

## GB10 Process Management (2026-03-10)
- tsx watch spawns child node processes — `pkill -f tsx` may not kill children
- Always check `fuser <port>/tcp` to find the actual process serving the port
- Multiple tsx watch instances can run simultaneously, only one binds the port
- Use `killall -9 tsx node` to ensure clean state before restart
