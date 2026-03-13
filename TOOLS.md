# TOOLS.md - Local Notes

## GitHub

- Repo: https://github.com/openlabelai/openlabel
- Token: stored in git credential config
- Local clone: /host/home/dev/openlabel

## Team Architecture

- **Henry (me):** Architect & coordinator. All design decisions, architecture, tech stack choices. Reviews and approves all code. Only one who merges to dev/main.
- **Linus:** Backend developer #2 (Codex 5.3). Parallel execution when Dex is busy. No architectural decisions.
- **Marcus:** Backend developer #3 (Sonnet 4.6). Backup parallel execution. No architectural decisions.
- **Nova:** Frontend developer. Executes tasks on feature branches. No architectural decisions.
- **Jaques:** Research analyst. Gathers info, analyzes options. Reports findings back to me.
- **Suri:** Marketing & Growth Strategist. Positioning, pitches, competitive analysis, go-to-market, content strategy.

### Rules
- Agents work on their own branches only
- No direct pushes to dev or main by any agent
- All code goes through my review before merge
- Architecture and design decisions are mine alone
- I define tasks with clear specs; agents implement, not decide

### Dev Loop
1. Seb requests feature / beta tester reports issue
2. Henry specs the task with business context
3. Linus implements on feature branch
4. **Dex reviews (code quality)** — field mismatches, type safety, error handling, dead code, test gaps
5. **Henry reviews (architecture)** — spec compliance, patterns, design system, security, integration
6. Henry merges to main
7. Seb approves deploy
8. Same-day delivery when possible — speed converts leads

### CI/CD
- GitHub Actions: `.github/workflows/ci.yml`
- 4 jobs: Backend Lint/Typecheck, Backend Tests, Frontend Build, Frontend Lint
- Monitor: `scripts/check-ci.sh`
- Secrets needed: CLERK_PUBLISHABLE_KEY, CLERK_SECRET_KEY

### Dex (GPT 5.4) — Primary Builder & Reviewer
- All feature development, fixes, complex integration
- Code reviews when not building
- Fast, autonomous, cost-effective
- Model: `openai/gpt-5.4`

### Linus (GPT 5.4) — Second Builder
- Parallel execution when Dex is occupied
- Model: `openai/gpt-5.4`

## Discord
- Server: OpenLabel (guild `1475197196696817906`)
- Seb's Discord ID: `509285920810205190`
- 5 bots: Henry, Linus, Nova, Jaques, Suri — each with own token/account
- Mention-based interaction — @mention the bot you want to talk to
- Config persisted to `/app/openclaw-state/openclaw.json`
