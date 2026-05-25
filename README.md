# repo-padrao

Template de repositório com **skills, rules e segundo cérebro** pré-instalados para múltiplos assistentes de IA. Clone este repositório como base de qualquer projeto novo e o ambiente já vem padronizado para Cursor, Claude Code, Antigravity (Google), GitHub Copilot, OpenAI Codex CLI, Jules e qualquer outro agente compatível com `AGENTS.md`.

> **Funciona com qualquer linguagem.** Node.js, Python, Go, Rust, Java, PHP, Ruby, .NET, Elixir, Swift, Kotlin ou qualquer outra. O template é agnóstico de stack — traz disciplina de desenvolvimento com IA, não amarras tecnológicas.

## O que vem pronto

- **Regras universais** em `AGENTS.md` (auto-suficiente — funciona até em agentes que não leem `.cursor/rules/`).
- **Regras específicas** por assistente (`CLAUDE.md`, `.github/copilot-instructions.md`, `.cursor/rules/*.mdc`).
- **Skills** dos principais agentes já incluídas (`.cursor/skills/`, `.cursor/skills-cursor/`, `.cursor/plugins/`, `.claude/skills/`, `.codex/skills/`).
- **Segundo cérebro** (`docs/brain/`) usando metodologia **PARA + CODE** (Tiago Forte) adaptada a projetos de software.
- **Skills [Superpowers](https://github.com/obra/superpowers)** em `.cursor/plugins/superpowers/` (plugin oficial v5.x — TDD, brainstorming, debugging, code review).
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

### Projetos Laravel + Inertia

Após clonar, escolha o adapter frontend (Vue, React ou Svelte):

```bash
./stacks/laravel/scripts/choose-inertia-adapter.sh
# ou não interativo:
./stacks/laravel/scripts/choose-inertia-adapter.sh --adapter vue --yes
```

Isso instala **apenas** a skill Inertia escolhida e grava `.laravel-stack.json`. Ver [`docs/stacks/LARAVEL.md`](docs/stacks/LARAVEL.md).

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
8. **Superpowers** — workflow oficial [obra/superpowers](https://github.com/obra/superpowers): TDD, brainstorming, debugging e code review via `.cursor/plugins/superpowers/`.
9. **Docker** — sempre `docker buildx --platform linux/amd64` (dev é ARM, prod é AMD64).
10. **Segundo cérebro** — conhecimento em `docs/brain/`, decisões arquiteturais em `docs/brain/3-resources/adrs/`.
11. **Git** — nunca versionar `.env`, segredos, builds; nunca alterar `git config`.

## Estrutura

```
repo-padrao/
├── .cursor/
│   ├── rules/                   Regras Cursor (.mdc) — lidas automaticamente
│   ├── skills/                  Skills de stack e utilitários
│   ├── skills-cursor/           Skills internas Cursor
│   └── plugins/
│       └── superpowers/         Plugin oficial obra/superpowers (v5.x)
├── .claude/
│   └── skills/                  Skills Claude Code
├── .codex/
│   └── skills/                  Skills OpenAI Codex CLI
├── .github/
│   └── copilot-instructions.md  Instrucoes GitHub Copilot
├── stacks/
│   └── laravel/                 Stack Laravel Boost (rules, skills, MCP)
├── docs/
│   ├── COMO_USAR.md             Como usar este template
│   ├── stacks/LARAVEL.md        Guia Laravel + Boost
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

## Superpowers ([obra/superpowers](https://github.com/obra/superpowers))

Disciplina de código vem do **[Superpowers](https://github.com/obra/superpowers)** de Jesse Vincent — não de skills customizadas nem de GSD.

| Item | Caminho / detalhe |
|---|---|
| Plugin oficial | `.cursor/plugins/superpowers/` (cópia vendored do marketplace Cursor) |
| Rule de enforcement | `.cursor/rules/superpowers.mdc` (resumo em pt-BR) |
| Skills incluídas | `brainstorming`, `test-driven-development`, `systematic-debugging`, `verification-before-completion`, `writing-plans`, `executing-plans`, `subagent-driven-development`, `using-git-worktrees`, `requesting-code-review`, etc. |
| Fonte upstream | https://github.com/obra/superpowers |

### Instalação no Cursor

O template **já inclui** o plugin. Em projetos novos no Cursor, você também pode instalar/atualizar direto do marketplace:

```text
/add-plugin superpowers
```

### Atualizar a cópia vendored

```bash
cp -R ~/.cursor/plugins/cache/cursor-public/superpowers/. .cursor/plugins/superpowers/
# ou reinstalar via /add-plugin superpowers e copiar do cache local
```

## Stack Laravel (Laravel Boost)

Projetos PHP/Laravel já incluem **rules e skills** baseadas na documentação [AI Assisted Development — Laravel 13.x](https://laravel.com/docs/13.x/ai) e [Laravel Boost](https://laravel.com/docs/13.x/boost):

| Recurso | Caminho |
|---|---|
| Rules Cursor | `.cursor/rules/laravel-core.mdc`, `laravel-boost.mdc`, `laravel-inertia.mdc` |
| Skills backend | `laravel-best-practices`, `laravel-boost`, `pest-testing` |
| Skills Inertia | escolher no clone — `inertia-vue-development`, `inertia-react-development` ou `inertia-svelte-development` |
| Stack completo | [`stacks/laravel/`](stacks/laravel/) |
| Guia | [`docs/stacks/LARAVEL.md`](docs/stacks/LARAVEL.md) |

Após criar o app Laravel:

```bash
composer require laravel/boost --dev
php artisan boost:install
cp stacks/laravel/.mcp.json.example .mcp.json   # se necessário
```

Habilitar `laravel-boost` em MCP Settings no Cursor.

## Adaptando para sua stack

O template não impõe linguagem. Algumas peças são genéricas (regras, segundo cérebro, Superpowers, idioma, commits) e outras são específicas de stack — estas últimas podem ser removidas ou mantidas conforme o projeto.

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
| `.cursor/rules/laravel-*.mdc` e skills `laravel-*`, `pest-testing`, `inertia-*` | Projetos Laravel + Inertia | Ver [`docs/stacks/LARAVEL.md`](docs/stacks/LARAVEL.md) |
| `stacks/laravel/.cursor/skills/livewire-development` | Livewire 4 | `rm -rf stacks/laravel/.cursor/skills/livewire-development` |
| `stacks/laravel/.cursor/skills/tailwindcss-development` | Tailwind CSS | `rm -rf stacks/laravel/.cursor/skills/tailwindcss-development` |

As skills Superpowers, Laravel, debugging e demais utilitários gerais permanecem úteis em qualquer projeto.

### Docker

A seção Docker em [`AGENTS.md`](AGENTS.md#8-docker-e-deploy) só se aplica se o projeto **usa containers**. Em projetos que rodam diretamente na máquina (scripts Python, binários Go compilados, etc.), agentes devem ignorar essa seção inteira.

## Manutenção do template

Quando atualizar uma regra ou skill no seu setup global, replique aqui:

```bash
cp ~/.cursor/rules/*.mdc .cursor/rules/
cp -R ~/.cursor/skills/. .cursor/skills/
cp -RL ~/.claude/skills/. .claude/skills/
cp -R ~/.codex/skills/. .codex/skills/
cp -R ~/.cursor/plugins/cache/cursor-public/superpowers/. .cursor/plugins/superpowers/

git add -A
git commit -m "chore: atualiza skills e regras dos agentes"
git push
```

## Licença

Uso pessoal. Adapte como quiser.
