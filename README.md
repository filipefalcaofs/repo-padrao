# repo-padrao

Factory de **templates de projeto** com Superpowers, rules, skills e segundo cérebro para **Cursor**, **Claude Code** e **Codex**.

> **Quer iniciar um app?** Não clone este repositório. Escolha **stack + IDE** (`-cursor`, `-claude` ou `-codex`) — guia [**Clonagem por linguagem e IDE**](docs/CLONAGEM_POR_LINGUAGEM.md).

## Comece aqui

| Perfil | Documento |
|---|---|
| Desenvolvedor — escolher e clonar template | [**docs/CLONAGEM_POR_LINGUAGEM.md**](docs/CLONAGEM_POR_LINGUAGEM.md) |
| Visão geral e catálogo | [**docs/COMO_USAR.md**](docs/COMO_USAR.md) |
| Índice de toda documentação | [**docs/README.md**](docs/README.md) |
| Mantenedor do factory | [**docs/MANUTENCAO.md**](docs/MANUTENCAO.md) |

## Templates no GitHub (42 repos)

Convenção: `repo-padrao-{stack}-{cursor|claude|codex}` — **somente** os arquivos da stack e da IDE escolhidas.

| Linguagem | Base do nome (×3 IDEs) |
|---|---|
| **Agnóstico** | `repo-padrao-base` |
| **PHP** | `repo-padrao-laravel-vue` · `-react` · `-svelte` |
| **Java** | `repo-padrao-jhipster-angular` · `-react` · `-vue` |
| **.NET (C#)** | `repo-padrao-abp-angular` · `-react` · `-blazor` · `-mvc` |
| **Python** | `repo-padrao-django` |
| **TypeScript** | `repo-padrao-nestjs` |
| **Go** | `repo-padrao-go-api` |

Exemplo: `git clone …/repo-padrao-laravel-vue-cursor.git` ou `…/repo-padrao-django-claude.git`.

## O que cada template inclui

Cada clone traz **apenas a camada da IDE escolhida** + stack + `docs/brain/`.

| IDE | Conteúdo no repo |
|---|---|
| **Cursor** (`-cursor`) | `.cursor/rules/`, `.cursor/skills/`, Superpowers plugin, MCP (Laravel/ABP) |
| **Claude Code** (`-claude`) | `CLAUDE.md`, `.claude/skills/` (stack + Superpowers) |
| **Codex** (`-codex`) | `AGENTS.md`, `.codex/skills/` (stack + Superpowers) |

## Estrutura deste meta-repo

Este repositório é a **fonte do factory** — não é base de aplicação.

```
repo-padrao/
├── docs/                 Documentação (comece em docs/README.md)
│   ├── CLONAGEM_POR_LINGUAGEM.md
│   ├── COMO_USAR.md
│   ├── MANUTENCAO.md
│   ├── brain/            Segundo cérebro (copiado nos templates)
│   └── stacks/           Guias por stack (Laravel, ABP, …)
├── stacks/               Fontes das rules/skills por linguagem
│   ├── laravel/          PHP
│   ├── jhipster/         Java
│   ├── abp/              .NET (C#)
│   ├── django/           Python
│   ├── nestjs/           TypeScript
│   └── go-api/           Go
├── scripts/              build e publicação dos standalone
├── repos/                Cópias geradas localmente (espelho dos repos GitHub)
├── AGENTS.md             Instruções para qualquer agente de IA
└── CLAUDE.md             Entrada Claude Code
```

A pasta `repos/` contém **artefatos gerados** para manutenção. Para novos projetos, clone os repositórios standalone no GitHub (links acima).

## Assistentes suportados

| Assistente | Entrada principal |
|---|---|
| **Cursor** | `.cursor/rules/`, `.cursor/skills/`, `.cursor/plugins/superpowers/` |
| **Claude Code** | `CLAUDE.md` + `.claude/skills/` |
| **Codex** | `AGENTS.md` + `.codex/skills/` |

## Licença

Uso pessoal. Adapte como quiser.
