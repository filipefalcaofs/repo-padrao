# Catálogo de repositórios

Índice central de todos os templates publicados em [filipefalcaofs](https://github.com/filipefalcaofs).

| Tipo | Quantidade | Uso |
|---|---:|---|
| **Meta-repo (factory)** | 1 | Manutenção do factory — [`repo-padrao`](https://github.com/filipefalcaofs/repo-padrao) |
| **Templates atuais** | 42 | Clonar para iniciar projeto — `repo-padrao-{stack}-{cursor\|claude\|codex}` |
| **Templates legados** | 14 | Mantidos por compatibilidade — ver [Legado](#legado-sem-suffix-de-ide) |

> Para iniciar um app: escolha stack + IDE em [**CLONAGEM_POR_LINGUAGEM.md**](CLONAGEM_POR_LINGUAGEM.md).

---

## Convenção atual (recomendada)

```
repo-padrao-{stack}-{cursor|claude|codex}
```

Cada clone traz **somente** os arquivos da stack e da IDE escolhidas.

| IDE | Suffix | Conteúdo principal |
|---|---|---|
| Cursor | `-cursor` | `.cursor/rules/`, `.cursor/skills/`, Superpowers, MCP (Laravel/ABP) |
| Claude Code | `-claude` | `CLAUDE.md`, `.claude/skills/` |
| Codex | `-codex` | `AGENTS.md`, `.codex/skills/` |

---

## Agnóstico

| Stack | Cursor | Claude | Codex | Legado |
|---|---|---|---|---|
| Superpowers + brain | [base-cursor](https://github.com/filipefalcaofs/repo-padrao-base-cursor) | [base-claude](https://github.com/filipefalcaofs/repo-padrao-base-claude) | [base-codex](https://github.com/filipefalcaofs/repo-padrao-base-codex) | [base](https://github.com/filipefalcaofs/repo-padrao-base) |

---

## PHP — Laravel + Inertia

| Frontend | Cursor | Claude | Codex | Legado |
|---|---|---|---|---|
| Vue | [laravel-vue-cursor](https://github.com/filipefalcaofs/repo-padrao-laravel-vue-cursor) | [laravel-vue-claude](https://github.com/filipefalcaofs/repo-padrao-laravel-vue-claude) | [laravel-vue-codex](https://github.com/filipefalcaofs/repo-padrao-laravel-vue-codex) | [laravel-vue](https://github.com/filipefalcaofs/repo-padrao-laravel-vue) |
| React | [laravel-react-cursor](https://github.com/filipefalcaofs/repo-padrao-laravel-react-cursor) | [laravel-react-claude](https://github.com/filipefalcaofs/repo-padrao-laravel-react-claude) | [laravel-react-codex](https://github.com/filipefalcaofs/repo-padrao-laravel-react-codex) | [laravel-react](https://github.com/filipefalcaofs/repo-padrao-laravel-react) |
| Svelte | [laravel-svelte-cursor](https://github.com/filipefalcaofs/repo-padrao-laravel-svelte-cursor) | [laravel-svelte-claude](https://github.com/filipefalcaofs/repo-padrao-laravel-svelte-claude) | [laravel-svelte-codex](https://github.com/filipefalcaofs/repo-padrao-laravel-svelte-codex) | [laravel-svelte](https://github.com/filipefalcaofs/repo-padrao-laravel-svelte) |

Guia: [stacks/LARAVEL.md](stacks/LARAVEL.md)

---

## Java — JHipster

| Frontend | Cursor | Claude | Codex | Legado |
|---|---|---|---|---|
| Angular | [jhipster-angular-cursor](https://github.com/filipefalcaofs/repo-padrao-jhipster-angular-cursor) | [jhipster-angular-claude](https://github.com/filipefalcaofs/repo-padrao-jhipster-angular-claude) | [jhipster-angular-codex](https://github.com/filipefalcaofs/repo-padrao-jhipster-angular-codex) | [jhipster-angular](https://github.com/filipefalcaofs/repo-padrao-jhipster-angular) |
| React | [jhipster-react-cursor](https://github.com/filipefalcaofs/repo-padrao-jhipster-react-cursor) | [jhipster-react-claude](https://github.com/filipefalcaofs/repo-padrao-jhipster-react-claude) | [jhipster-react-codex](https://github.com/filipefalcaofs/repo-padrao-jhipster-react-codex) | [jhipster-react](https://github.com/filipefalcaofs/repo-padrao-jhipster-react) |
| Vue | [jhipster-vue-cursor](https://github.com/filipefalcaofs/repo-padrao-jhipster-vue-cursor) | [jhipster-vue-claude](https://github.com/filipefalcaofs/repo-padrao-jhipster-vue-claude) | [jhipster-vue-codex](https://github.com/filipefalcaofs/repo-padrao-jhipster-vue-codex) | [jhipster-vue](https://github.com/filipefalcaofs/repo-padrao-jhipster-vue) |

Guia: [stacks/JHIPSTER.md](stacks/JHIPSTER.md)

---

## .NET (C#) — ABP

| UI | Cursor | Claude | Codex | Legado |
|---|---|---|---|---|
| Angular | [abp-angular-cursor](https://github.com/filipefalcaofs/repo-padrao-abp-angular-cursor) | [abp-angular-claude](https://github.com/filipefalcaofs/repo-padrao-abp-angular-claude) | [abp-angular-codex](https://github.com/filipefalcaofs/repo-padrao-abp-angular-codex) | [abp-angular](https://github.com/filipefalcaofs/repo-padrao-abp-angular) |
| React | [abp-react-cursor](https://github.com/filipefalcaofs/repo-padrao-abp-react-cursor) | [abp-react-claude](https://github.com/filipefalcaofs/repo-padrao-abp-react-claude) | [abp-react-codex](https://github.com/filipefalcaofs/repo-padrao-abp-react-codex) | [abp-react](https://github.com/filipefalcaofs/repo-padrao-abp-react) |
| Blazor | [abp-blazor-cursor](https://github.com/filipefalcaofs/repo-padrao-abp-blazor-cursor) | [abp-blazor-claude](https://github.com/filipefalcaofs/repo-padrao-abp-blazor-claude) | [abp-blazor-codex](https://github.com/filipefalcaofs/repo-padrao-abp-blazor-codex) | [abp-blazor](https://github.com/filipefalcaofs/repo-padrao-abp-blazor) |
| MVC | [abp-mvc-cursor](https://github.com/filipefalcaofs/repo-padrao-abp-mvc-cursor) | [abp-mvc-claude](https://github.com/filipefalcaofs/repo-padrao-abp-mvc-claude) | [abp-mvc-codex](https://github.com/filipefalcaofs/repo-padrao-abp-mvc-codex) | [abp-mvc](https://github.com/filipefalcaofs/repo-padrao-abp-mvc) |

Guia: [stacks/ABP.md](stacks/ABP.md)

---

## Stacks secundárias

| Stack | Cursor | Claude | Codex | Legado |
|---|---|---|---|---|
| Django DRF | [django-cursor](https://github.com/filipefalcaofs/repo-padrao-django-cursor) | [django-claude](https://github.com/filipefalcaofs/repo-padrao-django-claude) | [django-codex](https://github.com/filipefalcaofs/repo-padrao-django-codex) | [django](https://github.com/filipefalcaofs/repo-padrao-django) |
| NestJS API | [nestjs-cursor](https://github.com/filipefalcaofs/repo-padrao-nestjs-cursor) | [nestjs-claude](https://github.com/filipefalcaofs/repo-padrao-nestjs-claude) | [nestjs-codex](https://github.com/filipefalcaofs/repo-padrao-nestjs-codex) | [nestjs](https://github.com/filipefalcaofs/repo-padrao-nestjs) |
| Go REST API | [go-api-cursor](https://github.com/filipefalcaofs/repo-padrao-go-api-cursor) | [go-api-claude](https://github.com/filipefalcaofs/repo-padrao-go-api-claude) | [go-api-codex](https://github.com/filipefalcaofs/repo-padrao-go-api-codex) | [go-api](https://github.com/filipefalcaofs/repo-padrao-go-api) |

Guias: [DJANGO.md](stacks/DJANGO.md) · [NESTJS.md](stacks/NESTJS.md) · [GO.md](stacks/GO.md)

---

## Legado (sem suffix de IDE)

Os **14 repositórios legados** (`repo-padrao-{stack}` sem `-cursor`, `-claude` ou `-codex`) permanecem no GitHub para links e clones antigos. **Não recebem atualizações** do factory — o build publica apenas os 42 templates por IDE.

| Repositório legado | Substitutos recomendados |
|---|---|
| `repo-padrao-base` | `-cursor` · `-claude` · `-codex` |
| `repo-padrao-laravel-vue` | idem |
| `repo-padrao-laravel-react` | idem |
| `repo-padrao-laravel-svelte` | idem |
| `repo-padrao-jhipster-angular` | idem |
| `repo-padrao-jhipster-react` | idem |
| `repo-padrao-jhipster-vue` | idem |
| `repo-padrao-abp-angular` | idem |
| `repo-padrao-abp-react` | idem |
| `repo-padrao-abp-blazor` | idem |
| `repo-padrao-abp-mvc` | idem |
| `repo-padrao-django` | idem |
| `repo-padrao-nestjs` | idem |
| `repo-padrao-go-api` | idem |

### Migrar de legado para template por IDE

1. Identifique sua IDE: Cursor, Claude Code ou Codex.
2. Clone o repo com o suffix correto (tabela acima ou [CLONAGEM_POR_LINGUAGEM.md](CLONAGEM_POR_LINGUAGEM.md)).
3. Copie para o novo projeto apenas o que precisar do clone antigo (`docs/brain/`, código da aplicação).

Exemplo — estava em `repo-padrao-laravel-vue` e usa Cursor:

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-laravel-vue-cursor.git meu-app-novo
```

---

## Meta-repo e cópias locais

| Recurso | URL / caminho |
|---|---|
| Factory (fonte) | [github.com/filipefalcaofs/repo-padrao](https://github.com/filipefalcaofs/repo-padrao) |
| Cópias geradas localmente | [`repos/`](../repos/) no meta-repo |
| Manutenção do factory | [MANUTENCAO.md](MANUTENCAO.md) |
