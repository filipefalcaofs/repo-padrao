---
name: jhipster-development
description: "Aplicar ao escrever, revisar ou refatorar código backend JHipster (Spring Boot + JPA). Inclui entidades, repositories, services, DTOs, mappers MapStruct, controllers REST, Liquibase, segurança e arquitetura monolith/microservice. Usar em tarefas Java geradas ou estendidas pelo JHipster."
license: MIT
metadata:
  author: repo-padrao
---

# JHipster Development

Boas práticas para aplicações [JHipster](https://www.jhipster.tech/) 8+. Conteúdo **custom** do repo-padrao (sem pacote oficial tipo Laravel Boost).

## Consistência primeiro

Antes de aplicar qualquer regra, verificar o que entidades e controllers irmãos já fazem. JHipster gera código repetível — o melhor padrão é o que o projeto já segue.

## Referência rápida

### 1. Entidades e JPA → `rules/entities.md`

- Domain entities em `domain/`; não expor na API REST
- `@Column`, `@ManyToOne`, `@OneToMany` conforme JDL/gerador
- `equals`/`hashCode` só no ID (padrão JHipster)
- Evitar `EAGER` em coleções grandes

### 2. REST API → `rules/rest-api.md`

- Controllers finos; lógica no service
- DTOs de entrada/saída; MapStruct para conversão
- Paginação, filtros, ordenação alinhados aos endpoints gerados
- Problem Details / `ExceptionTranslator` do JHipster para erros

### 3. Liquibase → `rules/liquibase.md`

- Changelog master + incremental por entidade
- Nunca editar changelog já aplicado em produção — novo changeset
- Tipos compatíveis com dialect configurado (PostgreSQL, MySQL, etc.)

### 4. Services → `rules/services.md`

- `@Transactional` na camada service (read-only quando consulta)
- Optional e exceções `*NotFoundException` geradas
- Cache `@Cacheable` só quando o projeto já usa cache

### 5. Segurança → `rules/security.md`

- Roles `ROLE_ADMIN`, `ROLE_USER` — estender, não substituir
- `@PreAuthorize` consistente com `SecurityConfiguration`
- Endpoints públicos explícitos em config

### 6. Testes → `rules/testing.md`

- Testes de service com mocks
- `@AutoConfigureMockMvc` + JWT token em testes REST
- Ativar skill `spring-testing` para padrões detalhados

## Comandos úteis

```bash
jhipster entity Nome --fields "campo Tipo" --dto mapstruct --service serviceClass
jhipster jdl model.jdl
./mvnw test                           # Maven
./gradlew test -x webapp_test         # Gradle
npm run webapp:test                   # frontend (se configurado)
```

## Documentação

- [Creating an application](https://www.jhipster.tech/creating-an-app/)
- [Using JDL](https://www.jhipster.tech/jdl/intro/)
- [Entities and relationships](https://www.jhipster.tech/creating-an-entity/)
