# Entidades JPA (JHipster)

## Localização

- Entidade: `src/main/java/.../domain/EntityName.java`
- Metadados: `.jhipster/EntityName.json` (regeneração)

## Regras

- Campos com validação Bean Validation (`@NotNull`, `@Size`, etc.) espelhando JDL.
- Relacionamentos lazy por padrão; `@JsonIgnoreProperties` para evitar loops JSON.
- Não adicionar lógica de negócio pesada na entidade — mover para service.
- Enums em pacote `domain/enumeration/` quando gerados.

## Alterações

Preferir alterar JDL + `jhipster jdl` ou `jhipster entity` para manter repository, DTO, REST e Liquibase sincronizados.

## Anti-padrões

- Expor entidade diretamente no controller REST
- `CascadeType.ALL` sem necessidade
- Queries JPQL inline no controller
