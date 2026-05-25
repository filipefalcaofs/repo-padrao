# Services (JHipster)

## Responsabilidade

- Orquestrar repositories, mappers e regras de negócio
- `@Transactional` no nível de classe ou método público
- `@Transactional(readOnly = true)` em consultas

## Padrão CRUD gerado

```java
public EntityDTO save(EntityDTO dto) { ... }
public EntityDTO update(EntityDTO dto) { ... }
public Optional<EntityDTO> partialUpdate(EntityDTO dto) { ... }
public Page<EntityDTO> findAll(Pageable pageable) { ... }
public Optional<EntityDTO> findOne(Long id) { ... }
public void delete(Long id) { ... }
```

Seguir assinaturas e exceções dos services irmãos.

## Queries customizadas

- Métodos no repository (`findByX`) ou `@Query` JPQL
- Specifications / Criteria API para filtros dinâmicos complexos
- Nunca SQL nativo com concatenação de input do usuário

## Cache

Se o projeto usa EhCache/Hazelcast/Redis via JHipster, seguir anotações já presentes em entidades similares.
