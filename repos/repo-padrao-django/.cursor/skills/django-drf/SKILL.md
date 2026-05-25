---
name: django-drf
description: "Aplicar em APIs Django REST Framework: serializers, viewsets, routers, permissions, throttling, filtros e paginação. Usar ao criar ou alterar endpoints REST."
license: MIT
metadata:
  author: repo-padrao
---

# Django REST Framework

## Estrutura típica

```
app/
  serializers.py
  views.py      # ViewSets ou APIView
  urls.py       # router.register(...)
  permissions.py
  filters.py
```

## Padrões

- Nested serializers só quando necessário (performance).
- `@action(detail=True/False)` para endpoints customizados.
- `perform_create` / `perform_update` para side effects.
- OpenAPI: `drf-spectacular` se o projeto usa.

## Testes

- `APIClient` ou `pytest` + fixtures — status code e corpo JSON.
