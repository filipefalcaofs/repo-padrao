---
name: pytest-django
description: "Aplicar ao escrever testes Django com pytest-django: fixtures, factories, client, database access e markers. Usar em tests/ ou test_*.py."
license: MIT
metadata:
  author: repo-padrao
---

# pytest-django

## Setup comum

```python
import pytest

@pytest.mark.django_db
def test_cria_usuario(client):
    response = client.post("/api/users/", data={...})
    assert response.status_code == 201
```

## Padrões

- `factory_boy` se o projeto usa factories.
- `@pytest.fixture` para dados reutilizáveis.
- `pytest.mark.django_db(transaction=True)` para testes que cruzam threads.

## TDD

Red → Green → Refactor. Um comportamento por teste.
