# CLAUDE.md

Stack: **JHipster + react** (Java).

Skills: `jhipster-development`, `jhipster-jdl`, `spring-testing`, `jhipster-react-development`.

## Diretrizes universais

- Output em **português brasileiro**; código (nomes, tipos, APIs) em inglês
- **Sem emojis** em respostas, código, commits ou documentação
- **TDD** obrigatório — teste falhando antes de código de produção
- Invocar skills **Superpowers** em `.claude/skills/` (brainstorming, test-driven-development, systematic-debugging, verification-before-completion)
- **Conventional Commits** em pt-BR (`feat:`, `fix:`, …)
- Decisões arquiteturais → ADR em `docs/brain/3-resources/adrs/`
- **Sem features de fachada** — toda feature executa a lógica real de ponta a ponta; fakes/mocks só na suíte de testes; dependência externa indisponível = feature bloqueada e registrada, nunca simulada
- **Parametrização máxima** — nenhum valor de negócio hardcoded; parâmetros e feature toggles administráveis por interface, com histórico auditado, efeito sem deploy e credenciais criptografadas
