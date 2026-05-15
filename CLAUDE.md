# CLAUDE.md

Instruções para o **Claude Code** trabalhando neste projeto.

## Fonte de verdade

Todas as diretrizes do projeto (idioma, comunicação, TDD, debugging, GSD, Docker, segundo cérebro, git) estão em **[AGENTS.md](./AGENTS.md)**. Leia-o como ponto de partida — ele é auto-suficiente e cobre tudo.

Este arquivo apenas adiciona o que é específico do Claude Code.

## Skills disponíveis

Este projeto vem com skills pré-instaladas em `.claude/skills/`. O Claude Code as descobre automaticamente. Skills incluídas:

- **Vue.js**: `vue-best-practices`, `vue-debug-guides`, `vue-jsx-best-practices`, `vue-options-api-best-practices`, `vue-pinia-best-practices`, `vue-router-best-practices`, `vue-testing-best-practices`, `create-adaptable-composable`.

Skills adicionais (Superpowers, GSD, Figma, etc.) ficam em `.cursor/plugins/` e `.cursor/skills/` — caso queira reusar lógica equivalente, consulte os SKILL.md de lá.

## Disciplinas obrigatórias (resumo)

> Para cada item abaixo, o detalhamento completo está em **AGENTS.md**.

1. **Brainstorming antes de implementar** — explorar contexto, propor abordagens, obter aprovação.
2. **TDD obrigatório** — Red-Green-Refactor; nenhum código de produção sem teste falhando antes.
3. **Debugging sistemático** — investigar causa raiz nas 4 fases antes de qualquer correção.
4. **Verificação antes de afirmar conclusão** — rodar comando, ler output, só então claim.
5. **Idioma pt-BR** em tudo que humanos leem.
6. **Sem emojis, sem comentários narrativos** no código.
7. **Conventional Commits em português** (`feat:`, `fix:`, `refactor:`, `chore:`, `docs:`, `test:`).

## GSD (Get Stuff Done)

Antes de agir em qualquer tarefa não-trivial, consulte `.planning/` se existir:

- `STATE.md` — onde paramos
- `ROADMAP.md` — fases planejadas
- `PROJECT.md` — visão e requisitos
- `REQUIREMENTS.md` — requisitos rastreáveis

Comandos GSD disponíveis: `/gsd-progress`, `/gsd-plan-phase N`, `/gsd-execute-phase N`, `/gsd-resume-work`, `/gsd-fast`, `/gsd-quick`, `/gsd-debug`, `/gsd-ship N`. Lista completa em [AGENTS.md §8](./AGENTS.md#8-workflow-gsd-get-stuff-done).

## Segundo Cérebro

Conhecimento do projeto vive em `docs/brain/`. **Antes de toda decisão arquitetural**, leia `docs/brain/3-resources/adrs/`. **Após** uma decisão arquitetural, registre um ADR usando `docs/brain/3-resources/adrs/0000-template.md`. Detalhes em [AGENTS.md §10](./AGENTS.md#10-segundo-c%C3%A9rebro-para--code).

## Pasta `.claude/`

- `.claude/skills/` é versionado — todo clone do template já vem com as skills.
- `.claude-cache/` é ignorado pelo git (artefato local de execução).
