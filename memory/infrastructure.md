# Infrastructure

## Git
- Working token (2026-02-14): `REDACTED_GITHUB_PAT`
- New token provided 2026-02-15 (Seb said not to store it when I asked)
- Branches: main (full MVP loop), feature/csv-export (still unmerged)

## NVIDIA GB10
- IP: `192.168.100.3`, hostname `promaxgb10-4c73`, user `sebasjay` / `REDACTED_GB10_PW`
- Ubuntu 24.04 ARM64, 20-core, 119GB unified RAM, 3.4TB NVMe, CUDA 13.0
- Ollama v0.17.1-rc2 at `http://192.168.100.3:11434`
- **Qwen 3.5 122B-A10B**: 81GB, 21 tok/s — PRIMARY MODEL for chat + parsing
- **Qwen 3 8B**: 5.2GB, 906 tok/s on vLLM (benchmark only)
- **Llama 3.3 70B**: 42GB, superseded by Qwen 3.5
- SSH key copied from Henry's container
- **vLLM trick**: Swap Triton's ptxas with `/usr/local/cuda-13.0/bin/ptxas` for sm_121 CUDA graph compilation
- vLLM Docker: `vllm/vllm-openai:latest` with `--gpus all` and ptxas mount
- FP4/NVFP4 blocked (kernel binaries not compiled for sm_121), Qwen 3.5 arch not in vLLM yet

## Infrastructure
- Synology NAS: 192.168.100.200, SSH user henry / REDACTED_NAS_PW
- Docker needs `sudo -S` + full path `/usr/local/bin/docker`
- **openlabel-v3-postgres**: dedicated container, port 5433, user `openlabel_v3` / `OL3_xK9mP2vR7nQ`, DB `openlabel_v3`
- Old container `openlabel-postgres` (port 25432) has other project data — DO NOT TOUCH

## Telegram
- Bot token: `REDACTED_TELEGRAM_TOKEN`
- Seb's Telegram ID: `792981796` — paired and working

## Landing Page
- **Live at:** https://openlabel-site.vercel.app + openlabelai.com (pending DNS)
- Repo: `openlabelai/openlabel-site` (private)
- Vercel token: `REDACTED_VERCEL_TOKEN`
- Supabase: project `xpuhbtbftrtdawaehtda`, pooler `aws-1-us-east-1.pooler.supabase.com:6543`, user `postgres.xpuhbtbftrtdawaehtda`, pass `jpc2kqy_ajg8gbw6FKZ`
- Next.js 15.5.12 (Vercel blocks <15.5.x for CVE), dark theme, waitlist with referral system
- Cloudflare DNS needed: A record `openlabelai.com` → `76.76.21.21`

## Infrastructure
- Synology NAS: 192.168.100.200, SSH user henry / REDACTED_NAS_PW
- Docker needs `sudo -S` + full path `/usr/local/bin/docker`
- **Full stack on GB10** (192.168.100.3) — app, Postgres, Redis, Ollama all on one box
- **openlabel-v3-postgres**: port 5433, user `openlabel_v3` / `OL3_xK9mP2vR7nQ`, DB `openlabel_v3`
- **openlabel-v3-redis**: port 6380
- Backend .env needs CLERK_PUBLISHABLE_KEY in addition to SECRET_KEY
