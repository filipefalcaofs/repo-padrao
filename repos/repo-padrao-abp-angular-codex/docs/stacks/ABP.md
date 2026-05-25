# Projetos ABP com repo-padrao

> **Linguagem:** .NET (C#)  
> **Clone direto:** [`repos/repo-padrao-abp-angular`](../../repos/repo-padrao-abp-angular) · [`-react`](../../repos/repo-padrao-abp-react) · [`-blazor`](../../repos/repo-padrao-abp-blazor) · [`-mvc`](../../repos/repo-padrao-abp-mvc).

Guia para aplicações [ABP Framework](https://abp.io/).

## Visão geral

O repo-padrao combina:

1. **Disciplina universal** — TDD, Superpowers, pt-BR, commits convencionais (`AGENTS.md`)
2. **Stack ABP híbrido** — 16 rules oficiais + MCP ABP Studio + escolha de UI
3. **Sem equivalente Laravel Boost** — rules oficiais em `.mdc`, não skills `SKILL.md` (exceto React modern)

### Oficial vs custom

| Peça | Origem |
|---|---|
| Rules backend (`abp-core`, `ddd-patterns`, `ef-core`…) | [cursor-abp-plugin](https://github.com/abpframework/cursor-abp-plugin) |
| Rules UI Angular/Blazor/MVC | Oficial |
| Rule + skill React modern | Custom repo-padrao |
| MCP `abp-studio` | Oficial (ABP Studio aberto) |
| Scripts `apply-stack`, `choose-ui-framework` | Custom repo-padrao |

## Fluxo recomendado

### 1. Bootstrap

```bash
git clone https://github.com/filipefalcaofs/repo-padrao.git meu-abp
cd meu-abp
rm -rf .git && git init
bash stacks/abp/scripts/apply-stack.sh . --ui angular
```

### 2. Escolher UI (obrigatório)

Catálogo completo em `stacks/abp/.cursor/rules/`; o projeto recebe **só uma** rule `ui-*`:

```bash
./stacks/abp/scripts/choose-ui-framework.sh
```

| Opção | UI | Uso típico |
|---|---|---|
| 1 (padrão) | Angular | Enterprise SPA clássico (`-u ng`) |
| 2 | React | Modern template (`--modern --ui-framework react`) |
| 3 | Blazor | Stack C# end-to-end |
| 4 | MVC | Razor Pages server-rendered |

Não interativo:

```bash
./stacks/abp/scripts/choose-ui-framework.sh --ui angular --yes
```

Salva `.abp-stack.json`.

### 3. Criar solution ABP

**Angular (clássico):**

```bash
abp new MeuApp -u ng -d ef
```

**React (modern):**

```bash
abp new MeuApp --template app --modern --ui-framework react
```

**Blazor / MVC:**

```bash
abp new MeuApp -u blazor -d ef
abp new MeuApp -u mvc -d ef
```

Preferir [ABP Studio](https://abp.io/studio) para wizard completo.

### 4. MCP ABP Studio

```bash
cp stacks/abp/.mcp.json.example .mcp.json
```

- Abrir solution no ABP Studio
- Habilitar `abp-studio` em MCP Settings (Cursor)
- Ferramentas: exceções, logs, start/stop apps, `list_modules`

MCP cloud (`abp mcp`) — docs/source search — requer licença separada.

### 5. .gitignore

`apply-stack.sh` anexa `docs/templates-linguagem/gitignore-dotnet-abp.txt` automaticamente.

### 6. Verificação

```bash
dotnet build
dotnet test
# Angular: cd angular && npm test
# React: cd react && npm test
```

Confirmar rules `abp-core`, `abp-mcp`, `abp-ui` e uma `ui-*` ao editar `.cs` ou frontend.

## Rules incluídas (backend — sempre)

| Rule | Domínio |
|---|---|
| `abp-core` | Módulos, DI, base classes |
| `application-layer` | AppServices, DTOs, validação |
| `authorization` | Permissões ABP |
| `ddd-patterns` | Entidades, aggregates, repositories |
| `ef-core` | DbContext, migrations |
| `development-flow` | Fluxo de features |
| `testing-patterns` | Testes unit/integration |
| … | Ver `stacks/abp/README.md` |

## UI (uma por projeto)

| UI | Rule | Skill extra |
|---|---|---|
| Angular | `ui-angular` | — |
| React | `ui-react` | `abp-react-development` |
| Blazor | `ui-blazor` | — |
| MVC | `ui-mvc` | — |

Rule `abp-ui.mdc` lê `.abp-stack.json`.

## Atualizar rules oficiais

```bash
bash stacks/abp/scripts/sync-upstream-rules.sh
git diff stacks/abp/
```

## Projetos sem ABP

```bash
rm .cursor/rules/abp-*.mdc .cursor/rules/ui-*.mdc
rm -rf .cursor/skills/abp-react-development
rm -f .abp-stack.json .mcp.json
```

## Referências

- [stacks/abp/README.md](../../stacks/abp/README.md)
- [ABP Framework](https://abp.io/)
- [React UI](https://abp.io/docs/latest/framework/ui/react)
- [cursor-abp-plugin](https://github.com/abpframework/cursor-abp-plugin)
- [COMO_USAR.md](../COMO_USAR.md)
