# repo-padrao

Template de repositório com **skills, rules e segundo cérebro** pré-instalados para múltiplos assistentes de IA. Clone este repositório como base de qualquer projeto novo e o ambiente já vem padronizado para Cursor, Claude Code, Antigravity (Google), GitHub Copilot, OpenAI Codex CLI, Jules e qualquer outro agente compatível com `AGENTS.md`.

> **Funciona com qualquer linguagem.** Node.js, Python, Go, Rust, Java, PHP, Ruby, .NET, Elixir, Swift, Kotlin ou qualquer outra. O template é agnóstico de stack — traz disciplina de desenvolvimento com IA, não amarras tecnológicas.

## O que vem pronto

- **Regras universais** em `AGENTS.md` (auto-suficiente — funciona até em agentes que não leem `.cursor/rules/`).
- **Regras específicas** por assistente (`CLAUDE.md`, `.github/copilot-instructions.md`, `.cursor/rules/*.mdc`).
- **Skills** dos principais agentes já incluídas (`.cursor/skills/`, `.cursor/skills-cursor/`, `.cursor/plugins/`, `.claude/skills/`, `.codex/skills/`).
- **Segundo cérebro** (`docs/brain/`) usando metodologia **PARA + CODE** (Tiago Forte) adaptada a projetos de software.
- **Workflow GSD** (Get Stuff Done) integrado via skills do Cursor.
- `.editorconfig`, `.gitignore` e estrutura de `docs/` prontos.

## Como começar um projeto novo

```bash
git clone https://github.com/filipefalcaofs/repo-padrao.git meu-projeto
cd meu-projeto
rm -rf .git
git init
git add -A
git commit -m "chore: bootstrap do projeto a partir de repo-padrao"
git remote add origin git@github.com:<usuario>/<meu-projeto>.git
git push -u origin main
```

Detalhes completos em [`docs/COMO_USAR.md`](docs/COMO_USAR.md).

## Assistentes suportados

| Assistente | Lê automaticamente |
|---|---|
| Cursor | `.cursor/rules/*.mdc`, `.cursor/skills/`, `.cursor/skills-cursor/`, `.cursor/plugins/` |
| Claude Code | `CLAUDE.md` + `.claude/skills/` |
| GitHub Copilot | `.github/copilot-instructions.md` |
| Antigravity (Google) | `AGENTS.md` |
| OpenAI Codex CLI | `AGENTS.md` + `.codex/skills/` |
| Jules / Aider / Continue / outros | `AGENTS.md` |

`AGENTS.md` é o **padrão universal** e contém o resumo completo de todas as diretrizes — qualquer agente que leia esse único arquivo trabalhará no padrão do projeto.

## Disciplinas obrigatórias

Resumo das regras aplicadas pelo template (detalhes em [`AGENTS.md`](AGENTS.md)):

1. **Idioma** — tudo em pt-BR (respostas, commits, comentários, docs).
2. **Comunicação** — sem emojis, direto ao ponto, sem comentários narrativos no código.
3. **Conventional Commits em pt-BR** — `feat:`, `fix:`, `refactor:`, `chore:`, `docs:`, `test:`, `style:`, `perf:`.
4. **TDD obrigatório** — Red-Green-Refactor; nenhum código de produção sem teste falhando antes.
5. **Debugging sistemático** — investigar causa raiz antes de qualquer correção (4 fases).
6. **Brainstorming antes de implementar** — explorar contexto, propor abordagens, obter aprovação.
7. **Verificação antes de claim de conclusão** — rodar comando, ler output, só então afirmar.
8. **Workflow GSD** — gestão de execução via `.planning/` e comandos `/gsd-*`.
9. **Docker** — sempre `docker buildx --platform linux/amd64` (dev é ARM, prod é AMD64).
10. **Segundo cérebro** — conhecimento em `docs/brain/`, decisões arquiteturais em `docs/brain/3-resources/adrs/`.
11. **Git** — nunca versionar `.env`, segredos, builds; nunca alterar `git config`.

## Estrutura

```
repo-padrao/
├── .cursor/
│   ├── rules/                   Regras Cursor (.mdc) — lidas automaticamente
│   ├── skills/                  Skills GSD e cursor-publicas
│   ├── skills-cursor/           Skills internas Cursor
│   └── plugins/                 Cache de skills compartilhadas (superpowers, figma)
├── .claude/
│   └── skills/                  Skills Claude Code
├── .codex/
│   └── skills/                  Skills OpenAI Codex CLI
├── .github/
│   └── copilot-instructions.md  Instrucoes GitHub Copilot
├── docs/
│   ├── COMO_USAR.md             Como usar este template
│   └── brain/                   Segundo cerebro (PARA + CODE)
│       ├── README.md
│       ├── inbox/               Captura rapida (Capture)
│       ├── 1-projects/          Iniciativas com prazo
│       ├── 2-areas/             Responsabilidades continuas
│       ├── 3-resources/         Referencias reutilizaveis
│       │   ├── adrs/            Architecture Decision Records
│       │   ├── pesquisas/       Notas de pesquisa
│       │   └── snippets/        Trechos uteis
│       ├── 4-archive/           Concluido ou inativo
│       └── daily/               Notas diarias (opcional)
├── AGENTS.md                    Padrao universal (auto-suficiente)
├── CLAUDE.md                    Atalho para Claude Code
├── README.md                    Este arquivo
├── .editorconfig
└── .gitignore
```

## Segundo cérebro

A pasta `docs/brain/` aplica o método **PARA** (Projects, Areas, Resources, Archive) com fluxo **CODE** (Capture, Organize, Distill, Express) ao contexto de projetos de software. Cada projeto novo já nasce com a estrutura completa, templates e READMEs explicativos. Saiba mais em [`docs/brain/README.md`](docs/brain/README.md).

**Para os agentes:** antes de toda decisão arquitetural, ler `docs/brain/3-resources/adrs/`. Após decidir, registrar um novo ADR.

## Adaptando para sua stack

O template não impõe linguagem. Algumas peças são genéricas (regras, segundo cérebro, GSD, idioma, commits) e outras são específicas de stack — estas últimas podem ser removidas ou mantidas conforme o projeto.

### `.gitignore`

- O `.gitignore` raiz já cobre as linguagens mais comuns (Node, Python, Go, Rust, Java/Kotlin, .NET, PHP, Ruby, Elixir, Swift, etc.) com o essencial.
- Para casos que exigem mais (build systems específicos, ferramentas adicionais), use os templates em [`docs/templates-linguagem/`](docs/templates-linguagem/). Copie o conteúdo do arquivo da sua stack e anexe ao `.gitignore` do projeto, ou substitua o `.gitignore` raiz pelo template correspondente.

### Skills específicas de stack

Algumas skills só fazem sentido em projetos com a stack correspondente. Se o seu projeto **não usa** a tecnologia, remova-as para evitar ruído nos agentes.

| Pasta/skill | Aplica-se a | Como remover se não usar |
|---|---|---|
| `.claude/skills/vue-*` e `create-adaptable-composable` (8 skills Vue.js) | Projetos Vue 3 | `rm -rf .claude/skills/vue-* .claude/skills/create-adaptable-composable` |
| `.cursor/plugins/cache/cursor-public/figma/` | Projetos com integração Figma | `rm -rf .cursor/plugins/cache/cursor-public/figma/` |
| `.cursor/skills/video-editor/` | Projetos de edição de vídeo | `rm -rf .cursor/skills/video-editor/` |
| `.cursor/skills/contagem-ponto-funcao/` | Contratos públicos brasileiros (TRT, TJ, etc.) | `rm -rf .cursor/skills/contagem-ponto-funcao/` |

As skills GSD, Superpowers, debugging e demais utilitários gerais permanecem úteis em qualquer projeto.

### Docker

A seção Docker em [`AGENTS.md`](AGENTS.md#9-docker-e-deploy) só se aplica se o projeto **usa containers**. Em projetos que rodam diretamente na máquina (scripts Python, binários Go compilados, etc.), agentes devem ignorar essa seção inteira.

## Manutenção do template

Quando atualizar uma regra ou skill no seu setup global, replique aqui:

```bash
cp ~/.cursor/rules/*.mdc .cursor/rules/
cp -R ~/.cursor/skills/. .cursor/skills/
cp -RL ~/.claude/skills/. .claude/skills/
cp -R ~/.codex/skills/. .codex/skills/
cp -R ~/.cursor/plugins/cache/cursor-public/. .cursor/plugins/

git add -A
git commit -m "chore: atualiza skills e regras dos agentes"
git push
```

## Licença

Uso pessoal. Adapte como quiser.
