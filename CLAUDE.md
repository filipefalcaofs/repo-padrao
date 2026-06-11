# CLAUDE.md

Instruções para o **Claude Code** neste repositório.

## Fonte de verdade

Diretrizes universais em **[AGENTS.md](./AGENTS.md)**.

## Para projetos reais

Use o setup com aiox-core + overlay — ver [`docs/COMO_USAR.md`](docs/COMO_USAR.md):

```bash
bash scripts/setup.sh meu-projeto
```

Este repositório mantém as fontes (rules em `.cursor/rules/`, stacks em `stacks/`, brain em `docs/brain/`) aplicadas nos projetos por `overlay/base/apply.sh` e `scripts/choose-stack.sh`.

## Superpowers

Plugin em `.cursor/plugins/superpowers/` — copiado para os projetos pelo overlay.
