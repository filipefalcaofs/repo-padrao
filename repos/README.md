# Repositórios standalone

Cada pasta é um **repositório Git independente** — clone direto com stack e variantes já configuradas.

Gerar/atualizar a partir do meta-repo:

```bash
bash scripts/build-standalone-repos.sh --clean
```

## Catálogo

| Repositório | Stack |
|---|---|
| `repo-padrao-base` | Agnóstico (sem stack) |
| `repo-padrao-laravel-vue` | Laravel + Inertia Vue |
| `repo-padrao-laravel-react` | Laravel + Inertia React |
| `repo-padrao-laravel-svelte` | Laravel + Inertia Svelte |
| `repo-padrao-jhipster-angular` | JHipster + Angular |
| `repo-padrao-jhipster-react` | JHipster + React |
| `repo-padrao-jhipster-vue` | JHipster + Vue |
| `repo-padrao-abp-angular` | ABP + Angular |
| `repo-padrao-abp-react` | ABP + React modern |
| `repo-padrao-abp-blazor` | ABP + Blazor |
| `repo-padrao-abp-mvc` | ABP + MVC |

### Stacks secundárias

| Repositório | Stack |
|---|---|
| `repo-padrao-django` | Django + DRF |
| `repo-padrao-nestjs` | NestJS API |
| `repo-padrao-go-api` | Go REST API |

## Publicar no GitHub

```bash
cd repos/repo-padrao-laravel-vue
git init
git add -A
git commit -m "chore: template repo-padrao-laravel-vue"
git remote add origin git@github.com:filipefalcaofs/repo-padrao-laravel-vue.git
git push -u origin main
```

Repita para cada pasta.
