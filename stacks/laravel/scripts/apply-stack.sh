#!/usr/bin/env bash
set -euo pipefail

# Aplica o stack Laravel do repo-padrao na raiz do projeto atual.
#
# Uso:
#   bash stacks/laravel/scripts/apply-stack.sh
#   bash stacks/laravel/scripts/apply-stack.sh /caminho/do/laravel
#   bash stacks/laravel/scripts/apply-stack.sh . --adapter vue
#
# Variável de ambiente:
#   INERTIA_ADAPTER=vue|react|svelte

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
STACK="$(cd "$SCRIPT_DIR/.." && pwd)"
ROOT="$(cd "$STACK/../.." && pwd)"

TARGET=""
ADAPTER="${INERTIA_ADAPTER:-}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --adapter)
      ADAPTER="${2:?}"
      shift 2
      ;;
    --yes)
      shift
      ;;
    -h|--help)
      echo "Uso: apply-stack.sh [TARGET] [--adapter vue|react|svelte]"
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

if [[ ! -d "$STACK/.cursor" ]]; then
  echo "Erro: stack Laravel não encontrado em $STACK" >&2
  exit 1
fi

echo "Aplicando stack Laravel..."
echo "  Origem: $STACK"
echo "  Destino: $TARGET"

mkdir -p "$TARGET/.cursor/rules" "$TARGET/.cursor/skills"
mkdir -p "$TARGET/.ai/guidelines" "$TARGET/.ai/skills"
mkdir -p "$TARGET/.claude/skills" "$TARGET/.codex/skills"

cp -R "$STACK/.cursor/rules/." "$TARGET/.cursor/rules/"

# Backend + utilitários (sem Inertia — escolhido depois)
for skill in laravel-best-practices laravel-boost pest-testing livewire-development tailwindcss-development; do
  if [[ -d "$STACK/.cursor/skills/$skill" ]]; then
    cp -R "$STACK/.cursor/skills/$skill" "$TARGET/.cursor/skills/"
  fi
done

if [[ -d "$STACK/.ai" ]]; then
  cp -R "$STACK/.ai/guidelines/." "$TARGET/.ai/guidelines/" 2>/dev/null || true
  cp -R "$STACK/.ai/skills/." "$TARGET/.ai/skills/" 2>/dev/null || true
fi

for skill in laravel-best-practices laravel-boost pest-testing; do
  if [[ -d "$STACK/.cursor/skills/$skill" ]]; then
    cp -R "$STACK/.cursor/skills/$skill" "$TARGET/.claude/skills/"
    cp -R "$STACK/.cursor/skills/$skill" "$TARGET/.codex/skills/"
  fi
done

if [[ -f "$STACK/.mcp.json.example" ]] && [[ ! -f "$TARGET/.mcp.json" ]]; then
  cp "$STACK/.mcp.json.example" "$TARGET/.mcp.json"
  echo "  Criado .mcp.json (habilitar laravel-boost no Cursor após composer require laravel/boost)"
fi

if [[ -f "$STACK/boost.json.example" ]] && [[ ! -f "$TARGET/boost.json" ]]; then
  cp "$STACK/boost.json.example" "$TARGET/boost.json"
fi

GITIGNORE_TEMPLATE="$ROOT/docs/templates-linguagem/gitignore-php-laravel.txt"
if [[ -f "$GITIGNORE_TEMPLATE" ]]; then
  if ! grep -q "# Laravel (repo-padrao stack)" "$TARGET/.gitignore" 2>/dev/null; then
    echo "" >> "$TARGET/.gitignore"
    echo "# Laravel (repo-padrao stack)" >> "$TARGET/.gitignore"
    cat "$GITIGNORE_TEMPLATE" >> "$TARGET/.gitignore"
    echo "  Anexado template .gitignore Laravel"
  fi
fi

echo ""
echo "Escolhendo adapter Inertia.js..."
if [[ -n "$ADAPTER" ]]; then
  bash "$SCRIPT_DIR/choose-inertia-adapter.sh" --adapter "$ADAPTER" --yes --target "$TARGET"
else
  bash "$SCRIPT_DIR/choose-inertia-adapter.sh" --target "$TARGET"
fi

echo ""
echo "Stack Laravel aplicado."
echo ""
echo "Próximos passos:"
echo "  composer require laravel/boost --dev"
echo "  php artisan boost:install"
echo "  Habilitar laravel-boost em MCP Settings (Cursor)"
echo ""
echo "Documentação: docs/stacks/LARAVEL.md"
