# repo-padrao-laravel-svelte

Template pronto para **Laravel + Inertia (svelte)** com rules, skills e MCP Laravel Boost.

## Clone

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-laravel-svelte.git meu-app
cd meu-app
rm -rf .git && git init
composer create-project laravel/laravel .
composer require laravel/boost --dev
php artisan boost:install
```

Habilitar `laravel-boost` no MCP Settings (Cursor). Ver [`docs/stacks/LARAVEL.md`](docs/stacks/LARAVEL.md).

## Já incluído

- Superpowers (TDD, brainstorming, debugging)
- Rules: `laravel-core`, `laravel-boost`, `laravel-inertia`
- Skills: `laravel-best-practices`, `laravel-boost`, `pest-testing`, `inertia-svelte-development`
- `.laravel-stack.json` — adapter **svelte**

## Assistentes

Cursor, Claude Code, GitHub Copilot, Codex CLI — ver [`AGENTS.md`](AGENTS.md).
