# Repositórios standalone

Cada pasta é um **repositório Git independente** — clone direto com stack e variantes já configuradas.

**Escolher pela linguagem:** [`../docs/CLONAGEM_POR_LINGUAGEM.md`](../docs/CLONAGEM_POR_LINGUAGEM.md)

Gerar/atualizar a partir do meta-repo:

```bash
bash scripts/build-standalone-repos.sh --clean
```

## Catálogo

| Repositório | Linguagem | Stack |
|---|---|---|
| `repo-padrao-base` | — | Agnóstico (sem stack) |
| `repo-padrao-laravel-vue` | PHP | Laravel + Inertia Vue |
| `repo-padrao-laravel-react` | PHP | Laravel + Inertia React |
| `repo-padrao-laravel-svelte` | PHP | Laravel + Inertia Svelte |
| `repo-padrao-jhipster-angular` | Java | JHipster + Angular |
| `repo-padrao-jhipster-react` | Java | JHipster + React |
| `repo-padrao-jhipster-vue` | Java | JHipster + Vue |
| `repo-padrao-abp-angular` | .NET (C#) | ABP + Angular |
| `repo-padrao-abp-react` | .NET (C#) | ABP + React modern |
| `repo-padrao-abp-blazor` | .NET (C#) | ABP + Blazor |
| `repo-padrao-abp-mvc` | .NET (C#) | ABP + MVC |

### Stacks secundárias

| Repositório | Linguagem | Stack |
|---|---|---|
| `repo-padrao-django` | Python | Django + DRF |
| `repo-padrao-nestjs` | TypeScript | NestJS API |
| `repo-padrao-go-api` | Go | Go REST API |

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
