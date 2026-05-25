# Segurança (JHipster)

## Configuração

- `SecurityConfiguration` — não duplicar filter chains
- JWT ou OAuth2 conforme `.yo-rc.json` (`authenticationType`)

## Autorização

- `@PreAuthorize("hasRole('ADMIN')")` em endpoints administrativos
- `@PreAuthorize("hasAuthority('ROLE_USER')")` conforme padrão gerado
- Method security habilitada globalmente — usar anotações

## Endpoints públicos

Registrar em `SecurityConfiguration` (`requestMatchers`) — não desabilitar CSRF globalmente sem análise.

## Dados sensíveis

- Não logar tokens ou senhas
- DTOs sem campos internos (password hash, secrets)
- Rate limiting / gateway quando arquitetura microservices

## Testes de segurança

- `@WithMockUser` ou token JWT de teste conforme `spring-testing` skill
