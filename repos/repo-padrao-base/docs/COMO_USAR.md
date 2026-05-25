# Como usar o repo-padrao

## Você quer iniciar um projeto?

**Clone um repositório standalone** em [`repos/`](../repos/README.md) — stack e variantes já configuradas.

Exemplo Laravel + Inertia Vue:

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-laravel-vue.git meu-app
cd meu-app
rm -rf .git && git init
composer create-project laravel/laravel .
```

Não use este meta-repo como base de app — ele serve para **gerar e manter** os templates.

## Catálogo de repos standalone

| Repositório | Quando clonar |
|---|---|
| `repo-padrao-base` | Só disciplina IA, sem stack definida |
| `repo-padrao-laravel-vue` | Laravel + Inertia Vue (padrão) |
| `repo-padrao-laravel-react` | Laravel + Inertia React |
| `repo-padrao-laravel-svelte` | Laravel + Inertia Svelte |
| `repo-padrao-jhipster-angular` | Java JHipster + Angular |
| `repo-padrao-jhipster-react` | Java JHipster + React |
| `repo-padrao-jhipster-vue` | Java JHipster + Vue |
| `repo-padrao-abp-angular` | .NET ABP + Angular |
| `repo-padrao-abp-react` | .NET ABP + React modern |
| `repo-padrao-abp-blazor` | .NET ABP + Blazor |
| `repo-padrao-abp-mvc` | .NET ABP + MVC |

### Stacks secundárias (ocasionais)

| Repositório | Quando clonar |
|---|---|
| `repo-padrao-django` | Python Django + DRF |
| `repo-padrao-nestjs` | Node NestJS API |
| `repo-padrao-go-api` | Go REST API |

## Manutenção (mantenedores)

Gerar/atualizar todos os standalone:

```bash
bash scripts/build-standalone-repos.sh --clean
```

Stacks fonte em `stacks/laravel`, `stacks/jhipster`, `stacks/abp`, `stacks/django`, `stacks/nestjs`, `stacks/go-api`.

Guias: [`docs/stacks/LARAVEL.md`](stacks/LARAVEL.md), [`JHIPSTER.md`](stacks/JHIPSTER.md), [`ABP.md`](stacks/ABP.md), [`DJANGO.md`](stacks/DJANGO.md), [`NESTJS.md`](stacks/NESTJS.md), [`GO.md`](stacks/GO.md).

## Assistentes suportados

| Assistente | Lê automaticamente |
|---|---|
| Cursor | `.cursor/rules/*.mdc`, `.cursor/skills/`, `.cursor/plugins/` |
| Claude Code | `CLAUDE.md`, `.claude/skills/` |
| GitHub Copilot | `.github/copilot-instructions.md` |
| OpenAI Codex CLI | `AGENTS.md`, `.codex/skills/` |
| Jules / Aider / Continue / outros | `AGENTS.md` |

## Segundo cérebro

Estrutura em `docs/brain/`. Primeiro ADR recomendado: copiar `docs/brain/3-resources/adrs/0000-template.md` → `0001-escolha-de-stack.md`.

Detalhes em [`docs/brain/README.md`](brain/README.md).

## Publicar standalone no GitHub

Ver [`repos/README.md`](../repos/README.md).
