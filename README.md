# repo-padrao

Base única para iniciar qualquer projeto: **aiox-core** (orquestração multi-IDE) + **overlay repo-padrao** (nossas convenções, rules, skills, Superpowers e segundo cérebro).

```
npx aiox-core@latest init   +   overlay repo-padrao   =   projeto pronto
```

O [aiox-core](https://github.com/SynkraAI/aiox-core) configura a infraestrutura de agentes para Cursor, Claude Code, Codex, Gemini CLI, Copilot e outras IDEs. O overlay aplica por cima as convenções deste repositório: idioma pt-BR, TDD, Conventional Commits, entrega funcional, parametrização máxima, Superpowers e `docs/brain/`.

## Iniciar um projeto

```bash
git clone https://github.com/filipefalcaofs/repo-padrao.git
cd repo-padrao
bash scripts/setup.sh meu-projeto
cd ../meu-projeto
```

O `setup.sh` pergunta a stack (Laravel, JHipster, ABP, Django, NestJS, Go ou agnóstico) e deixa o projeto pronto. Modo não interativo:

```bash
bash scripts/setup.sh meu-projeto --stack laravel --variant vue
```

Projeto existente:

```bash
bash scripts/setup.sh --existing /caminho/do/projeto
```

Guia completo: [**docs/COMO_USAR.md**](docs/COMO_USAR.md).

## Estrutura

```
repo-padrao/
├── overlay/              Overlay aplicado nos projetos (ver overlay/README.md)
│   └── base/apply.sh     Aplica rules universais, Superpowers, brain, AGENTS.md
├── scripts/
│   ├── setup.sh          Ponto de entrada: aiox-core + overlay + stack
│   └── choose-stack.sh   Menu de stacks (chama stacks/*/apply-stack.sh)
├── stacks/               Rules e skills por linguagem
│   ├── laravel/          PHP (Inertia vue|react|svelte)
│   ├── jhipster/         Java (angular|react|vue)
│   ├── abp/              .NET C# (angular|react|blazor|mvc)
│   ├── django/           Python
│   ├── nestjs/           TypeScript
│   └── go-api/           Go
├── docs/                 Documentação (comece em docs/README.md)
│   ├── COMO_USAR.md      Fluxo completo de uso
│   └── brain/            Segundo cérebro (copiado nos projetos)
├── AGENTS.md             Convenções universais (copiado nos projetos)
└── CLAUDE.md             Entrada Claude Code do meta-repo
```

## O que cada projeto recebe

| Camada | Origem | Conteúdo |
|---|---|---|
| Infraestrutura | aiox-core (`@latest`) | Agentes (@dev, @qa, @architect…), workflows, suporte multi-IDE |
| Convenções | `overlay/base/` | Rules universais, Superpowers, `docs/brain/`, AGENTS.md, CLAUDE.md |
| Stack | `stacks/<nome>/` | Rules e skills da linguagem escolhida + guia em `docs/stacks/` |

## Modelo anterior (descontinuado)

Os 42 repositórios `repo-padrao-{stack}-{cursor|claude|codex}` foram **arquivados** — eram caros de manter e exigiam escolher IDE antes de clonar. Catálogo e histórico: [**docs/REPOSITORIOS.md**](docs/REPOSITORIOS.md).

## Licença

Uso pessoal. Adapte como quiser.
