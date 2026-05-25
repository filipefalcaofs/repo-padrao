# repo-padrao-django

Template pronto para **Django + DRF** (stack secundária).

## Clone

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-django.git meu-app
cd meu-app
rm -rf .git && git init
python -m venv .venv && source .venv/bin/activate
pip install django djangorestframework pytest-django
django-admin startproject config .
```

Ver [`docs/stacks/DJANGO.md`](docs/stacks/DJANGO.md).

## Já incluído

- Rules: `django-core`, `django-drf`
- Skills: `django-development`, `django-drf`, `pytest-django`
- `.django-stack.json`
