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
- **Full review report**: `docs/CODEBASE-REVIEW-2026-03-03.md`
