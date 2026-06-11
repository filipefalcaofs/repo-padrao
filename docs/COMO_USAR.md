# Como usar

## Desenvolvedor — iniciar projeto

Pré-requisito: Node.js >= 18 (para o `npx aiox-core`).

```bash
git clone https://github.com/filipefalcaofs/repo-padrao.git
cd repo-padrao
bash scripts/setup.sh meu-projeto
cd ../meu-projeto
```

O `setup.sh` executa três passos:

1. **`npx aiox-core@latest init`** — cria o projeto com a infraestrutura de agentes do [aiox-core](https://github.com/SynkraAI/aiox-core) (Cursor, Claude Code, Codex, Gemini CLI e outras IDEs ficam configuradas de uma vez — não é preciso escolher IDE).
2. **Overlay base** — aplica as convenções do repo-padrao: rules universais, Superpowers, `docs/brain/`, `AGENTS.md` e `CLAUDE.md` (anexa sem destruir o conteúdo do aiox-core).
3. **Stack** — menu interativo para escolher a linguagem; aplica rules e skills específicas.

Ao final, registre a escolha da stack no ADR `docs/brain/3-resources/adrs/0001-escolha-de-stack.md` do projeto.

### Modo não interativo

```bash
bash scripts/setup.sh meu-projeto --stack laravel --variant vue
bash scripts/setup.sh meu-api --stack go-api
bash scripts/setup.sh meu-projeto --stack none          # agnóstico, sem stack
```

Stacks e variantes:

| Stack | Variantes | Guia |
|---|---|---|
| `laravel` | `vue`, `react`, `svelte` | [stacks/LARAVEL.md](stacks/LARAVEL.md) |
| `jhipster` | `angular`, `react`, `vue` | [stacks/JHIPSTER.md](stacks/JHIPSTER.md) |
| `abp` | `angular`, `react`, `blazor`, `mvc` | [stacks/ABP.md](stacks/ABP.md) |
| `django` | — | [stacks/DJANGO.md](stacks/DJANGO.md) |
| `nestjs` | — | [stacks/NESTJS.md](stacks/NESTJS.md) |
| `go-api` | — | [stacks/GO.md](stacks/GO.md) |
| `none` | — | agnóstico |

### Projeto existente

```bash
bash scripts/setup.sh --existing /caminho/do/projeto
```

Usa `npx aiox-core@latest install` (preserva o que já existe) e aplica overlay + stack por cima. A aplicação é idempotente.

### Argumentos extras para o aiox-core

Tudo após `--` é repassado ao aiox-core:

```bash
bash scripts/setup.sh meu-projeto -- --skip-install
bash scripts/setup.sh --existing /caminho -- --quiet --force
```

### Aplicar só o overlay (sem aiox-core)

```bash
bash overlay/base/apply.sh /caminho/do/projeto
bash scripts/choose-stack.sh /caminho/do/projeto
```

## O que o projeto recebe

| Camada | Conteúdo |
|---|---|
| aiox-core | Agentes (@dev, @qa, @architect…), workflows, configuração multi-IDE |
| Overlay base | Rules universais (idioma, git, TDD, entrega funcional, parametrização, Docker), Superpowers, `docs/brain/`, `AGENTS.md`, `CLAUDE.md`, `.editorconfig`, `.gitignore` |
| Stack | Rules e skills da linguagem + guia em `docs/stacks/` + `.gitignore` da linguagem |

Detalhes do overlay: [../overlay/README.md](../overlay/README.md).

## Atualizar um projeto

O aiox-core atualiza com `npx aiox-core@latest install` dentro do projeto (detecta a instalação e preserva customizações). Para reaplicar as convenções do repo-padrao:

```bash
cd repo-padrao && git pull
bash overlay/base/apply.sh /caminho/do/projeto
```

## Mantenedor

Ver [**MANUTENCAO.md**](MANUTENCAO.md).
