---
name: nestjs-development
description: "Aplicar em projetos NestJS: modules, controllers, services, DTOs, guards, interceptors, TypeORM/Prisma e API REST. Usar ao criar ou refatorar backend Node/TypeScript."
license: MIT
metadata:
  author: repo-padrao
---

# NestJS Development

## CLI

```bash
nest g module users
nest g controller users
nest g service users
nest g class users/dto/create-user.dto --no-spec
```

## Módulo típico

```typescript
@Module({
  imports: [TypeOrmModule.forFeature([User])],
  controllers: [UsersController],
  providers: [UsersService],
  exports: [UsersService],
})
export class UsersModule {}
```

## Checklist endpoint

1. DTO com validação
2. Service method
3. Controller route
4. Teste unit + e2e se crítico

## Referências

- [NestJS docs](https://docs.nestjs.com/)
