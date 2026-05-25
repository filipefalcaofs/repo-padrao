#!/usr/bin/env bash
set -euo pipefail

# Escolhe o framework UI ABP (Angular, React, Blazor ou MVC) e mantém só a rule ui-* correspondente.
#
# Uso (interativo):
#   ./stacks/abp/scripts/choose-ui-framework.sh
#
# Uso (não interativo):
#   ./stacks/abp/scripts/choose-ui-framework.sh --ui angular --yes
#   ./stacks/abp/scripts/choose-ui-framework.sh --ui react --target /caminho/do/projeto

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
STACK_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
REPO_ROOT="$(cd "$STACK_DIR/../.." && pwd)"

UI=""
TARGET=""
NON_INTERACTIVE=false

usage() {
  cat <<'EOF'
Escolhe o framework UI ABP e remove rules ui-* dos frameworks não usados.

Opções:
  --ui angular|react|blazor|mvc   Framework UI (obrigatório com --yes)
  --target DIR                    Diretório do projeto (padrão: raiz do repo-padrao)
  --yes                           Não perguntar (exige --ui)
  -h, --help                      Esta ajuda

Exemplos:
  ./stacks/abp/scripts/choose-ui-framework.sh
  ./stacks/abp/scripts/choose-ui-framework.sh --ui angular --yes
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --ui)
      UI="${2:?}"
      shift 2
      ;;
    --target)
      TARGET="${2:?}"
      shift 2
      ;;
    --yes|--non-interactive)
      NON_INTERACTIVE=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Opção desconhecida: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

TARGET="${TARGET:-$REPO_ROOT}"

normalize_ui() {
  local input
  input="$(echo "$1" | tr '[:upper:]' '[:lower:]')"
  case "$input" in
    angular|a|ng) echo "angular" ;;
    react|r) echo "react" ;;
    blazor|b|blazor-server|blazorwasm) echo "blazor" ;;
    mvc|razor|razor-pages) echo "mvc" ;;
    *) return 1 ;;
  esac
}

rule_for_ui() {
  case "$1" in
    angular) echo "ui-angular" ;;
    react) echo "ui-react" ;;
    blazor) echo "ui-blazor" ;;
    mvc) echo "ui-mvc" ;;
  esac
}

skill_for_ui() {
  case "$1" in
    react) echo "abp-react-development" ;;
    *) echo "" ;;
  esac
}

remove_ui_rules() {
  local base="$1"
  local rule
  for rule in ui-angular ui-blazor ui-mvc ui-react; do
    rm -f "$base/.cursor/rules/${rule}.mdc" 2>/dev/null || true
  done
}

install_ui_rule() {
  local ui="$1"
  local rule
  rule="$(rule_for_ui "$ui")"
  local src="$STACK_DIR/.cursor/rules/${rule}.mdc"

  if [[ ! -f "$src" ]]; then
    echo "Erro: rule não encontrada em $src" >&2
    exit 1
  fi

  mkdir -p "$TARGET/.cursor/rules"
  cp "$src" "$TARGET/.cursor/rules/"
}

remove_react_skill() {
  local base="$1"
  rm -rf "$base/.cursor/skills/abp-react-development" \
         "$base/.claude/skills/abp-react-development" \
         "$base/.codex/skills/abp-react-development" 2>/dev/null || true
}

install_react_skill() {
  local src="$STACK_DIR/.cursor/skills/abp-react-development"
  if [[ ! -d "$src" ]]; then
    echo "Erro: skill não encontrada em $src" >&2
    exit 1
  fi
  mkdir -p "$TARGET/.cursor/skills" "$TARGET/.claude/skills" "$TARGET/.codex/skills"
  cp -R "$src" "$TARGET/.cursor/skills/"
  cp -R "$src" "$TARGET/.claude/skills/"
  cp -R "$src" "$TARGET/.codex/skills/"
}

if [[ -z "$UI" ]]; then
  if [[ "$NON_INTERACTIVE" == true ]]; then
    echo "Erro: use --ui angular|react|blazor|mvc com --yes" >&2
    exit 1
  fi

  echo ""
  echo "Framework UI ABP — escolha o frontend do projeto:"
  echo ""
  echo "  1) Angular   — padrão clássico ABP (SPA + @abp/ng.*)"
  echo "  2) React     — modern template (--modern --ui-framework react)"
  echo "  3) Blazor    — C# end-to-end (Server / WASM / WebApp)"
  echo "  4) MVC       — Razor Pages / server-rendered"
  echo ""
  read -r -p "Opção [1-4] (padrão: 1): " choice
  choice="${choice:-1}"

  case "$choice" in
    1) UI="angular" ;;
    2) UI="react" ;;
    3) UI="blazor" ;;
    4) UI="mvc" ;;
    *)
      echo "Opção inválida: $choice" >&2
      exit 1
      ;;
  esac
fi

UI="$(normalize_ui "$UI")" || {
  echo "Framework inválido. Use: angular, react, blazor ou mvc" >&2
  exit 1
}

echo ""
echo "Configurando UI ABP: $UI"
echo "  Destino: $TARGET"
echo ""

remove_ui_rules "$TARGET"
install_ui_rule "$UI"

remove_react_skill "$TARGET"
if [[ "$UI" == "react" ]]; then
  install_react_skill
fi

cat > "$TARGET/.abp-stack.json" <<EOF
{
  "ui_framework": "$UI",
  "ui_rule": "$(rule_for_ui "$UI")",
  "ui_skill": "$(skill_for_ui "$UI")",
  "configured_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF

echo "Rule instalada: $(rule_for_ui "$UI").mdc"
if [[ "$UI" == "react" ]]; then
  echo "Skill instalada: abp-react-development"
fi
echo "Config salva em: $TARGET/.abp-stack.json"
echo ""
case "$UI" in
  angular)
    echo "Criar solution:"
    echo "  abp new MeuApp -u ng -d ef"
    echo "  abp generate-proxy -t ng"
    ;;
  react)
    echo "Criar solution (modern):"
    echo "  abp new MeuApp --template app --modern --ui-framework react"
    ;;
  blazor)
    echo "Criar solution:"
    echo "  abp new MeuApp -u blazor -d ef"
    echo "  # ou Blazor Server / WebApp no ABP Studio"
    ;;
  mvc)
    echo "Criar solution:"
    echo "  abp new MeuApp -u mvc -d ef"
    ;;
esac
echo ""
