---
name: jhipster-angular-development
description: "Aplicar ao desenvolver frontend JHipster com Angular: componentes CRUD gerados, modules, routing, HttpClient, i18n ngx-translate, formulários reativos e integração com API /api. Usar em src/main/webapp/app/** quando .yo-rc.json ou .jhipster-stack.json indica frontend angular."
license: MIT
metadata:
  author: repo-padrao
---

# JHipster + Angular

Frontend padrão histórico do JHipster. Código em `src/main/webapp/app/`.

## Estrutura típica

- `entities/` — CRUD gerado por entidade
- `core/` — auth, interceptors, config
- `shared/` — componentes reutilizáveis
- `admin/` — administração usuários, métricas, health

## Padrões

- **Standalone components** ou NgModules — seguir o que o gerador produziu na versão do projeto
- Services injectable para chamadas HTTP (`EntityService`)
- Formulários reativos (`FormGroup`) nos dialogs de edição gerados
- i18n: `jhiTranslate` / arquivos JSON em `i18n/{lang}/`

## Novas telas

1. Preferir estender entity module gerado
2. Rotas em `entity.routes.ts` ou routing module da entidade
3. Reutilizar `AlertService`, `EventManager`, padrões de delete dialog

## Build / test

```bash
npm start
npm test
npm run webapp:build
```

## Não fazer

- Substituir HttpClient por fetch sem alinhar interceptors JWT
- Hardcodar strings — usar chaves i18n
- Ignorar tipos TypeScript gerados em `app/entities/*/`
