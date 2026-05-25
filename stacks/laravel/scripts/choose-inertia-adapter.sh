#!/usr/bin/env bash
set -euo pipefail

# Escolhe o adapter Inertia (Vue, React ou Svelte) e instala só a skill correspondente.
#
# Uso (interativo, a partir da raiz do projeto clonado):
#   ./stacks/laravel/scripts/choose-inertia-adapter.sh
#
# Uso (não interativo):
#   ./stacks/laravel/scripts/choose-inertia-adapter.sh --adapter vue
#   ./stacks/laravel/scripts/choose-inertia-adapter.sh --adapter react --target /caminho/do/projeto

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
STACK_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
REPO_ROOT="$(cd "$STACK_DIR/../.." && pwd)"

ADAPTER=""
TARGET=""
NON_INTERACTIVE=false

usage() {
  cat <<'EOF'
Escolhe o adapter Inertia.js e remove skills dos adapters não usados.

Opções:
  --adapter vue|react|svelte   Adapter Inertia (obrigatório com --yes)
  --target DIR                 Diretório do projeto (padrão: raiz do repo-padrao)
  --yes                        Não perguntar (exige --adapter)
  -h, --help                   Esta ajuda

Exemplos:
  ./stacks/laravel/scripts/choose-inertia-adapter.sh
  ./stacks/laravel/scripts/choose-inertia-adapter.sh --adapter vue --yes
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --adapter)
      ADAPTER="${2:?}"
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

normalize_adapter() {
  local input
  input="$(echo "$1" | tr '[:upper:]' '[:lower:]')"
  case "$input" in
    vue|v|inertia-vue|inertia-vue-development) echo "vue" ;;
    react|r|inertia-react|inertia-react-development) echo "react" ;;
    svelte|s|inertia-svelte|inertia-svelte-development) echo "svelte" ;;
    *) return 1 ;;
  esac
}

skill_for_adapter() {
  case "$1" in
    vue) echo "inertia-vue-development" ;;
    react) echo "inertia-react-development" ;;
    svelte) echo "inertia-svelte-development" ;;
  esac
}

remove_inertia_skills() {
  local base="$1"
  rm -rf "$base/.cursor/skills/inertia-vue-development" \
         "$base/.cursor/skills/inertia-react-development" \
         "$base/.cursor/skills/inertia-svelte-development" \
         "$base/.claude/skills/inertia-vue-development" \
         "$base/.claude/skills/inertia-react-development" \
         "$base/.claude/skills/inertia-svelte-development" \
         "$base/.codex/skills/inertia-vue-development" \
         "$base/.codex/skills/inertia-react-development" \
         "$base/.codex/skills/inertia-svelte-development" 2>/dev/null || true
}

install_adapter_skill() {
  local adapter="$1"
  local skill
  skill="$(skill_for_adapter "$adapter")"
  local src="$STACK_DIR/.cursor/skills/$skill"

  if [[ ! -d "$src" ]]; then
    echo "Erro: skill não encontrada em $src" >&2
    exit 1
  fi

  mkdir -p "$TARGET/.cursor/skills" "$TARGET/.claude/skills" "$TARGET/.codex/skills"
  cp -R "$src" "$TARGET/.cursor/skills/"
  cp -R "$src" "$TARGET/.claude/skills/"
  cp -R "$src" "$TARGET/.codex/skills/"
}

if [[ -z "$ADAPTER" ]]; then
  if [[ "$NON_INTERACTIVE" == true ]]; then
    echo "Erro: use --adapter vue|react|svelte com --yes" >&2
    exit 1
  fi

  echo ""
  echo "Adapter Inertia.js — escolha o frontend do projeto:"
  echo ""
  echo "  1) Vue 3     (@inertiajs/vue3)     — recomendado / mais comum"
  echo "  2) React     (@inertiajs/react)"
  echo "  3) Svelte    (@inertiajs/svelte)"
  echo ""
  read -r -p "Opção [1-3] (padrão: 1): " choice
  choice="${choice:-1}"

  case "$choice" in
    1) ADAPTER="vue" ;;
    2) ADAPTER="react" ;;
    3) ADAPTER="svelte" ;;
    *)
      echo "Opção inválida: $choice" >&2
      exit 1
      ;;
  esac
fi

ADAPTER="$(normalize_adapter "$ADAPTER")" || {
  echo "Adapter inválido. Use: vue, react ou svelte" >&2
  exit 1
}

echo ""
echo "Configurando Inertia adapter: $ADAPTER"
echo "  Destino: $TARGET"
echo ""

remove_inertia_skills "$TARGET"
install_adapter_skill "$ADAPTER"

cat > "$TARGET/.laravel-stack.json" <<EOF
{
  "inertia_adapter": "$ADAPTER",
  "inertia_skill": "$(skill_for_adapter "$ADAPTER")",
  "configured_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF

echo "Skill instalada: $(skill_for_adapter "$ADAPTER")"
echo "Config salva em: $TARGET/.laravel-stack.json"
echo ""
case "$ADAPTER" in
  vue)
    echo "Pacotes npm típicos:"
    echo "  npm install @inertiajs/vue3 vue @vitejs/plugin-vue"
    ;;
  react)
    echo "Pacotes npm típicos:"
    echo "  npm install @inertiajs/react react react-dom @vitejs/plugin-react"
    ;;
  svelte)
    echo "Pacotes npm típicos:"
    echo "  npm install @inertiajs/svelte svelte @sveltejs/vite-plugin-svelte"
    ;;
esac
echo ""
echo "Composer (todos os adapters):"
echo "  composer require inertiajs/inertia-laravel"
echo "  php artisan inertia:middleware"
