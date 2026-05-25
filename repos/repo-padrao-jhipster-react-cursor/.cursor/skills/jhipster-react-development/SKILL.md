---
name: jhipster-react-development
description: "Aplicar ao desenvolver frontend JHipster com React: componentes CRUD gerados, React Router, redux ou hooks conforme versão, axios/fetch com interceptors, react-jhipster, i18n. Usar em src/main/webapp/app/** quando frontend react."
license: MIT
metadata:
  author: repo-padrao
---

# JHipster + React

Frontend React gerado pelo JHipster. Código em `src/main/webapp/app/`.

## Estrutura típica

- `entities/` — list, detail, update, reducers (conforme versão)
- `modules/` — account, admin, home
- `shared/` — layout, auth, util

## Padrões

- Rotas com React Router — seguir `routes.tsx` gerado
- Estado: Redux Toolkit ou hooks — não misturar padrões novos sem necessidade
- Chamadas API via services/utilities gerados
- i18n: `translate` + JSON em `i18n/`

## Novas telas

1. Copiar estrutura de entity irmã (list + update + reducer)
2. Registrar rota no módulo de entities
3. Tipos em `app/shared/model/`

## Build / test

```bash
npm start
npm test
npm run webapp:build
```

## Não fazer

- Bypass do interceptor de autenticação
- Componentes class-based se o projeto usa function components
- Endpoints fora de `/api` sem config de proxy
