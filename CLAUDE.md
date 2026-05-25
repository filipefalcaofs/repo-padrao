# CLAUDE.md

Instruções para o **Claude Code** trabalhando neste projeto.

## Fonte de verdade

Todas as diretrizes do projeto (idioma, comunicação, TDD, debugging, Superpowers, Docker, segundo cérebro, git) estão em **[AGENTS.md](./AGENTS.md)**. Leia-o como ponto de partida — ele é auto-suficiente e cobre tudo.

Este arquivo apenas adiciona o que é específico do Claude Code.

## Skills disponíveis

Este projeto vem com skills pré-instaladas em `.claude/skills/`. O Claude Code as descobre automaticamente. Skills incluídas:

- **Vue.js**: `vue-best-practices`, `vue-debug-guides`, `vue-jsx-best-practices`, `vue-options-api-best-practices`, `vue-pinia-best-practices`, `vue-router-best-practices`, `vue-testing-best-practices`, `create-adaptable-composable`.
- **Laravel**: `laravel-best-practices`, `laravel-boost`, `pest-testing`.

Skills **Superpowers** ([obra/superpowers](https://github.com/obra/superpowers)) ficam em `.cursor/plugins/superpowers/` — consulte os SKILL.md de lá quando relevante.

## Disciplinas obrigatórias (resumo)

> Para cada item abaixo, o detalhamento completo está em **AGENTS.md**.

1. **Brainstorming antes de implementar** — explorar contexto, propor abordagens, obter aprovação.
2. **TDD obrigatório** — Red-Green-Refactor; nenhum código de produção sem teste falhando antes.
3. **Debugging sistemático** — investigar causa raiz nas 4 fases antes de qualquer correção.
4. **Verificação antes de afirmar conclusão** — rodar comando, ler output, só então claim.
5. **Idioma pt-BR** em tudo que humanos leem.
6. **Sem emojis, sem comentários narrativos** no código.
7. **Conventional Commits em português** (`feat:`, `fix:`, `refactor:`, `chore:`, `docs:`, `test:`).

## Segundo Cérebro

Conhecimento do projeto vive em `docs/brain/`. **Antes de toda decisão arquitetural**, leia `docs/brain/3-resources/adrs/`. **Após** uma decisão arquitetural, registre um ADR usando `docs/brain/3-resources/adrs/0000-template.md`. Detalhes em [AGENTS.md §9](./AGENTS.md#9-segundo-c%C3%A9rebro-para--code).

## Pasta `.claude/`

- `.claude/skills/` é versionado — todo clone do template já vem com as skills.
- `.claude-cache/` é ignorado pelo git (artefato local de execução).
