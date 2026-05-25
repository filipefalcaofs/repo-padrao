---
name: abp-react-development
description: "Aplicar em projetos ABP com React UI (modern template): Vite, TanStack Router/Query, shadcn/ui, OIDC, Admin Console e integração com API .NET. Usar quando .abp-stack.json indica ui_framework react ou pastas react/ e apps/react/."
license: MIT
metadata:
  author: repo-padrao
---

# ABP React Development

Skill para o [React UI moderno do ABP](https://abp.io/docs/latest/framework/ui/react). Complementa rules oficiais backend do `cursor-abp-plugin`.

## Pré-requisitos

Solution criada com template modern:

```bash
abp new MeuApp --template app --modern --ui-framework react
```

## Estrutura

- `react/src/components/ui/` — primitivos shadcn (editáveis)
- `react/src/components/layout/` — shell da aplicação
- `react/src/routes/` — TanStack Router
- Backend: Auth Server + HttpApi + Admin Console

## Fluxo de feature

1. Confirmar DTOs e AppService no backend ABP
2. Adicionar rota em TanStack Router
3. Query/mutation com TanStack Query + Axios
4. Formulário com React Hook Form + Zod
5. Permissões via hooks/config ABP expostos no template

## Comandos

```bash
cd react && npm install && npm run dev
dotnet build
abp generate-proxy   # quando aplicável ao template
```

## Diferença vs Angular clássico

| | Angular clássico | React modern |
|---|---|---|
| Template | `-u ng` | `--modern --ui-framework react` |
| Pacotes | `@abp/ng.*` | Código fonte no repo |
| Proxy | `abp generate-proxy -t ng` | Axios + convenções do template |
| Maturidade módulos | Maior | Crescendo (10.4+) |

## Rule relacionada

Ativar rule `ui-react` (`.cursor/rules/ui-react.mdc`) ao editar arquivos em `react/`.
