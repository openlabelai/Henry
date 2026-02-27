# TOOLS.md - Local Notes

## GitHub

- Repo: https://github.com/openlabelai/openlabel
- Token: stored in git credential config
- Local clone: /host/home/dev/openlabel

## Team Architecture

- **Henry (me):** Architect & coordinator. All design decisions, architecture, tech stack choices. Reviews and approves all code. Only one who merges to dev/main.
- **Linus:** Backend developer. Executes tasks on feature branches. No architectural decisions.
- **Nova:** Frontend developer. Executes tasks on feature branches. No architectural decisions.
- **Jaques:** Research analyst. Gathers info, analyzes options. Reports findings back to me.
- **Suri:** Marketing & Growth Strategist. Positioning, pitches, competitive analysis, go-to-market, content strategy.

### Rules
- Agents work on their own branches only
- No direct pushes to dev or main by any agent
- All code goes through my review before merge
- Architecture and design decisions are mine alone
- I define tasks with clear specs; agents implement, not decide

### Dev Loop (inspired by Elvis Sun's agent swarm)
1. Seb requests feature / beta tester reports issue
2. Henry specs the task with business context from AGENT-CONTEXT.md
3. Agent (Linus/Dex) implements on feature branch
4. CI runs: lint + typecheck + tests + build
5. Dex (Codex) reviews the PR (when available)
6. Henry does final architectural review
7. Seb approves merge
8. Same-day delivery when possible — speed converts leads

### CI/CD
- GitHub Actions: `.github/workflows/ci.yml`
- 4 jobs: Backend Lint/Typecheck, Backend Tests, Frontend Build, Frontend Lint
- Monitor: `scripts/check-ci.sh`
- Secrets needed: CLERK_PUBLISHABLE_KEY, CLERK_SECRET_KEY

### Dex (Codex) — Senior Engineer (PLANNED)
- Automated PR reviews
- Independent task execution
- Cost-effective for simple tasks

## Discord
- Server: OpenLabel (guild `1475197196696817906`)
- Seb's Discord ID: `509285920810205190`
- 5 bots: Henry, Linus, Nova, Jaques, Suri — each with own token/account
- Mention-based interaction — @mention the bot you want to talk to
- Config persisted to `/app/openclaw-state/openclaw.json`
