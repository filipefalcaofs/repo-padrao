# Liquibase (JHipster)

## Localização

- Master: `src/main/resources/config/liquibase/master.xml`
- Changelog por entidade: `config/liquibase/changelog/YYYYMMDDHHMMSS_added_entity_*.xml`
- Dados fake (dev): `config/liquibase/fake-data/`

## Regras

- Toda alteração de schema via novo changeset XML ou regeneração JHipster
- Não modificar changeset já executado em ambientes compartilhados
- Nomes de tabela/coluna alinhados ao gerador (snake_case no banco)

## Tipos comuns

| JDL / Java | Liquibase |
|---|---|
| String | varchar |
| TextBlob | clob / text |
| Instant / ZonedDateTime | timestamp |
| BigDecimal | decimal |
| UUID | uuid / char(36) |

## Rollback

Incluir `<rollback>` quando changeset for manual e arriscado; gerados pelo JHipster podem omitir — seguir padrão do projeto.
