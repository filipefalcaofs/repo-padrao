# Projetos Laravel com repo-padrao

Guia para usar o template `repo-padrao` em aplicações [Laravel 12/13](https://laravel.com/docs/13.x) com [Laravel Boost](https://laravel.com/docs/13.x/ai).

## Visão geral

O repo-padrao combina:

1. **Disciplina universal** — TDD, GSD, pt-BR, commits convencionais (`AGENTS.md`)
2. **Stack Laravel** — rules e skills baseadas no Laravel Boost
3. **MCP laravel-boost** — introspecção da app, docs versionadas, schema de banco

### Guidelines vs Skills

| | Guidelines (rules `.mdc`) | Skills |
|---|---|---|
| Quando carregam | Ao abrir arquivos PHP/Blade/routes/tests | Sob demanda, por domínio |
| Escopo | Convenções base Laravel | Padrões detalhados (queries, segurança, Pest…) |
| Onde | `.cursor/rules/laravel-*.mdc` | `.cursor/skills/*/SKILL.md` |

## Fluxo recomendado

### 1. Bootstrap

```bash
git clone https://github.com/filipefalcaofs/repo-padrao.git meu-laravel
cd meu-laravel
rm -rf .git && git init
composer create-project laravel/laravel .
# ou: copiar app Laravel existente para a raiz
```

### 2. .gitignore Laravel

```bash
cat docs/templates-linguagem/gitignore-php-laravel.txt >> .gitignore
```

### 3. Laravel Boost

```bash
composer require laravel/boost --dev
php artisan boost:install
```

No instalador, selecionar **Cursor**, **guidelines**, **skills** e **MCP**.

Se preferir config manual:

```bash
cp stacks/laravel/.mcp.json.example .mcp.json
cp stacks/laravel/boost.json.example boost.json
```

Habilitar `laravel-boost` em **MCP Settings** no Cursor.

### 4. GSD e segundo cérebro

```
/gsd-new-project
```

Registrar stack no ADR:

```bash
cp docs/brain/3-resources/adrs/0000-template.md \
   docs/brain/3-resources/adrs/0001-stack-laravel.md
```

### 5. Verificação

```bash
php artisan test --compact
php artisan route:list
```

No Cursor, confirmar que `laravel-boost` aparece em MCP Settings e que as rules `laravel-core` e `laravel-boost` estão ativas ao editar arquivos `.php`.

## Skills incluídas

| Skill | Ativar quando |
|---|---|
| `laravel-best-practices` | Controllers, models, migrations, jobs, queries, segurança |
| `laravel-boost` | Debug, schema, rotas, logs, `search-docs` |
| `pest-testing` | Qualquer trabalho em `tests/` |
| `livewire-development` | Componentes Livewire (opcional) |
| `tailwindcss-development` | Classes Tailwind em Blade/Vue (opcional) |

Invocar explicitamente quando relevante: `/laravel-best-practices`, `/pest-testing`.

## Customização

### Guidelines próprias

Criar em `.ai/guidelines/` — incluídas no próximo `boost:install` ou `boost:update`.

### Override de guideline Boost

Mesmo path do Boost. Exemplo: `.ai/guidelines/inertia-vue/2/forms.blade.php`.

### Skills próprias

`.ai/skills/minha-skill/SKILL.md` → `php artisan boost:update`.

## Projetos sem Laravel

Remova o stack Laravel para evitar ruído:

```bash
rm .cursor/rules/laravel-*.mdc
rm -rf .cursor/skills/laravel-best-practices \
       .cursor/skills/laravel-boost \
       .cursor/skills/pest-testing
```

## Referências

- [stacks/laravel/README.md](../../stacks/laravel/README.md)
- [Laravel AI — 13.x](https://laravel.com/docs/13.x/ai)
- [Laravel Boost — 13.x](https://laravel.com/docs/13.x/boost)
- [COMO_USAR.md](../COMO_USAR.md)
