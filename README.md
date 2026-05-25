# repo-padrao

Factory de **templates de projeto** com Superpowers, rules, skills e segundo cérebro para **Cursor, Claude Code, GitHub Copilot, Codex** e demais agentes.

> **Quer iniciar um app?** Não clone este repositório. Use um template standalone no GitHub — comece pelo guia [**Clonagem por linguagem**](docs/CLONAGEM_POR_LINGUAGEM.md).

## Comece aqui

| Perfil | Documento |
|---|---|
| Desenvolvedor — escolher e clonar template | [**docs/CLONAGEM_POR_LINGUAGEM.md**](docs/CLONAGEM_POR_LINGUAGEM.md) |
| Visão geral e catálogo | [**docs/COMO_USAR.md**](docs/COMO_USAR.md) |
| Índice de toda documentação | [**docs/README.md**](docs/README.md) |
| Mantenedor do factory | [**docs/MANUTENCAO.md**](docs/MANUTENCAO.md) |

## Templates no GitHub (14 repos)

Clone direto — stack já aplicada na raiz, sem pasta `stacks/`.

| Linguagem | Repositórios |
|---|---|
| **Agnóstico** | [`repo-padrao-base`](https://github.com/filipefalcaofs/repo-padrao-base) — sem stack; só Superpowers + brain |
| **PHP** | [`laravel-vue`](https://github.com/filipefalcaofs/repo-padrao-laravel-vue) · [`laravel-react`](https://github.com/filipefalcaofs/repo-padrao-laravel-react) · [`laravel-svelte`](https://github.com/filipefalcaofs/repo-padrao-laravel-svelte) |
| **Java** | [`jhipster-angular`](https://github.com/filipefalcaofs/repo-padrao-jhipster-angular) · [`jhipster-react`](https://github.com/filipefalcaofs/repo-padrao-jhipster-react) · [`jhipster-vue`](https://github.com/filipefalcaofs/repo-padrao-jhipster-vue) |
| **.NET (C#)** | [`abp-angular`](https://github.com/filipefalcaofs/repo-padrao-abp-angular) · [`abp-react`](https://github.com/filipefalcaofs/repo-padrao-abp-react) · [`abp-blazor`](https://github.com/filipefalcaofs/repo-padrao-abp-blazor) · [`abp-mvc`](https://github.com/filipefalcaofs/repo-padrao-abp-mvc) |
| **Python** | [`django`](https://github.com/filipefalcaofs/repo-padrao-django) *(secundária)* |
| **TypeScript** | [`nestjs`](https://github.com/filipefalcaofs/repo-padrao-nestjs) *(secundária)* |
| **Go** | [`go-api`](https://github.com/filipefalcaofs/repo-padrao-go-api) *(secundária)* |

## O que cada template inclui

| Camada | Conteúdo |
|---|---|
| Superpowers | `.cursor/plugins/superpowers/` + rule `superpowers.mdc` (TDD, brainstorming, debugging) |
| Rules universais | pt-BR, git, comunicação, Docker |
| Stack | Rules + skills em `.cursor/`, `.claude/skills/`, `.codex/skills/` |
| MCP | Laravel Boost ou ABP Studio (quando aplicável) |
| Segundo cérebro | `docs/brain/` (PARA + ADRs) |

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
| Cursor | `.cursor/rules/`, `.cursor/skills/`, `.cursor/plugins/superpowers/` |
| Claude Code | `CLAUDE.md` + `.claude/skills/` |
| GitHub Copilot | `.github/copilot-instructions.md` |
| Codex / Jules / Aider / outros | `AGENTS.md` + `.codex/skills/` |

## Licença

Uso pessoal. Adapte como quiser.
