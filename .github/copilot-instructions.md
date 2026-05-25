# Instruções para o GitHub Copilot

## Fonte de verdade

Todas as diretrizes do projeto (idioma, comunicação, TDD, debugging, Superpowers, Docker, segundo cérebro, git) estão em **[../AGENTS.md](../AGENTS.md)**. Esse arquivo é a referência completa.

Este documento existe para que o Copilot (Chat e Code Completion) siga os mesmos padrões dos outros agentes do projeto.

## Resumo executivo (leia antes de sugerir qualquer coisa)

1. **Idioma:** todo texto voltado a humanos em **português brasileiro** (comentários, mensagens de commit, documentação, mensagens de erro, nomes de testes). Código (variáveis, funções, classes) permanece em inglês.
2. **Sem emojis** em nada — nem em commits, nem em comentários, nem em respostas de chat.
3. **Sem comentários narrativos** no código (`// incrementa contador` é proibido). Comentários apenas explicam **por que** ou trade-offs não óbvios.
4. **Conventional Commits em pt-BR**: `feat:`, `fix:`, `refactor:`, `chore:`, `docs:`, `test:`, `style:`, `perf:` — descrição em minúsculas, sem ponto final, ≤72 caracteres.
5. **TDD primeiro:** sugerir o teste antes da implementação. Se o usuário pedir feature sem teste, lembrar do TDD.
6. **Debugging sistemático:** ao investigar bugs, primeiro entender causa raiz; não sugerir "tenta isso" sem hipótese fundamentada.
7. **Verificação:** não afirmar que algo funciona sem que o usuário tenha rodado o comando.

## Stack e padrões

- Quando houver dúvida entre opções, preferir a **mais simples** que resolve o problema.
- Não introduzir dependências sem justificativa.
- Respeitar `.editorconfig`.
- Seguir `package.json`/`composer.json`/`requirements.txt` existente quanto a versões; não atualizar deps por conta própria.

## Docker

Build sempre com `docker buildx build --platform linux/amd64` — máquina de desenvolvimento é Apple Silicon (ARM), produção é Linux AMD64. Conta Docker Hub: `filipefalcaofs97`. Detalhes em [../AGENTS.md §9](../AGENTS.md#9-docker-e-deploy).

## Segundo Cérebro

Decisões arquiteturais são registradas em `docs/brain/3-resources/adrs/`. Antes de sugerir uma escolha arquitetural relevante (framework, padrão, banco, etc.), assumir que existe ADR sobre o tema e perguntar / consultar. Após decisão, lembrar de criar ADR. Detalhes em [../AGENTS.md §10](../AGENTS.md#10-segundo-c%C3%A9rebro-para--code).

## Git

Nunca sugerir versionar `.env`, segredos, `node_modules/`, builds. Nunca sugerir alterar `git config`. Detalhes em [../AGENTS.md §11](../AGENTS.md#11-git).
