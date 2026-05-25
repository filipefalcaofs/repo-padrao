#!/usr/bin/env bash
set -euo pipefail

# Aplica o stack ABP do repo-padrao na raiz do projeto atual.
#
# Uso:
#   bash stacks/abp/scripts/apply-stack.sh
#   bash stacks/abp/scripts/apply-stack.sh /caminho/do/abp
#   bash stacks/abp/scripts/apply-stack.sh . --ui angular
#
# Variável de ambiente:
#   ABP_UI=angular|react|blazor|mvc

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
STACK="$(cd "$SCRIPT_DIR/.." && pwd)"
ROOT="$(cd "$STACK/../.." && pwd)"

TARGET=""
UI="${ABP_UI:-}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --ui)
      UI="${2:?}"
      shift 2
      ;;
    --yes)
      shift
      ;;
    -h|--help)
      echo "Uso: apply-stack.sh [TARGET] [--ui angular|react|blazor|mvc]"
      exit 0
      ;;
    *)
      if [[ -z "$TARGET" ]]; then
        TARGET="$1"
      else
        echo "Argumento desconhecido: $1" >&2
        exit 1
      fi
      shift
      ;;
  esac
done

TARGET="${TARGET:-$(pwd)}"

if [[ ! -d "$STACK/.cursor/rules" ]]; then
  echo "Erro: stack ABP não encontrado em $STACK" >&2
  exit 1
fi

echo "Aplicando stack ABP..."
echo "  Origem: $STACK"
echo "  Destino: $TARGET"

mkdir -p "$TARGET/.cursor/rules"

# Backend + MCP (sem ui-* — escolhidos depois)
for rule in abp-core application-layer authorization cli-commands ddd-patterns \
  dependency-rules development-flow ef-core infrastructure mongodb multi-tenancy \
  solution-templates testing-patterns abp-mcp abp-ui; do
  if [[ -f "$STACK/.cursor/rules/${rule}.mdc" ]]; then
    cp "$STACK/.cursor/rules/${rule}.mdc" "$TARGET/.cursor/rules/"
  fi
done

if [[ -f "$STACK/.mcp.json.example" ]] && [[ ! -f "$TARGET/.mcp.json" ]]; then
  cp "$STACK/.mcp.json.example" "$TARGET/.mcp.json"
  echo "  Criado .mcp.json (ABP Studio deve estar rodando; habilitar abp-studio no Cursor)"
fi

GITIGNORE_TEMPLATE="$ROOT/docs/templates-linguagem/gitignore-dotnet-abp.txt"
if [[ ! -f "$GITIGNORE_TEMPLATE" ]]; then
  GITIGNORE_TEMPLATE="$ROOT/docs/templates-linguagem/gitignore-dotnet.txt"
fi

if [[ -f "$GITIGNORE_TEMPLATE" ]]; then
  if ! grep -q "# ABP (repo-padrao stack)" "$TARGET/.gitignore" 2>/dev/null; then
    touch "$TARGET/.gitignore"
    echo "" >> "$TARGET/.gitignore"
    echo "# ABP (repo-padrao stack)" >> "$TARGET/.gitignore"
    cat "$GITIGNORE_TEMPLATE" >> "$TARGET/.gitignore"
    echo "  Anexado template .gitignore .NET/ABP"
  fi
fi

echo ""
echo "Escolhendo framework UI..."
if [[ -n "$UI" ]]; then
  bash "$SCRIPT_DIR/choose-ui-framework.sh" --ui "$UI" --yes --target "$TARGET"
else
  bash "$SCRIPT_DIR/choose-ui-framework.sh" --target "$TARGET"
fi

echo ""
echo "Stack ABP aplicado."
echo ""
echo "Próximos passos:"
echo "  Instalar ABP Studio e CLI abp"
echo "  Abrir solution no ABP Studio (para MCP abp-studio)"
echo "  abp new MeuApp -u ng   # ou --modern --ui-framework react"
echo ""
echo "Documentação: docs/stacks/ABP.md"
echo "Rules oficiais: https://github.com/abpframework/cursor-abp-plugin"
echo ""
