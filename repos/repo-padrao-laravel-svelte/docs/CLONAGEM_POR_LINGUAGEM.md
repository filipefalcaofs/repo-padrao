# Clonagem por linguagem

Escolha o repositório **standalone** pela linguagem (e frontend, quando houver) que você vai usar no projeto. Cada template já traz Superpowers, rules universais, rules/skills da stack e `docs/brain/`.

> Não clone o meta-repo [`repo-padrao`](https://github.com/filipefalcaofs/repo-padrao) para iniciar um app — ele serve só para gerar e manter os templates.

## Resumo rápido

| Linguagem | Repositório(s) | Guia da stack |
|---|---|---|
| **PHP** | [`repo-padrao-laravel-vue`](https://github.com/filipefalcaofs/repo-padrao-laravel-vue) · [`-react`](https://github.com/filipefalcaofs/repo-padrao-laravel-react) · [`-svelte`](https://github.com/filipefalcaofs/repo-padrao-laravel-svelte) | [`LARAVEL.md`](stacks/LARAVEL.md) |
| **Java** | [`repo-padrao-jhipster-angular`](https://github.com/filipefalcaofs/repo-padrao-jhipster-angular) · [`-react`](https://github.com/filipefalcaofs/repo-padrao-jhipster-react) · [`-vue`](https://github.com/filipefalcaofs/repo-padrao-jhipster-vue) | [`JHIPSTER.md`](stacks/JHIPSTER.md) |
| **.NET (C#)** | [`repo-padrao-abp-angular`](https://github.com/filipefalcaofs/repo-padrao-abp-angular) · [`-react`](https://github.com/filipefalcaofs/repo-padrao-abp-react) · [`-blazor`](https://github.com/filipefalcaofs/repo-padrao-abp-blazor) · [`-mvc`](https://github.com/filipefalcaofs/repo-padrao-abp-mvc) | [`ABP.md`](stacks/ABP.md) |
| **Python** | [`repo-padrao-django`](https://github.com/filipefalcaofs/repo-padrao-django) | [`DJANGO.md`](stacks/DJANGO.md) |
| **TypeScript** | [`repo-padrao-nestjs`](https://github.com/filipefalcaofs/repo-padrao-nestjs) | [`NESTJS.md`](stacks/NESTJS.md) |
| **Go** | [`repo-padrao-go-api`](https://github.com/filipefalcaofs/repo-padrao-go-api) | [`GO.md`](stacks/GO.md) |
| **Indefinida** | [`repo-padrao-base`](https://github.com/filipefalcaofs/repo-padrao-base) | — |

---

## PHP — Laravel + Inertia

**Quando usar:** API e backend em PHP com Laravel; frontend SPA via Inertia (Vue, React ou Svelte).

| Variante | Repositório | Frontend |
|---|---|---|
| Padrão | `repo-padrao-laravel-vue` | Vue 3 |
| React | `repo-padrao-laravel-react` | React |
| Svelte | `repo-padrao-laravel-svelte` | Svelte |

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-laravel-vue.git meu-app
cd meu-app
rm -rf .git && git init
composer create-project laravel/laravel .
composer require laravel/boost --dev
php artisan boost:install
```

Pré-requisitos: PHP 8.2+, Composer, Node.js (para assets Inertia).

Guia completo: [`docs/stacks/LARAVEL.md`](stacks/LARAVEL.md).

---

## Java — JHipster (Spring Boot)

**Quando usar:** monolito ou full-stack em Java com Spring Boot; frontend Angular, React ou Vue gerado pelo JHipster.

| Variante | Repositório | Frontend |
|---|---|---|
| Angular | `repo-padrao-jhipster-angular` | Angular |
| React | `repo-padrao-jhipster-react` | React |
| Vue | `repo-padrao-jhipster-vue` | Vue |

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-jhipster-angular.git meu-app
cd meu-app
rm -rf .git && git init
npm install -g generator-jhipster
jhipster
```

Pré-requisitos: JDK 17+, Maven ou Gradle, Node.js.

Guia completo: [`docs/stacks/JHIPSTER.md`](stacks/JHIPSTER.md).

---

## .NET (C#) — ABP Framework

**Quando usar:** aplicações enterprise em .NET com ABP (DDD, multi-tenancy, modular).

| Variante | Repositório | UI |
|---|---|---|
| Angular (clássico) | `repo-padrao-abp-angular` | Angular |
| React modern | `repo-padrao-abp-react` | React |
| Blazor | `repo-padrao-abp-blazor` | Blazor |
| MVC | `repo-padrao-abp-mvc` | Razor MVC |

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-abp-angular.git meu-app
cd meu-app
rm -rf .git && git init
abp new MeuApp -u ng -d ef
```

Pré-requisitos: .NET SDK, ABP CLI, ABP Studio (MCP). O template inclui `.mcp.json`.

Guia completo: [`docs/stacks/ABP.md`](stacks/ABP.md).

---

## Python — Django + DRF

**Quando usar:** APIs REST ou backends web em Python com Django e Django REST Framework.

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-django.git meu-app
cd meu-app
rm -rf .git && git init
python -m venv .venv && source .venv/bin/activate
pip install django djangorestframework pytest-django
django-admin startproject config .
```

Pré-requisitos: Python 3.11+.

Guia completo: [`docs/stacks/DJANGO.md`](stacks/DJANGO.md).

---

## TypeScript — NestJS API

**Quando usar:** APIs REST ou microserviços em Node.js com NestJS.

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-nestjs.git meu-app
cd meu-app
rm -rf .git && git init
npx @nestjs/cli new . --package-manager npm
```

Pré-requisitos: Node.js 20+, npm ou pnpm.

Guia completo: [`docs/stacks/NESTJS.md`](stacks/NESTJS.md).

---

## Go — REST API

**Quando usar:** APIs REST enxutas em Go (layout `cmd/` + `internal/`).

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-go-api.git meu-api
cd meu-api
rm -rf .git && git init
go mod init github.com/seu-usuario/meu-api
mkdir -p cmd/api internal/handler internal/service internal/repository
```

Pré-requisitos: Go 1.22+.

Guia completo: [`docs/stacks/GO.md`](stacks/GO.md).

---

## Sem linguagem definida — base agnóstica

**Quando usar:** ainda não escolheu stack, ou quer só Superpowers + segundo cérebro + rules universais.

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-base.git meu-projeto
cd meu-projeto
rm -rf .git && git init
```

Depois de definir a linguagem, migre para o template correspondente ou aplique rules manualmente a partir do meta-repo.

---

## Após clonar (qualquer linguagem)

1. `rm -rf .git && git init` — ou **Use this template** no GitHub.
2. Crie o projeto da stack na raiz (comandos acima).
3. Registre a escolha em `docs/brain/3-resources/adrs/0001-escolha-de-stack.md`.
4. Opcional: ajuste `.gitignore` com [`docs/templates-linguagem/`](templates-linguagem/README.md).

Catálogo completo: [repos/README.md no meta-repo](https://github.com/filipefalcaofs/repo-padrao/blob/main/repos/README.md) · uso geral: [`COMO_USAR.md`](COMO_USAR.md).
