# Overlay repo-padrao

Camada de configuração que se instala **por cima do aiox-core** em qualquer projeto.

```
npx aiox-core@latest init meu-projeto   (infraestrutura multi-IDE, agentes, squads)
            +
overlay/base/apply.sh                   (nossas convenções universais)
            +
scripts/choose-stack.sh                 (skills da stack escolhida)
            =
projeto pronto
```

## O que o overlay base aplica

| Item | Destino no projeto |
|---|---|
| Rules universais (idioma, git, TDD, entrega funcional, parametrização, Docker) | `.cursor/rules/` |
| Plugin Superpowers | `.cursor/plugins/superpowers/` |
| Skills Superpowers | `.claude/skills/` e `.codex/skills/` |
| Skills internas Cursor | `.cursor/skills-cursor/` |
| Segundo cérebro (PARA + CODE) | `docs/brain/` |
| Templates de `.gitignore` por linguagem | `docs/templates-linguagem/` |
| Convenções universais | `AGENTS.md` e `CLAUDE.md` (cria ou anexa com marcadores) |
| Base universal de `.gitignore` e `.editorconfig` | raiz do projeto |

## Fontes

O overlay **não duplica conteúdo**: o `apply.sh` copia diretamente das fontes na raiz do meta-repo (`.cursor/rules/`, `.cursor/plugins/superpowers/`, `docs/brain/`, `AGENTS.md`). Editar a fonte uma vez vale para todos os próximos projetos.

As skills por stack continuam em [`stacks/`](../stacks/) e são aplicadas por `scripts/choose-stack.sh`.

## Convivência com o aiox-core

O aiox-core gera `AGENTS.md` e `CLAUDE.md` próprios. O `apply.sh` **anexa** nossas convenções a esses arquivos entre os marcadores `<!-- repo-padrao:inicio -->` e `<!-- repo-padrao:fim -->`, sem destruir o conteúdo do aiox-core. A aplicação é idempotente: rodar duas vezes não duplica nada.

## Uso direto (sem setup.sh)

Para aplicar só o overlay em um projeto já existente:

```bash
bash overlay/base/apply.sh /caminho/do/projeto
bash scripts/choose-stack.sh /caminho/do/projeto
```
