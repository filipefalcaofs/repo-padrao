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

## 6. Customizando para sua linguagem

O template é **agnóstico de stack**. Ainda assim, há ajustes recomendados conforme a linguagem do projeto.

### `.gitignore` por linguagem

O `.gitignore` raiz já cobre o essencial das linguagens mais comuns. Se a sua stack exige mais ou se você prefere um arquivo focado, use os templates em [`templates-linguagem/`](templates-linguagem/):

```bash
# Anexar ao .gitignore existente
cat docs/templates-linguagem/gitignore-python.txt >> .gitignore

# Ou substituir o .gitignore raiz por completo
cp docs/templates-linguagem/gitignore-go.txt .gitignore
```

Templates disponíveis: Node.js, Python, Go, Rust, Java/Kotlin, PHP/Laravel, Ruby/Rails, .NET, Elixir/Phoenix, Swift/iOS.

### Removendo skills que não se aplicam

Algumas skills só fazem sentido em projetos com stack correspondente. Se o seu projeto **não usa**, remova-as para reduzir ruído nos agentes.

| Pasta/skill | Aplica-se a | Como remover |
|---|---|---|
| `.claude/skills/vue-*` e `create-adaptable-composable` (8 skills Vue.js) | Projetos Vue 3 | `rm -rf .claude/skills/vue-* .claude/skills/create-adaptable-composable` |
| `.cursor/plugins/cache/cursor-public/figma/` | Projetos com Figma | `rm -rf .cursor/plugins/cache/cursor-public/figma/` |
| `.cursor/skills/video-editor/` | Edição de vídeo | `rm -rf .cursor/skills/video-editor/` |
| `.cursor/skills/contagem-ponto-funcao/` | Contratos públicos brasileiros (APF/IFPUG) | `rm -rf .cursor/skills/contagem-ponto-funcao/` |
| `.cursor/rules/laravel-*.mdc`, skills `laravel-*`, `pest-testing` | Projetos Laravel | Ver [`stacks/LARAVEL.md`](stacks/LARAVEL.md) |

As demais skills (GSD, Superpowers, debugging, etc.) são úteis em qualquer projeto.

### Projetos Laravel (Laravel Boost)

O template inclui stack Laravel baseado em [laravel.com/docs/13.x/ai](https://laravel.com/docs/13.x/ai). Guia completo: [`docs/stacks/LARAVEL.md`](stacks/LARAVEL.md).

```bash
composer require laravel/boost --dev
php artisan boost:install
cp stacks/laravel/.mcp.json.example .mcp.json   # se necessário
```

Habilitar `laravel-boost` no MCP Settings do Cursor. Invocar skills `/laravel-best-practices` e `/pest-testing` ao trabalhar no backend e testes.

### Adaptando a seção Docker

A [seção Docker do `AGENTS.md`](../AGENTS.md#9-docker-e-deploy) só se aplica se o projeto **usa containers**. Em projetos que rodam direto na máquina (scripts Python, binários Go compilados, executáveis .NET, etc.), os agentes devem **ignorar essa seção inteira**.

Se quiser deixar isso explícito no seu projeto, edite o `AGENTS.md` removendo a seção 9 ou substituindo-a por uma nota como `> Não aplicável a este projeto.`

## 7. Manter o template atualizado

Se você atualizar uma regra global no seu setup (ex: `~/.cursor/rules/`), replique a mudança neste template para que projetos futuros nasçam atualizados:

```bash
cd /caminho/para/repo-padrao
cp ~/.cursor/rules/*.mdc .cursor/rules/
git add .cursor/rules/
git commit -m "chore: atualiza regras Cursor"
git push
```

Mesmo padrão vale para `.claude/skills/`, `.codex/skills/`, `.cursor/skills/` etc.

## 8. Comandos GSD mais usados

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

## 9. Convenções essenciais

- **Idioma:** pt-BR em tudo voltado a humanos.
- **Commits:** Conventional Commits em português, minúsculas, sem ponto final.
- **TDD:** teste falhando antes de qualquer código de produção.
- **Sem emojis.**
- **Decisões arquiteturais:** registrar em `docs/brain/3-resources/adrs/`.

Detalhes em [`AGENTS.md`](../AGENTS.md).
