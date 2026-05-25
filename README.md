# repo-padrao

**Meta-repositório** — fonte das stacks Laravel, JHipster, ABP e stacks secundárias (Django, NestJS, Go). Gera repositórios **standalone** prontos para clone (rules + skills Cursor/Claude já aplicados).

> Para iniciar projeto: clone um repo em [`repos/`](repos/README.md), **não** este meta-repo.

## Repositórios para clone

| Repositório | Stack |
|---|---|
| [`repo-padrao-base`](repos/repo-padrao-base/) | Agnóstico (Superpowers + brain) |
| [`repo-padrao-laravel-vue`](repos/repo-padrao-laravel-vue/) | Laravel + Inertia Vue |
| [`repo-padrao-laravel-react`](repos/repo-padrao-laravel-react/) | Laravel + Inertia React |
| [`repo-padrao-laravel-svelte`](repos/repo-padrao-laravel-svelte/) | Laravel + Inertia Svelte |
| [`repo-padrao-jhipster-angular`](repos/repo-padrao-jhipster-angular/) | JHipster + Angular |
| [`repo-padrao-jhipster-react`](repos/repo-padrao-jhipster-react/) | JHipster + React |
| [`repo-padrao-jhipster-vue`](repos/repo-padrao-jhipster-vue/) | JHipster + Vue |
| [`repo-padrao-abp-angular`](repos/repo-padrao-abp-angular/) | ABP + Angular |
| [`repo-padrao-abp-react`](repos/repo-padrao-abp-react/) | ABP + React modern |
| [`repo-padrao-abp-blazor`](repos/repo-padrao-abp-blazor/) | ABP + Blazor |
| [`repo-padrao-abp-mvc`](repos/repo-padrao-abp-mvc/) | ABP + MVC |
| [`repo-padrao-django`](repos/repo-padrao-django/) | Django + DRF *(secundária)* |
| [`repo-padrao-nestjs`](repos/repo-padrao-nestjs/) | NestJS API *(secundária)* |
| [`repo-padrao-go-api`](repos/repo-padrao-go-api/) | Go REST API *(secundária)* |

Catálogo completo: [`repos/README.md`](repos/README.md).

## O que cada standalone inclui

- **Superpowers** — `.cursor/plugins/superpowers/` (TDD, brainstorming, debugging)
- **Rules universais** — idioma pt-BR, git, comunicação, Docker
- **Rules + skills da stack** — em `.cursor/`, `.claude/skills/`, `.codex/skills/`
- **MCP** — Laravel Boost ou ABP Studio (`.mcp.json` quando aplicável)
- **Segundo cérebro** — `docs/brain/` (PARA + CODE)

Sem pasta `stacks/` — tudo já aplicado na raiz.

## Assistentes suportados

| Assistente | Lê automaticamente |
|---|---|
| Cursor | `.cursor/rules/*.mdc`, `.cursor/skills/`, `.cursor/plugins/` |
| Claude Code | `CLAUDE.md` + `.claude/skills/` |
| GitHub Copilot | `.github/copilot-instructions.md` |
| OpenAI Codex CLI | `AGENTS.md` + `.codex/skills/` |
| Jules / Aider / Continue / outros | `AGENTS.md` |

## Estrutura deste meta-repo

```
repo-padrao/
├── stacks/              Fontes (laravel, jhipster, abp, django, nestjs, go-api)
├── scripts/
│   └── build-standalone-repos.sh
├── repos/               14 templates standalone (publicar no GitHub)
├── docs/
│   ├── brain/           Segundo cérebro (copiado nos standalone)
│   └── stacks/          Guias por stack
├── AGENTS.md
└── README.md
```

## Gerar / atualizar standalone repos

```bash
bash scripts/build-standalone-repos.sh --clean
```

Um repo específico:

```bash
bash scripts/build-standalone-repos.sh repo-padrao-laravel-vue
```

## Publicar no GitHub

```bash
cd repos/repo-padrao-laravel-vue
git init && git add -A
git commit -m "chore: template repo-padrao-laravel-vue"
git remote add origin git@github.com:filipefalcaofs/repo-padrao-laravel-vue.git
git push -u origin main
```

## Manutenção

1. Editar stack em `stacks/<nome>/`
2. `bash scripts/build-standalone-repos.sh --clean`
3. Commit meta-repo + push cada standalone

Atualizar rules ABP oficiais: `bash stacks/abp/scripts/sync-upstream-rules.sh`

Guias das stacks secundárias: [`docs/stacks/DJANGO.md`](docs/stacks/DJANGO.md), [`NESTJS.md`](docs/stacks/NESTJS.md), [`GO.md`](docs/stacks/GO.md).

## Licença

Uso pessoal. Adapte como quiser.
