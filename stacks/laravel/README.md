# Stack Laravel

**Linguagem:** PHP

Stack de **skills, rules e guidelines** para projetos [Laravel 12/13](https://laravel.com/docs/13.x) com [Laravel Boost](https://laravel.com/docs/13.x/ai), integrado ao `repo-padrao`.

## Conteúdo

| Item | Descrição |
|---|---|
| `.cursor/rules/laravel-core.mdc` | Convenções Laravel (Artisan, Eloquent, estrutura 11+) |
| `.cursor/rules/laravel-boost.mdc` | MCP Boost, `search-docs`, ferramentas |
| `.cursor/rules/laravel-inertia.mdc` | Inertia.js v2 — server-side + qual skill frontend usar |
| `.cursor/skills/laravel-best-practices/` | Skill oficial Laravel Boost (20+ regras) |
| `.cursor/skills/laravel-boost/` | Quando e como usar o MCP |
| `.cursor/skills/pest-testing/` | Testes Pest em Laravel |
| `.cursor/skills/inertia-vue-development/` | Inertia v2 + Vue 3 (padrão) |
| `.cursor/skills/inertia-react-development/` | Inertia v2 + React |
| `.cursor/skills/inertia-svelte-development/` | Inertia v2 + Svelte |
| `.cursor/skills/livewire-development/` | Opcional — projetos Livewire 4 |
| `.cursor/skills/tailwindcss-development/` | Opcional — Tailwind v3/v4 |
| `.ai/guidelines/` | Fonte compatível com `php artisan boost:install` |
| `.ai/skills/` | Skills customizadas para Boost |
| `.mcp.json.example` | MCP `laravel-boost` para Cursor |
| `boost.json.example` | Config base do Boost |

## Aplicar em um projeto

### Opção A — Clonou repo-padrao (recomendado)

```bash
cd meu-projeto
./stacks/laravel/scripts/choose-inertia-adapter.sh
```

Escolha Vue, React ou Svelte. Depois instale Boost no app Laravel.

### Opção B — Projeto Laravel existente

```bash
git clone https://github.com/filipefalcaofs/repo-padrao.git /tmp/repo-padrao
cd /caminho/do/seu/laravel
bash /tmp/repo-padrao/stacks/laravel/scripts/apply-stack.sh . --adapter vue
composer require laravel/boost --dev
php artisan boost:install
```

Substitua `--adapter vue` por `react` ou `svelte`. Sem `--adapter`, o script pergunta interativamente.

### Opção C — Novo projeto Laravel + repo-padrao

```bash
git clone https://github.com/filipefalcaofs/repo-padrao.git meu-app
cd meu-app
composer create-project laravel/laravel app
bash stacks/laravel/scripts/apply-stack.sh app
cd app
composer require laravel/boost --dev
php artisan boost:install
```

## Adapters Inertia disponíveis

| Script | Skill |
|---|---|
| `--adapter vue` | `inertia-vue-development` |
| `--adapter react` | `inertia-react-development` |
| `--adapter svelte` | `inertia-svelte-development` |

Todas ficam em `stacks/laravel/.cursor/skills/`; o projeto recebe **só a escolhida**.

## Skills opcionais

```bash
rm -rf .cursor/skills/livewire-development
rm -rf .cursor/skills/tailwindcss-development
```

## Manutenção

Conteúdo derivado do pacote [laravel/boost](https://github.com/laravel/boost). Para atualizar guidelines oficiais no app:

```bash
php artisan boost:update --discover
```

Customizações locais: `.ai/guidelines/` e `.ai/skills/` (prioridade sobre Boost built-in).

## Referências

- [AI Assisted Development — Laravel 13.x](https://laravel.com/docs/13.x/ai)
- [Laravel Boost — Laravel 13.x](https://laravel.com/docs/13.x/boost)
- [Guia completo](../../docs/stacks/LARAVEL.md)
