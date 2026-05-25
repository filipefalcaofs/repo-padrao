# Projetos JHipster com repo-padrao

> **Clone direto:** [`repos/repo-padrao-jhipster-angular`](../../repos/repo-padrao-jhipster-angular) · [`-react`](../../repos/repo-padrao-jhipster-react) · [`-vue`](../../repos/repo-padrao-jhipster-vue).

Guia para aplicações [JHipster 8+](https://www.jhipster.tech/) (Java/Spring Boot).

## Visão geral

O repo-padrao combina:

1. **Disciplina universal** — TDD, Superpowers, pt-BR, commits convencionais (`AGENTS.md`)
2. **Stack JHipster (custom)** — rules e skills alinhadas à documentação JHipster
3. **Sem MCP oficial** — diferente do Laravel Boost; consultar docs JHipster e código gerado

> JHipster **não possui** pacote oficial de skills/MCP para Cursor. O stack em `stacks/jhipster/` é mantido pelo repo-padrao.

### Rules vs Skills

| | Rules (`.mdc`) | Skills |
|---|---|---|
| Quando carregam | Ao abrir `.java`, `.jdl`, `webapp/` | Sob demanda, por domínio |
| Escopo | Convenções base JHipster | JDL, REST, testes, frontend |
| Onde | `.cursor/rules/jhipster-*.mdc` | `.cursor/skills/*/SKILL.md` |

## Fluxo recomendado

### 1. Bootstrap

```bash
git clone https://github.com/filipefalcaofs/repo-padrao.git meu-jhipster
cd meu-jhipster
rm -rf .git && git init
bash stacks/jhipster/scripts/apply-stack.sh . --frontend angular
```

### 2. Escolher frontend (obrigatório)

O template traz **Angular, React e Vue no catálogo**, mas instala **apenas um** por projeto:

```bash
./stacks/jhipster/scripts/choose-frontend-framework.sh
```

| Opção | Framework | Skill instalada |
|---|---|---|
| 1 (padrão) | Angular | `jhipster-angular-development` |
| 2 | React | `jhipster-react-development` |
| 3 | Vue | `jhipster-vue-development` |

Não interativo:

```bash
./stacks/jhipster/scripts/choose-frontend-framework.sh --frontend angular --yes
```

Salva `.jhipster-stack.json` na raiz.

### 3. Gerar aplicação JHipster

```bash
npm install -g generator-jhipster
jhipster
# ou com JDL:
jhipster jdl app.jdl
```

Exemplo mínimo de JDL com frontend Angular:

```jdl
application {
  config {
    baseName myapp
    packageName com.example.myapp
    authenticationType jwt
    databaseType sql
    devDatabaseType h2Disk
    prodDatabaseType postgresql
    clientFramework angular
  }
  entities *
}
```

Ajuste `clientFramework` para `react` ou `vue` conforme `.jhipster-stack.json`.

### 4. .gitignore

O script `apply-stack.sh` anexa automaticamente `docs/templates-linguagem/gitignore-java-jhipster.txt`. Manual:

```bash
cat docs/templates-linguagem/gitignore-java-jhipster.txt >> .gitignore
```

### 5. Segundo cérebro

Registrar stack no ADR:

```bash
cp docs/brain/3-resources/adrs/0000-template.md \
   docs/brain/3-resources/adrs/0001-stack-jhipster.md
```

### 6. Verificação

```bash
./mvnw test
# ou
./gradlew test
npm test
```

No Cursor, confirmar rules `jhipster-core`, `jhipster-jdl`, `jhipster-frontend` ao editar `.java` ou `src/main/webapp/`.

## Skills incluídas

### Backend (sempre)

| Skill | Ativar quando |
|---|---|
| `jhipster-development` | Entidades, services, REST, Liquibase, segurança |
| `jhipster-jdl` | Arquivos `.jdl`, modelagem de domínio |
| `spring-testing` | `src/test/**`, TDD backend |

### Frontend (uma por projeto)

Após `choose-frontend-framework.sh`:

| Framework | Skill |
|---|---|
| Angular | `jhipster-angular-development` |
| React | `jhipster-react-development` |
| Vue | `jhipster-vue-development` |

Invocar explicitamente: `/jhipster-development`, `/jhipster-jdl`, `/spring-testing`.

## Arquiteturas JHipster

| Tipo | Quando usar |
|---|---|
| Monolith | Padrão; app único com frontend + backend |
| Microservices | Gateway + serviços separados + service discovery |
| Reactive | WebFlux (casos específicos) |

Skills cobrem padrões comuns; microservices exigem atenção extra a gateway, JDL `microservice` e deploy.

## Customização

Adicionar guidelines em `.cursor/rules/` ou estender skills em `.cursor/skills/` do projeto. Prioridade: consistência com código **já gerado** pelo JHipster.

## Projetos sem JHipster

Remova o stack para evitar ruído:

```bash
rm .cursor/rules/jhipster-*.mdc
rm -rf .cursor/skills/jhipster-development \
       .cursor/skills/jhipster-jdl \
       .cursor/skills/spring-testing \
       .cursor/skills/jhipster-angular-development \
       .cursor/skills/jhipster-react-development \
       .cursor/skills/jhipster-vue-development
rm -f .jhipster-stack.json
```

## Referências

- [stacks/jhipster/README.md](../../stacks/jhipster/README.md)
- [JHipster — documentação](https://www.jhipster.tech/)
- [JDL reference](https://www.jhipster.tech/jdl/intro/)
- [COMO_USAR.md](../COMO_USAR.md)
