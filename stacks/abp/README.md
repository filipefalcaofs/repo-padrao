# Stack ABP

Stack híbrido para projetos [ABP Framework](https://abp.io/): **rules oficiais** do [cursor-abp-plugin](https://github.com/abpframework/cursor-abp-plugin) + integração repo-padrao (MCP, escolha de UI, React modern).

## Conteúdo

| Item | Origem |
|---|---|
| 16 rules `.mdc` (backend, DDD, EF, testes…) | Oficial — `cursor-abp-plugin` |
| `ui-angular`, `ui-blazor`, `ui-mvc` | Oficial |
| `ui-react`, `abp-react-development` | Custom repo-padrao (gap React modern) |
| `abp-mcp.mdc`, `abp-ui.mdc` | Custom repo-padrao |
| `.mcp.json.example` | Oficial (`abp mcp-studio`) |

## Aplicar em um projeto

### Opção A — Clonou repo-padrao

```bash
cd meu-projeto
bash stacks/abp/scripts/apply-stack.sh .
./stacks/abp/scripts/choose-ui-framework.sh
```

### Opção B — Solution ABP existente

```bash
bash /tmp/repo-padrao/stacks/abp/scripts/apply-stack.sh . --ui angular
```

### Opção C — Novo projeto

```bash
git clone https://github.com/filipefalcaofs/repo-padrao.git meu-app
cd meu-app
bash stacks/abp/scripts/apply-stack.sh . --ui angular
abp new MeuApp -u ng -d ef
```

## Frameworks UI

| `--ui` | Rule | Criar solution |
|---|---|---|
| `angular` (padrão) | `ui-angular` | `abp new App -u ng` |
| `react` | `ui-react` + skill `abp-react-development` | `abp new App --template app --modern --ui-framework react` |
| `blazor` | `ui-blazor` | `abp new App -u blazor` |
| `mvc` | `ui-mvc` | `abp new App -u mvc` |

Salva `.abp-stack.json` na raiz.

## MCP ABP Studio

1. Instalar [ABP Studio](https://abp.io/studio) e CLI `abp`
2. Copiar `stacks/abp/.mcp.json.example` → `.mcp.json`
3. Abrir solution no ABP Studio
4. Habilitar `abp-studio` em MCP Settings (Cursor)

## Atualizar rules oficiais

```bash
bash stacks/abp/scripts/sync-upstream-rules.sh
```

Copia de `abpframework/cursor-abp-plugin` para `rules-upstream/` e `.cursor/rules/`. Rules custom (`abp-mcp`, `abp-ui`, `ui-react`) não são sobrescritas.

## Referências

- [Guia completo](../../docs/stacks/ABP.md)
- [ABP Studio MCP](https://abp.io/docs/latest/studio/model-context-protocol)
- [cursor-abp-plugin](https://github.com/abpframework/cursor-abp-plugin)
