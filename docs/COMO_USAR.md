# Como usar este template

Guia prático para iniciar um projeto novo a partir do `repo-padrao`.

## 1. Clonar como base do seu projeto

```bash
git clone https://github.com/filipefalcaofs/repo-padrao.git meu-projeto
cd meu-projeto
rm -rf .git
git init
git add -A
git commit -m "chore: bootstrap do projeto a partir de repo-padrao"
```

Trocar a origem para o repositório do seu projeto:

```bash
git remote add origin git@github.com:<usuario>/<meu-projeto>.git
git push -u origin main
```

> Alternativa: usar este repositório como **template repository** no GitHub e clicar em **Use this template** — mais limpo, já cria o repo destino sem o histórico do template.

## 2. Personalizar o que é seu

- Editar `README.md` na raiz: substituir descrição genérica pela do seu projeto.
- Manter `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md` — eles padronizam todos os agentes.
- Ajustar `.gitignore` se houver artefatos específicos da sua stack (ex: `*.lockb`, `target/`, `.terraform/`).
- Adicionar `package.json`/`composer.json`/`pyproject.toml` conforme a stack escolhida.

## 3. Iniciar o workflow GSD

No seu assistente preferido (Cursor recomendado), rodar:

```
/gsd-new-project
```

Isso cria a estrutura `.planning/` com `PROJECT.md`, `ROADMAP.md`, `STATE.md`, `REQUIREMENTS.md` e `config.json`.

Em projetos sem `.planning/`, use `/gsd-map-codebase` antes para mapear o código existente.

## 4. Iniciar o segundo cérebro

A pasta `docs/brain/` já está pronta. Comece capturando ideias em `docs/brain/inbox/` e organize semanalmente. Detalhes em [`docs/brain/README.md`](brain/README.md).

Primeira ação recomendada: criar o ADR `0001` registrando a decisão de **stack** do projeto:

```bash
cp docs/brain/3-resources/adrs/0000-template.md docs/brain/3-resources/adrs/0001-escolha-de-stack.md
```

## 5. O que cada agente vê

| Agente | Lê automaticamente |
|---|---|
| Cursor | `.cursor/rules/*.mdc`, `.cursor/skills/`, `.cursor/skills-cursor/`, `.cursor/plugins/` |
| Claude Code | `CLAUDE.md`, `.claude/skills/` |
| GitHub Copilot | `.github/copilot-instructions.md` |
| Antigravity (Google) | `AGENTS.md` |
| OpenAI Codex CLI | `AGENTS.md`, `.codex/skills/` |
| Jules / Aider / Continue / outros | `AGENTS.md` |

`AGENTS.md` é **auto-suficiente** — se um agente só lê esse arquivo, ainda assim seguirá todas as diretrizes do projeto.

## 6. Manter o template atualizado

Se você atualizar uma regra global no seu setup (ex: `~/.cursor/rules/`), replique a mudança neste template para que projetos futuros nasçam atualizados:

```bash
cd /caminho/para/repo-padrao
cp ~/.cursor/rules/*.mdc .cursor/rules/
git add .cursor/rules/
git commit -m "chore: atualiza regras Cursor"
git push
```

Mesmo padrão vale para `.claude/skills/`, `.codex/skills/`, `.cursor/skills/` etc.

## 7. Comandos GSD mais usados

```
/gsd-progress             status atual do projeto
/gsd-resume-work          retomar de onde parou
/gsd-plan-phase N         planejar a fase N
/gsd-execute-phase N      executar a fase N
/gsd-fast "tarefa"        tarefa trivial (≤3 arquivos)
/gsd-quick                tarefa pequena com garantias mínimas
/gsd-debug "problema"     debugging com persistência
/gsd-ship N               criar PR da fase N
/gsd-note "ideia"         capturar nota rápida
/gsd-add-todo "tarefa"    adicionar todo
```

## 8. Convenções essenciais

- **Idioma:** pt-BR em tudo voltado a humanos.
- **Commits:** Conventional Commits em português, minúsculas, sem ponto final.
- **TDD:** teste falhando antes de qualquer código de produção.
- **Sem emojis.**
- **Decisões arquiteturais:** registrar em `docs/brain/3-resources/adrs/`.

Detalhes em [`AGENTS.md`](../AGENTS.md).
