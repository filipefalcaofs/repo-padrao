# AGENTS.md

Instruções universais para qualquer agente de IA trabalhando neste projeto: **Antigravity (Google), OpenAI Codex CLI, Jules, Cursor, Claude Code, GitHub Copilot, Aider, Continue** ou qualquer outro.

Este arquivo é **auto-suficiente**. Não dependa de `.cursor/rules/`, `.claude/skills/`, `.codex/skills/` ou `.github/copilot-instructions.md` — agentes que não consigam ler essas fontes devem encontrar aqui tudo que precisam para trabalhar de acordo com os padrões deste projeto.

---

## 1. Idioma

Todo output gerado deve ser em **português brasileiro (pt-BR)** com gramática correta — acentuação, cedilha, til, crase e pontuação adequadas. Inclui:

- Respostas e explicações ao usuário
- Comentários no código
- Mensagens de commit
- Documentação gerada
- Mensagens de erro e logs voltados a humanos
- Labels de UI e textos de interface
- Nomes de testes (`describe`/`it`/`test`)
- Conteúdo de arquivos markdown

**Exceções (manter em inglês):**
- Nomes de variáveis, funções, classes, métodos e tipos no código
- Palavras-chave de linguagens de programação
- Nomes de bibliotecas, frameworks e produtos
- Termos técnicos consagrados sem tradução adequada (`middleware`, `deploy`, `commit`, `endpoint`, `payload`, etc.)

## 2. Comunicação

- **Sem emojis** em respostas, código, commits ou documentação. Em hipótese alguma.
- **Direto ao ponto.** Sem preâmbulos do tipo "Ótima pergunta!" ou recapitulações desnecessárias.
- **Não criar arquivos** desnecessários. Sempre preferir editar arquivo existente a criar um novo.
- **Não adicionar comentários narrativos** que apenas descrevem o que o código faz (`// incrementa contador`, `// retorna o resultado`). Comentários devem explicar **por que** ou **trade-offs não óbvios**, nunca o que o código já mostra.
- **Explicar o "por quê"** quando relevante, não apenas o "o quê".
- **Apresentar trade-offs** claramente quando a decisão tiver alternativas.
- **Não pedir confirmação** para cada micro-decisão — agir e explicar.
- Se algo não está claro na tarefa, **perguntar antes de assumir**.

## 3. Convenções de Código

### Conventional Commits em pt-BR

Formato: `<tipo>: <descrição em português, minúscula, sem ponto final>`

Tipos permitidos:

| Tipo | Uso |
|---|---|
| `feat:` | Nova funcionalidade |
| `fix:` | Correção de bug |
| `refactor:` | Refatoração sem mudar comportamento |
| `chore:` | Manutenção (deps, configs, infra de build) |
| `docs:` | Apenas documentação |
| `test:` | Apenas testes |
| `style:` | Formatação, sem mudar lógica |
| `perf:` | Melhoria de performance |

Exemplos válidos:

```
feat: adiciona modal de cadastro de usuários
fix: corrige validação de datas no formulário
refactor: extrai lógica de autenticação para service
chore: atualiza dependências do projeto
docs: documenta fluxo de pagamento no brain
test: adiciona testes para serviço de notificações
```

Regras:
- Mensagem em pt-BR, minúsculas, sem ponto final
- Descrição concisa (≤72 caracteres na primeira linha)
- Corpo opcional para detalhes adicionais

## 4. TDD Obrigatório

> **NENHUM CÓDIGO DE PRODUÇÃO SEM UM TESTE FALHANDO PRIMEIRO.**

Ciclo Red-Green-Refactor:

1. **RED** — escrever um teste que falha
2. **Verificar RED** — rodar e confirmar que falha **pelo motivo certo**
3. **GREEN** — escrever o **mínimo** de código para passar
4. **Verificar GREEN** — rodar e confirmar que passa
5. **REFACTOR** — limpar mantendo testes verdes
6. **Repetir** — próximo teste

Escreveu código antes do teste? **Delete e comece de novo.** Sem exceções.

**Exceções (apenas com permissão explícita do usuário):**
- Protótipos descartáveis
- Código gerado automaticamente
- Arquivos de configuração pura
- Alterações puramente visuais/CSS sem lógica

## 5. Debugging Sistemático

> **NENHUMA CORREÇÃO SEM INVESTIGAÇÃO DE CAUSA RAIZ PRIMEIRO.**

4 fases obrigatórias para qualquer bug:

1. **Investigar causa raiz** — ler stack traces completos, reproduzir o bug, checar mudanças recentes (`git log`, `git blame`).
2. **Análise de padrões** — encontrar exemplos funcionais no codebase que fazem algo semelhante, comparar diferenças com a parte quebrada.
3. **Hipótese e teste** — formular **uma hipótese por vez**, testar minimamente.
4. **Implementação** — escrever teste falhando que reproduz o bug, fazer correção mínima, verificar.

Tentativa e erro **não é debugging**. Se você está mudando coisas aleatoriamente, pare e volte para a fase 1.

## 6. Verificação antes de Concluir

> **NENHUMA AFIRMAÇÃO DE SUCESSO SEM EVIDÊNCIA FRESCA.**

Antes de afirmar que algo funciona, está pronto, foi corrigido ou passou:

1. **Identificar** qual comando prova a afirmação (teste, build, lint, execução manual).
2. **Rodar** o comando — fresco, completo, sem cache enganoso.
3. **Ler** o output inteiro e confirmar.
4. **Só então** afirmar conclusão.

Frases proibidas: "deve funcionar", "provavelmente passou", "acho que está pronto".

## 7. Brainstorming antes de Implementar

Antes de criar features, componentes ou modificar comportamento relevante:

1. **Explorar contexto** do projeto (ler arquivos relacionados, padrões existentes).
2. **Fazer perguntas clarificadoras** — uma por vez quando possível.
3. **Propor 2-3 abordagens** com trade-offs claros.
4. **Apresentar design** e obter aprovação antes de codar.
5. Para tarefas multi-step, **escrever um plano** com passos pequenos (2-5 min cada).

Não existe tarefa **simples demais** para pular essa etapa. O design pode ser curto, mas precisa existir antes da primeira linha de código.

## 8. Workflow GSD (Get Stuff Done)

Este projeto usa o framework **GSD** para gestão de execução. Se a pasta `.planning/` existir, ela é a **fonte de verdade** sobre o que está sendo feito:

| Arquivo | Conteúdo |
|---|---|
| `.planning/PROJECT.md` | Visão e requisitos do projeto |
| `.planning/ROADMAP.md` | Fases planejadas e status |
| `.planning/STATE.md` | Contexto atual, onde parou, decisões recentes |
| `.planning/REQUIREMENTS.md` | Requisitos com IDs rastreáveis |

**Sempre consultar esses arquivos antes de agir** se eles existirem.

Comandos GSD comuns (executados via skill quando o agente os suporta):

```
/gsd-new-project      — inicializar .planning/ em projeto novo
/gsd-map-codebase     — mapear codebase existente sem .planning/
/gsd-plan-phase N     — criar plano detalhado da fase N
/gsd-execute-phase N  — executar a fase N
/gsd-progress         — checar status atual
/gsd-resume-work      — retomar trabalho após pausa
/gsd-fast "tarefa"    — tarefa trivial (≤3 arquivos)
/gsd-quick            — tarefa pequena com garantias mínimas
/gsd-debug "bug"      — debugging com persistência entre sessões
/gsd-ship N           — criar PR da fase N completa
```

Agente que não tenha suporte nativo a essas skills deve **simular** o fluxo: ler `.planning/`, propor um plano, executar, atualizar `STATE.md` ao final.

## 9. Docker e Deploy

**Conta Docker Hub:** `filipefalcaofs97`
**Máquina dev:** Apple Silicon (ARM64)
**Servidores prod:** Linux AMD64

### Build e push (sempre AMD64)

```bash
docker buildx build --platform linux/amd64 -t filipefalcaofs97/<nome-imagem>:latest --push .
```

`docker build` ou `docker compose build` puro **gera imagem ARM** que **não funciona em produção**. Sempre `buildx --platform linux/amd64`.

### Estrutura esperada por projeto

| Arquivo | Função |
|---|---|
| `Dockerfile` | Build da imagem |
| `docker-compose.yml` | Desenvolvimento local (com `build:`) |
| `docker-compose.portainer-full.yml` | Produção/Portainer (com `image:` do Docker Hub) |
| `docker/` | Configs runtime (nginx, php.ini, supervisord, entrypoint) |
| `.dockerignore` | Excluir arquivos do build |

### Fluxo completo

```
buildx --platform linux/amd64 --push  →  commit do compose no main  →  Portainer puxa do main
```

Variáveis sensíveis **nunca** vão hardcoded na imagem.

## 10. Segundo Cérebro (PARA + CODE)

Conhecimento do projeto vive em **`docs/brain/`**, organizado pelo método **PARA** de Tiago Forte:

| Pasta | Conteúdo |
|---|---|
| `docs/brain/inbox/` | Captura rápida (esvaziar semanalmente) |
| `docs/brain/1-projects/` | Iniciativas com prazo e objetivo |
| `docs/brain/2-areas/` | Responsabilidades contínuas |
| `docs/brain/3-resources/` | Referências reutilizáveis |
| `docs/brain/3-resources/adrs/` | Architecture Decision Records |
| `docs/brain/3-resources/pesquisas/` | Notas de pesquisa técnica |
| `docs/brain/3-resources/snippets/` | Trechos úteis de código/comandos |
| `docs/brain/4-archive/` | Concluído ou inativo |
| `docs/brain/daily/` | Notas diárias (opcional) |

### Obrigatório para todo agente

- **Antes de qualquer decisão arquitetural relevante**, ler os ADRs existentes em `docs/brain/3-resources/adrs/`. Não repita decisões já tomadas.
- **Após tomar uma decisão arquitetural**, registrar um novo ADR usando o template em `docs/brain/3-resources/adrs/0000-template.md`.
- **Pesquisas técnicas** que ultrapassam consulta rápida vão em `docs/brain/3-resources/pesquisas/`.
- **Aprendizados de fase GSD** ao concluir uma fase devem ser destilados para `docs/brain/`.

### CODE (capture, organize, distill, express)

```
inbox/  →  1-4 (PARA)  →  destilação  →  PR/release/docs
```

`.planning/` (GSD) é gestão de **execução**. `docs/brain/` (BASB) é gestão de **conhecimento**. Coexistem.

## 11. Git

**Nunca versionar:**
- `.env` ou qualquer arquivo de variável de ambiente com valores reais
- `node_modules/`, `vendor/`, `__pycache__/`
- `test-results/`, `playwright-report/`, `coverage/`
- `.planning/` (gestão de execução é local de cada checkout)
- Arquivos de build (`dist/`, `.next/`, `.nuxt/`, `build/`)
- Credenciais, chaves de API, certificados (`*.pem`, `*.key`, `credentials.json`)

**Nunca:**
- Alterar `git config` (nem global, nem local) sem ordem explícita do usuário.
- Rodar `git push --force` em `main`/`master`.
- Usar `git commit --amend` em commits já enviados ao remoto.
- Pular hooks (`--no-verify`, `--no-gpg-sign`) sem ordem explícita.

**Antes de release:**
- Build passa sem erros.
- Testes passam.
- Diff completo revisado.

## 12. Estrutura do Projeto

```
.cursor/
  rules/                  Regras nativas Cursor (.mdc) — Cursor lê automaticamente
  skills/                 Skills GSD/cursor-públicas
  skills-cursor/          Skills internas Cursor
  plugins/                Cache de skills compartilhadas (superpowers, figma)
.claude/
  skills/                 Skills Claude Code — Claude lê automaticamente
.codex/
  skills/                 Skills OpenAI Codex CLI — Codex lê automaticamente
.github/
  copilot-instructions.md Instruções GitHub Copilot
docs/
  COMO_USAR.md            Como usar este template
  brain/                  Segundo cérebro do projeto (PARA + CODE)
AGENTS.md                 Este arquivo (padrão universal)
CLAUDE.md                 Atalho para Claude Code (referencia AGENTS.md + skills)
README.md                 Documentação do projeto
.editorconfig             Padrão de formatação
.gitignore                Arquivos ignorados pelo git
```

Agentes **sem suporte nativo** a skills/`.mdc`/copilot-instructions devem ler **apenas** este `AGENTS.md` — ele contém tudo que importa.

## 13. Resumo executivo

Se você só vai ler 5 frases:

1. Tudo em pt-BR, sem emojis, direto ao ponto.
2. TDD: teste falhando antes de qualquer código de produção.
3. Bug: investigar causa raiz antes de tentar correção.
4. Conventional Commits em pt-BR (`feat:`, `fix:`, etc.).
5. Decisões arquiteturais viram ADR em `docs/brain/3-resources/adrs/`.
