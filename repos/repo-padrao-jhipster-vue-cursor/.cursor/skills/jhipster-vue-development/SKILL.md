---
name: jhipster-vue-development
description: "Aplicar ao desenvolver frontend JHipster com Vue: componentes CRUD gerados, Vue Router, serviços axios, i18n vue-i18n, composition API ou options API conforme versão. Usar em src/main/webapp/app/** quando frontend vue."
license: MIT
metadata:
  author: repo-padrao
---

# JHipster + Vue

Frontend Vue gerado pelo JHipster. Código em `src/main/webapp/app/`.

## Estrutura típica

- `entities/` — componentes list, view, edit, service
- `core/` — home, error, jwt
- `router/` — rotas principais
- `shared/` — alert, data utils

## Padrões

- Vue Router — rotas lazy-loaded conforme gerador
- Services TS por entidade (`entity.service.ts`)
- i18n: `$t()` / arquivos em `i18n/`
- Composition API ou Options API — seguir entidades existentes

## Novas telas

1. Duplicar par list/edit/service de entity similar
2. Registrar rota em `router/entities.ts`
3. Model TypeScript em `shared/model/`

## Build / test

```bash
npm start
npm test
npm run webapp:build
```

## Não fazer

- Mutar props diretamente sem padrão do projeto
- Ignorar validação de formulário espelhando Bean Validation backend
- Mix de Vue 2 e Vue 3 APIs
