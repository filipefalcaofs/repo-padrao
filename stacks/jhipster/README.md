# Stack JHipster

**Linguagem:** Java (Spring Boot)

Stack **custom** de **skills e rules** para projetos [JHipster 8+](https://www.jhipster.tech/) (Spring Boot + frontend Angular/React/Vue), integrado ao `repo-padrao`.

> Não existe pacote oficial equivalente ao [Laravel Boost](https://laravel.com/docs/13.x/boost). Este stack documenta convenções JHipster para agentes de IA.

## Conteúdo

| Item | Descrição |
|---|---|
| `.cursor/rules/jhipster-core.mdc` | Spring Boot, entidades, REST, Liquibase, testes |
| `.cursor/rules/jhipster-jdl.mdc` | JDL — modelagem e importação |
| `.cursor/rules/jhipster-frontend.mdc` | Angular, React ou Vue |
| `.cursor/skills/jhipster-development/` | Backend JHipster (6 regras detalhadas) |
| `.cursor/skills/jhipster-jdl/` | Workflow JDL |
| `.cursor/skills/spring-testing/` | Testes Spring Boot / JUnit 5 |
| `.cursor/skills/jhipster-angular-development/` | Frontend Angular |
| `.cursor/skills/jhipster-react-development/` | Frontend React |
| `.cursor/skills/jhipster-vue-development/` | Frontend Vue |

## Aplicar em um projeto

### Opção A — Clonou repo-padrao (recomendado)

```bash
cd meu-projeto
./stacks/jhipster/scripts/choose-frontend-framework.sh
bash stacks/jhipster/scripts/apply-stack.sh .
```

Escolha Angular, React ou Vue. Depois gere o app com JHipster.

### Opção B — Projeto JHipster existente

```bash
git clone https://github.com/filipefalcaofs/repo-padrao.git /tmp/repo-padrao
cd /caminho/do/seu/jhipster
bash /tmp/repo-padrao/stacks/jhipster/scripts/apply-stack.sh . --frontend angular
```

Substitua `--frontend angular` por `react` ou `vue`.

### Opção C — Novo projeto a partir do template

```bash
git clone https://github.com/filipefalcaofs/repo-padrao.git meu-app
cd meu-app
bash stacks/jhipster/scripts/apply-stack.sh . --frontend angular
npm install -g generator-jhipster
jhipster
```

## Frameworks frontend disponíveis

| Script | Skill |
|---|---|
| `--frontend angular` | `jhipster-angular-development` |
| `--frontend react` | `jhipster-react-development` |
| `--frontend vue` | `jhipster-vue-development` |

Todas ficam em `stacks/jhipster/.cursor/skills/`; o projeto recebe **só a escolhida**.

## Manutenção

Conteúdo mantido manualmente no repo-padrao, alinhado à [documentação JHipster](https://www.jhipster.tech/).

Para atualizar após upgrade major do JHipster, revisar rules/skills e regenerar app de referência.

## Referências

- [Guia completo](../../docs/stacks/JHIPSTER.md)
- [Creating an application](https://www.jhipster.tech/creating-an-app/)
- [JDL](https://www.jhipster.tech/jdl/intro/)
