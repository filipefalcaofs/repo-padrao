---
name: django-development
description: "Aplicar ao escrever ou revisar código Django: models, migrations, views, forms, admin, URLs, settings e services. Usar em projetos Python/Django 4.2+ ou 5+."
license: MIT
metadata:
  author: repo-padrao
---

# Django Development

Boas práticas custom do repo-padrao. Consistência com o projeto primeiro.

## Comandos

```bash
python manage.py makemigrations
python manage.py migrate
python manage.py test
pytest
```

## Checklist feature

1. Model + migration
2. Admin (se aplicável)
3. View/form ou serializer
4. URL
5. Teste falhando → implementação → verde

## Referências

- [Django documentation](https://docs.djangoproject.com/)
