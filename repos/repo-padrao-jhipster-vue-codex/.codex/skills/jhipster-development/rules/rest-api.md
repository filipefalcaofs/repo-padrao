# REST API (JHipster)

## Estrutura

- Controller: `web/rest/EntityNameResource.java`
- Base path: `/api/entity-names` (plural kebab-case)
- Service: `service/EntityNameService.java`
- DTO: `service/dto/EntityNameDTO.java`
- Mapper: `service/mapper/EntityNameMapper.java`

## Padrões gerados

- `GET /api/entities` — lista paginada (`Pageable`)
- `GET /api/entities/{id}` — detalhe
- `POST /api/entities` — cria (201 + header Location)
- `PUT /api/entities/{id}` — update completo
- `PATCH /api/entities/{id}` — partial update (se habilitado)
- `DELETE /api/entities/{id}` — remove (204)

## Implementação

- `@Valid @RequestBody EntityNameDTO` em POST/PUT
- Delegar ao service; controller sem regra de negócio
- Usar `ResponseUtil.wrapOrNotFound()` para Optional
- Headers paginação: `PaginationUtil.generatePaginationHttpHeaders`

## Erros

- Usar `BadRequestAlertException` e traduções i18n existentes
- Não retornar stack trace ao cliente
