# Catálogo de repositórios

Índice dos repositórios em [filipefalcaofs](https://github.com/filipefalcaofs).

| Tipo | Quantidade | Status |
|---|---:|---|
| **repo-padrao (este)** | 1 | **Ativo** — base única para qualquer projeto |
| Templates por IDE (`repo-padrao-{stack}-{cursor\|claude\|codex}`) | 42 | **Arquivados** — substituídos pelo fluxo único |
| Templates legados (`repo-padrao-{stack}`) | 14 | Inativos — sem atualização desde a migração por IDE |

> Para iniciar um projeto: [**COMO_USAR.md**](COMO_USAR.md). Não clone os repositórios arquivados.

## Modelo atual

Um único repositório + setup:

```bash
git clone https://github.com/filipefalcaofs/repo-padrao.git
cd repo-padrao
bash scripts/setup.sh meu-projeto
```

O aiox-core configura todas as IDEs de uma vez; o overlay aplica as convenções; a stack é escolhida no setup. Não há mais um repositório por combinação stack × IDE.

## Arquivados (42 — por stack e IDE)

Convenção antiga: `repo-padrao-{stack}-{cursor|claude|codex}`. Cada repo trazia somente os arquivos da stack e da IDE escolhidas. Foram arquivados com notice apontando para este repositório.

| Base do nome | Stack | IDEs |
|---|---|---|
| `repo-padrao-base` | Agnóstico | `-cursor` · `-claude` · `-codex` |
| `repo-padrao-laravel-vue` | Laravel + Inertia Vue | idem |
| `repo-padrao-laravel-react` | Laravel + Inertia React | idem |
| `repo-padrao-laravel-svelte` | Laravel + Inertia Svelte | idem |
| `repo-padrao-jhipster-angular` | JHipster + Angular | idem |
| `repo-padrao-jhipster-react` | JHipster + React | idem |
| `repo-padrao-jhipster-vue` | JHipster + Vue | idem |
| `repo-padrao-abp-angular` | ABP + Angular | idem |
| `repo-padrao-abp-react` | ABP + React | idem |
| `repo-padrao-abp-blazor` | ABP + Blazor | idem |
| `repo-padrao-abp-mvc` | ABP + MVC | idem |
| `repo-padrao-django` | Django + DRF | idem |
| `repo-padrao-nestjs` | NestJS API | idem |
| `repo-padrao-go-api` | Go REST API | idem |

## Legados (14 — sem suffix de IDE)

Os repositórios `repo-padrao-{stack}` (sem `-cursor`, `-claude` ou `-codex`) já estavam inativos antes do arquivamento dos 42. Permanecem no GitHub apenas para links antigos.

## Migrar um projeto criado a partir de template antigo

1. Clone este repositório (`repo-padrao`).
2. Aplique o fluxo de projeto existente:

```bash
bash scripts/setup.sh --existing /caminho/do/projeto --stack <stack-do-projeto>
```

O overlay anexa as convenções sem destruir arquivos existentes (aplicação idempotente, com marcadores).
