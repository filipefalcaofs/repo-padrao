# Testes backend (JHipster)

## Tipos no projeto gerado

| Tipo | Anotação / classe | Uso |
|---|---|---|
| Unit service | `@ExtendWith(MockitoExtension.class)` | Mock repository + mapper |
| Web REST | `@AutoConfigureMockMvc` + `@WithMockUser` | MockMvc |
| Integração | `@SpringBootTest` | Contexto completo (usar com parcimônia) |

## Convenções

- Classe `*ResourceIT` ou `*ResourceTest` conforme projeto
- `@Transactional` em ITs que alteram banco (rollback automático)
- Fixtures em `src/test/resources/` ou builders

## Comandos

```bash
./mvnw test
./mvnw verify -DskipTests=false
./gradlew test integrationTest
```

## Skill complementar

Ativar `spring-testing` para padrões Spring Boot 3.x / JUnit 5 detalhados.
