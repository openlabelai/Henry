# Slack Channel IDs

| Channel | ID | Purpose |
|---------|-----|---------|
| #eng-dev | C0AKAULS4VA | Engineering hub — specs, reviews, architecture |
| #eng-deploys | C0AJRT89V3R | Deployment notifications |
| #eng-alerts | C0AK0UYV2EP | Sentry, uptime, cost spikes |
| #decisions-log | C0AL1K13XPA | Key decisions with rationale |
| #mktg-content | C0AJRT81GET | Kit content drafts for approval |
| #mktg-competitors | C0AK3TXAQPP | Competitive intel, research |
| #agent-inbox | C0AK0UZEY9Z | Seb → agents task assignment |
| #agent-updates | C0AJRT8S7FZ | Agents → Seb completions/status |
| #product-roadmap | C0AK0UZPPUK | Feature specs, priorities |
| #beta-feedback | C0AK599KN3G | Tester reports, feature requests |
| #ops-costs | C0AK7B10K7U | Cost tracking, weekly summaries |

## Agent Routing
- **Henry** → posts specs/reviews in #eng-dev, decisions in #decisions-log, completions in #agent-updates
- **Dex/Linus/Marcus** → build notifications in #eng-dev, deploy status in #eng-deploys
- **Nova** → frontend updates in #eng-dev
- **Jaques** → research in #mktg-competitors or #eng-dev depending on topic
- **Kit** → drafts in #mktg-content
- **Suri** → strategy in #mktg-content or #product-roadmap

## Posting to Slack
Slack is a *channel* plugin (receives messages), not a tool plugin. No `slack` tool exists.
To post to any channel, use curl with the bot token:
```bash
curl -s -X POST https://slack.com/api/chat.postMessage \
  -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"channel": "CHANNEL_ID", "text": "message"}'
```

## Admin Hub
- Deactivated 2026-03-08
- SQLite DB still at `/host/home/mission-control/.data/mission-control.db`
- Can reactivate if needed: `cd /host/home/mission-control && npm run dev`
