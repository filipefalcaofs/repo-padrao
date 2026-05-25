# Templates gerados (`repos/`)

Cópias locais dos **14 repositórios standalone**, produzidas por `bash scripts/build-standalone-repos.sh`.

> **Para iniciar um projeto**, clone no GitHub — não use esta pasta como destino final. Guia: [**docs/CLONAGEM_POR_LINGUAGEM.md**](../docs/CLONAGEM_POR_LINGUAGEM.md).

## Catálogo (links GitHub)

| Repositório | Linguagem | Clone |
|---|---|---|
| [repo-padrao-base](https://github.com/filipefalcaofs/repo-padrao-base) | Agnóstico | Sem stack — Superpowers + brain |
| [repo-padrao-laravel-vue](https://github.com/filipefalcaofs/repo-padrao-laravel-vue) | PHP | Laravel + Inertia Vue |
| [repo-padrao-laravel-react](https://github.com/filipefalcaofs/repo-padrao-laravel-react) | PHP | Laravel + Inertia React |
| [repo-padrao-laravel-svelte](https://github.com/filipefalcaofs/repo-padrao-laravel-svelte) | PHP | Laravel + Inertia Svelte |
| [repo-padrao-jhipster-angular](https://github.com/filipefalcaofs/repo-padrao-jhipster-angular) | Java | JHipster + Angular |
| [repo-padrao-jhipster-react](https://github.com/filipefalcaofs/repo-padrao-jhipster-react) | Java | JHipster + React |
| [repo-padrao-jhipster-vue](https://github.com/filipefalcaofs/repo-padrao-jhipster-vue) | Java | JHipster + Vue |
| [repo-padrao-abp-angular](https://github.com/filipefalcaofs/repo-padrao-abp-angular) | .NET (C#) | ABP + Angular |
| [repo-padrao-abp-react](https://github.com/filipefalcaofs/repo-padrao-abp-react) | .NET (C#) | ABP + React |
| [repo-padrao-abp-blazor](https://github.com/filipefalcaofs/repo-padrao-abp-blazor) | .NET (C#) | ABP + Blazor |
| [repo-padrao-abp-mvc](https://github.com/filipefalcaofs/repo-padrao-abp-mvc) | .NET (C#) | ABP + MVC |
| [repo-padrao-django](https://github.com/filipefalcaofs/repo-padrao-django) | Python | Django + DRF |
| [repo-padrao-nestjs](https://github.com/filipefalcaofs/repo-padrao-nestjs) | TypeScript | NestJS API |
| [repo-padrao-go-api](https://github.com/filipefalcaofs/repo-padrao-go-api) | Go | Go REST API |

## Regenerar (mantenedores)

```bash
bash scripts/build-standalone-repos.sh --clean
bash scripts/push-standalone-repos.sh
```

Ver [**docs/MANUTENCAO.md**](../docs/MANUTENCAO.md).
