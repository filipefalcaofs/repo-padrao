# Templates gerados (`repos/`)

Cópias locais dos **42 repositórios standalone** (14 stacks × 3 IDEs), produzidas por `bash scripts/build-standalone-repos.sh`.

> Clone no GitHub com suffix **`-cursor`**, **`-claude`** ou **`-codex`**. Guia: [**docs/CLONAGEM_POR_LINGUAGEM.md**](../docs/CLONAGEM_POR_LINGUAGEM.md).

## Convenção de nome

```
repo-padrao-{stack}-{cursor|claude|codex}
```

Exemplos: `repo-padrao-laravel-vue-cursor`, `repo-padrao-django-claude`, `repo-padrao-base-codex`.

## Stacks (×3 IDEs cada)

| Base do nome | Linguagem | Stack |
|---|---|---|
| `repo-padrao-base` | Agnóstico | Superpowers + brain |
| `repo-padrao-laravel-vue` | PHP | Laravel + Inertia Vue |
| `repo-padrao-laravel-react` | PHP | Laravel + Inertia React |
| `repo-padrao-laravel-svelte` | PHP | Laravel + Inertia Svelte |
| `repo-padrao-jhipster-angular` | Java | JHipster + Angular |
| `repo-padrao-jhipster-react` | Java | JHipster + React |
| `repo-padrao-jhipster-vue` | Java | JHipster + Vue |
| `repo-padrao-abp-angular` | .NET | ABP + Angular |
| `repo-padrao-abp-react` | .NET | ABP + React |
| `repo-padrao-abp-blazor` | .NET | ABP + Blazor |
| `repo-padrao-abp-mvc` | .NET | ABP + MVC |
| `repo-padrao-django` | Python | Django + DRF |
| `repo-padrao-nestjs` | TypeScript | NestJS API |
| `repo-padrao-go-api` | Go | Go REST API |

## Regenerar (mantenedores)

```bash
bash scripts/build-standalone-repos.sh --clean
bash scripts/push-standalone-repos.sh
```

Ver [**docs/MANUTENCAO.md**](../docs/MANUTENCAO.md).
