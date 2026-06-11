# Iniciar projeto por linguagem

> **Modelo atual:** um único repositório (`repo-padrao`) + setup com aiox-core. Não é mais preciso escolher IDE antes de clonar — o aiox-core configura todas (Cursor, Claude Code, Codex, Gemini CLI e outras) de uma vez.
>
> Os antigos repositórios `repo-padrao-{stack}-{cursor|claude|codex}` foram **arquivados**. Ver [REPOSITORIOS.md](REPOSITORIOS.md).

## Fluxo único

```bash
git clone https://github.com/filipefalcaofs/repo-padrao.git
cd repo-padrao
bash scripts/setup.sh meu-projeto --stack <stack> [--variant <variante>]
cd ../meu-projeto
```

Sem `--stack`, o menu interativo é exibido. Fluxo completo: [**COMO_USAR.md**](COMO_USAR.md).

## Passo 1 — Escolha a stack

| Linguagem | `--stack` | `--variant` | Guia |
|---|---|---|---|
| **Agnóstico** | `none` | — | — |
| **PHP** (Laravel + Inertia) | `laravel` | `vue` · `react` · `svelte` | [LARAVEL.md](stacks/LARAVEL.md) |
| **Java** (JHipster) | `jhipster` | `angular` · `react` · `vue` | [JHIPSTER.md](stacks/JHIPSTER.md) |
| **.NET C#** (ABP) | `abp` | `angular` · `react` · `blazor` · `mvc` | [ABP.md](stacks/ABP.md) |
| **Python** (Django + DRF) | `django` | — | [DJANGO.md](stacks/DJANGO.md) |
| **TypeScript** (NestJS) | `nestjs` | — | [NESTJS.md](stacks/NESTJS.md) |
| **Go** (REST API) | `go-api` | — | [GO.md](stacks/GO.md) |

## Passo 2 — Crie o esqueleto da aplicação

Após o `setup.sh`, crie o projeto da stack na raiz (comandos detalhados nos guias em `docs/stacks/`):

### PHP — Laravel + Inertia

```bash
bash scripts/setup.sh meu-app --stack laravel --variant vue
cd ../meu-app
composer create-project laravel/laravel .
composer require laravel/boost --dev && php artisan boost:install
# Habilitar laravel-boost no MCP Settings (Cursor)
```

### Python — Django

```bash
bash scripts/setup.sh meu-app --stack django
cd ../meu-app
python -m venv .venv && source .venv/bin/activate
pip install django djangorestframework pytest-django
django-admin startproject config .
```

### Go — REST API

```bash
bash scripts/setup.sh meu-api --stack go-api
cd ../meu-api
go mod init github.com/seu-usuario/meu-api
mkdir -p cmd/api internal/handler internal/service internal/repository
```

### Java — JHipster

```bash
bash scripts/setup.sh meu-app --stack jhipster --variant angular
cd ../meu-app
npm install -g generator-jhipster
jhipster
```

### .NET — ABP

```bash
bash scripts/setup.sh meu-app --stack abp --variant angular
cd ../meu-app
abp new MeuApp -u ng -d ef
```

### TypeScript — NestJS

```bash
bash scripts/setup.sh meu-app --stack nestjs
cd ../meu-app
npx @nestjs/cli new . --package-manager npm
```

## Passo 3 — Registre a decisão

Registre a escolha da stack em `docs/brain/3-resources/adrs/0001-escolha-de-stack.md` no projeto criado.

## Projeto existente

```bash
cd repo-padrao
bash scripts/setup.sh --existing /caminho/do/projeto --stack <stack>
```
