#!/usr/bin/env bash
set -euo pipefail

# Aplica o stack Laravel do repo-padrao na raiz do projeto atual.
# Uso: ./stacks/laravel/scripts/apply-stack.sh
#      ou, a partir da raiz do repo-padrao clonado: bash stacks/laravel/scripts/apply-stack.sh

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
STACK="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-$(pwd)}"

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
cp -R "$STACK/.cursor/skills/." "$TARGET/.cursor/skills/"

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

# .gitignore Laravel
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
echo "Stack Laravel aplicado."
echo ""
echo "Próximos passos no projeto Laravel:"
echo "  composer require laravel/boost --dev"
echo "  php artisan boost:install"
echo "  Habilitar laravel-boost em MCP Settings (Cursor)"
echo ""
echo "Documentação: docs/stacks/LARAVEL.md"
