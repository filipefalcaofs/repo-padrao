---
name: spring-testing
description: "Aplicar ao escrever ou corrigir testes em projetos Spring Boot / JHipster: JUnit 5, Mockito, MockMvc, RestAssured, @SpringBootTest, @DataJpaTest, segurança (@WithMockUser, JWT), Testcontainers. Usar em src/test/** e tarefas de TDD backend Java."
license: MIT
metadata:
  author: repo-padrao
---

# Spring Testing (JHipster / Spring Boot)

Padrões de teste para apps geradas pelo JHipster (Spring Boot 3.x, JUnit 5).

## Pirâmide

1. **Unit** — services com mocks (rápido, maioria dos casos)
2. **Slice** — `@WebMvcTest`, `@DataJpaTest` quando isolamento ajuda
3. **Integração** — `@SpringBootTest` + MockMvc/RestAssured (poucos, críticos)

## Service (unit)

```java
@ExtendWith(MockitoExtension.class)
class ProductServiceTest {
  @Mock ProductRepository productRepository;
  @Mock ProductMapper productMapper;
  @InjectMocks ProductService productService;

  @Test
  void save_devePersistirDto() { ... }
}
```

## REST (MockMvc)

```java
@AutoConfigureMockMvc
@WithMockUser(username = "admin", roles = {"ADMIN"})
class ProductResourceIT {
  @Autowired MockMvc restProductMockMvc;

  @Test
  void getAllProducts() throws Exception {
    restProductMockMvc.perform(get("/api/products"))
      .andExpect(status().isOk());
  }
}
```

## JWT em testes JHipster

Seguir helper/token factory já presente no projeto (`*TestUtil`, `SecurityTestUtil` ou equivalente gerado).

## JPA

- `@DataJpaTest` + `@AutoConfigureTestDatabase` quando projeto usa
- Testcontainers se configurado no `pom.xml`/`build.gradle`
- `@Transactional` em IT para rollback

## TDD (repo-padrao)

1. RED — teste falha pelo motivo certo
2. GREEN — implementação mínima
3. REFACTOR — manter verde

## Comandos

```bash
./mvnw -Dtest=ProductServiceTest test
./mvnw test
./gradlew test --tests ProductServiceTest
```

## Anti-padrões

- `@SpringBootTest` em todo teste (lento)
- Assert genérico sem verificar corpo JSON
- Dados compartilhados mutáveis entre testes
