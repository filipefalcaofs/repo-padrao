---
name: nestjs-testing
description: "Aplicar em testes NestJS: Jest, Test.createTestingModule, mocks, supertest e2e. Usar em *.spec.ts e test/."
license: MIT
metadata:
  author: repo-padrao
---

# NestJS Testing

## Unit

```typescript
const module = await Test.createTestingModule({
  providers: [UsersService, { provide: getRepositoryToken(User), useValue: mockRepo }],
}).compile();
```

## E2E

```typescript
const app = module.createNestApplication();
await app.init();
return request(app.getHttpServer()).get('/users').expect(200);
```

## TDD

Teste falha → implementação mínima → refactor.
