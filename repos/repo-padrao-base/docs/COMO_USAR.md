# Como usar

## Desenvolvedor — iniciar projeto

1. Abra [**CLONAGEM_POR_LINGUAGEM.md**](CLONAGEM_POR_LINGUAGEM.md).
2. Escolha a linguagem e o template.
3. Clone do GitHub (exemplo PHP / Laravel + Vue):

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-laravel-vue.git meu-app
cd meu-app
rm -rf .git && git init
composer create-project laravel/laravel .
```

4. Registre a stack no ADR `docs/brain/3-resources/adrs/0001-escolha-de-stack.md`.

**Não use** o meta-repo `repo-padrao` como base de aplicação.

## Catálogo rápido

| Linguagem | Templates GitHub |
|---|---|
| Agnóstico | [repo-padrao-base](https://github.com/filipefalcaofs/repo-padrao-base) |
| PHP | [vue](https://github.com/filipefalcaofs/repo-padrao-laravel-vue) · [react](https://github.com/filipefalcaofs/repo-padrao-laravel-react) · [svelte](https://github.com/filipefalcaofs/repo-padrao-laravel-svelte) |
| Java | [angular](https://github.com/filipefalcaofs/repo-padrao-jhipster-angular) · [react](https://github.com/filipefalcaofs/repo-padrao-jhipster-react) · [vue](https://github.com/filipefalcaofs/repo-padrao-jhipster-vue) |
| .NET (C#) | [angular](https://github.com/filipefalcaofs/repo-padrao-abp-angular) · [react](https://github.com/filipefalcaofs/repo-padrao-abp-react) · [blazor](https://github.com/filipefalcaofs/repo-padrao-abp-blazor) · [mvc](https://github.com/filipefalcaofs/repo-padrao-abp-mvc) |
| Python | [django](https://github.com/filipefalcaofs/repo-padrao-django) |
| TypeScript | [nestjs](https://github.com/filipefalcaofs/repo-padrao-nestjs) |
| Go | [go-api](https://github.com/filipefalcaofs/repo-padrao-go-api) |

Detalhes, variantes e bootstrap: [**CLONAGEM_POR_LINGUAGEM.md**](CLONAGEM_POR_LINGUAGEM.md).

## O que vem em todo template

- **Superpowers** — plugin + rule obrigatória (TDD, brainstorming, debugging)
- **Rules universais** — pt-BR, git, comunicação, Docker
- **Stack** — rules e skills específicas já na raiz
- **Segundo cérebro** — `docs/brain/`

## Assistentes

| Assistente | Lê |
|---|---|
| Cursor | `.cursor/rules/`, `.cursor/skills/`, `.cursor/plugins/superpowers/` |
| Claude Code | `CLAUDE.md`, `.claude/skills/` |
| GitHub Copilot | `.github/copilot-instructions.md` |
| Codex / outros | `AGENTS.md`, `.codex/skills/` |

## Mantenedor do factory

Ver [**MANUTENCAO.md**](MANUTENCAO.md) e [**docs/README.md**](README.md).
