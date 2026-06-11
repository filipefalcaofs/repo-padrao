# Manutenção

Este documento é para quem mantém o [`repo-padrao`](https://github.com/filipefalcaofs/repo-padrao) — **não** para quem inicia um projeto de aplicação (ver [COMO_USAR.md](COMO_USAR.md)).

## Modelo

O repo-padrao é um **overlay sobre o aiox-core**: as fontes (rules, skills, stacks, brain) vivem aqui e são aplicadas nos projetos pelos scripts de setup. Não há mais geração nem publicação de repositórios standalone.

## Fluxo padrão

1. Editar a fonte:
   - Rules universais: `.cursor/rules/*.mdc`
   - Convenções: `AGENTS.md` e `docs/templates/CLAUDE-universal.md`
   - Stack: `stacks/<nome>/` (rules, skills, `apply-stack.sh`)
   - Segundo cérebro: `docs/brain/`
2. Testar contra um diretório temporário:

```bash
bash overlay/base/apply.sh /tmp/teste-overlay
bash scripts/choose-stack.sh /tmp/teste-overlay --stack laravel --variant vue
```

3. Commit e push no `main`. Pronto — o próximo `setup.sh` de qualquer desenvolvedor já usa a versão nova.

## Scripts

| Script | Função |
|---|---|
| `scripts/setup.sh` | Ponto de entrada do desenvolvedor (aiox-core + overlay + stack) |
| `overlay/base/apply.sh` | Aplica convenções universais em um destino |
| `scripts/choose-stack.sh` | Menu de stacks; chama `stacks/*/apply-stack.sh` |
| `scripts/archive-standalone-repos.sh` | Arquivamento dos 42 repos antigos (já executado) |
| `scripts/build-standalone-repos.sh` | Legado — gerava os 42 standalone (mantido só para transição) |
| `scripts/push-standalone-repos.sh` | Legado — publicava os standalone |

## Dependência do aiox-core

O `setup.sh` usa sempre `npx aiox-core@latest`. Após release relevante do aiox-core, validar o fluxo:

```bash
rm -rf /tmp/teste-aiox && mkdir -p /tmp/teste-aiox
bash scripts/setup.sh --existing /tmp/teste-aiox --stack none -- --quiet --force
```

Conferir que o overlay anexou `AGENTS.md`/`CLAUDE.md` com os marcadores `<!-- repo-padrao:inicio -->` e que `.cursor/rules/` contém as rules universais.

## Stacks fonte

| Pasta | Linguagem | Variantes |
|---|---|---|
| `stacks/laravel/` | PHP | `--adapter vue\|react\|svelte` |
| `stacks/jhipster/` | Java | `--frontend angular\|react\|vue` |
| `stacks/abp/` | .NET (C#) | `--ui angular\|react\|blazor\|mvc` |
| `stacks/django/` | Python | — |
| `stacks/nestjs/` | TypeScript | — |
| `stacks/go-api/` | Go | — |

## Rules upstream

ABP — sincronizar rules oficiais do [cursor-abp-plugin](https://github.com/abpframework/cursor-abp-plugin):

```bash
bash stacks/abp/scripts/sync-upstream-rules.sh
```

Laravel — conteúdo baseado em Laravel Boost; ver `stacks/laravel/README.md`.

## Checklist antes de publicar mudança

- [ ] `bash overlay/base/apply.sh /tmp/teste-overlay` sem erros
- [ ] `bash scripts/choose-stack.sh /tmp/teste-overlay --stack <afetada> ...` sem erros
- [ ] Spot-check do resultado (rules, skills, AGENTS.md com marcadores)
- [ ] Commit e push no `main`
