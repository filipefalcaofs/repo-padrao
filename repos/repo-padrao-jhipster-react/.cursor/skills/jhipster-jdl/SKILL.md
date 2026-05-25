---
name: jhipster-jdl
description: "Aplicar ao criar ou editar arquivos JDL (.jdl), importar modelos de domínio, definir entidades, enums, relacionamentos, opções paginate/dto/service e regenerar código JHipster. Usar antes de jhipster jdl ou jhipster entity em lote."
license: MIT
metadata:
  author: repo-padrao
---

# JHipster JDL

Workflow para [JHipster Domain Language](https://www.jhipster.tech/jdl/intro/).

## Fluxo recomendado

1. Ler `.yo-rc.json` — tipo de app, banco, auth, frontend.
2. Modelar entidades e relacionamentos no `.jdl`.
3. Validar sintaxe (IDE plugin ou `jhipster jdl --inline "entity A { name String }"` em dry-run quando disponível).
4. Importar: `jhipster jdl model.jdl`.
5. Revisar diff: domain, liquibase, REST, frontend CRUD, i18n.

## Opções JDL frequentes

| Opção | Efeito |
|---|---|
| `dto X with mapstruct` | DTO + mapper REST |
| `service X with serviceClass` | Service layer |
| `paginate X with pagination` | Lista paginada |
| `paginate X with infinite-scroll` | Scroll infinito |
| `filter X` | Filtros na API |
| `search X with elasticsearch` | Busca ES (se módulo ativo) |
| `microservice X` | Nome do microservice (arquitetura MS) |

## Relacionamentos

```jdl
relationship OneToMany {
  Category{product(name)} to Product{category(name)}
}

relationship ManyToOne {
  Order{customer(required)} to Customer
}

relationship ManyToMany {
  Employee{project} to Project{employee}
}
```

Lado `required` define nullability FK.

## Microservices

Em apps gateway + microservices, declarar `microservice EntityName with servicename` e importar JDL no serviço correto.

## Regeneração

- `--force` — aceita sobrescrever arquivos gerados (cuidado com customizações manuais)
- Customizações em `src/main/java` devem ir para `.jhipster/Entity.json` ou blueprints — evitar editar código gerado que será perdido

## Referências

- [JDL syntax](https://www.jhipster.tech/jdl/options)
- [Application options in JDL](https://www.jhipster.tech/jdl/applications)
