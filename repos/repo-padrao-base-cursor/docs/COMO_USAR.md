# Como usar

## Desenvolvedor — iniciar projeto

1. Abra [**CLONAGEM_POR_LINGUAGEM.md**](CLONAGEM_POR_LINGUAGEM.md).
2. Escolha **linguagem/stack** e **IDE** (`cursor`, `claude` ou `codex`).
3. Clone o repo com os dois suffixos (exemplo Cursor + Laravel Vue):

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-laravel-vue-cursor.git meu-app
cd meu-app
rm -rf .git && git init
composer create-project laravel/laravel .
```

4. Registre a escolha no ADR `docs/brain/3-resources/adrs/0001-escolha-de-stack.md`.

**Não use** o meta-repo `repo-padrao` como base de aplicação.

## Convenção de nome

```
repo-padrao-{stack}-{cursor|claude|codex}
```

| IDE | Suffix | Entrada no projeto |
|---|---|---|
| Cursor | `-cursor` | `.cursor/` + Superpowers plugin |
| Claude Code | `-claude` | `CLAUDE.md` + `.claude/skills/` |
| Codex | `-codex` | `AGENTS.md` + `.codex/skills/` |

Catálogo completo com links: [**REPOSITORIOS.md**](REPOSITORIOS.md) (inclui 14 repos legados).

## Mantenedor do factory

Ver [**MANUTENCAO.md**](MANUTENCAO.md) e [**docs/README.md**](README.md).
