#!/usr/bin/env bash
set -euo pipefail

# Escolhe o framework frontend JHipster (Angular, React ou Vue) e instala só a skill correspondente.
#
# Uso (interativo, a partir da raiz do projeto):
#   ./stacks/jhipster/scripts/choose-frontend-framework.sh
#
# Uso (não interativo):
#   ./stacks/jhipster/scripts/choose-frontend-framework.sh --frontend angular --yes
#   ./stacks/jhipster/scripts/choose-frontend-framework.sh --frontend react --target /caminho/do/projeto

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
STACK_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
REPO_ROOT="$(cd "$STACK_DIR/../.." && pwd)"

FRONTEND=""
TARGET=""
NON_INTERACTIVE=false

usage() {
  cat <<'EOF'
Escolhe o framework frontend JHipster e remove skills dos frameworks não usados.

Opções:
  --frontend angular|react|vue   Framework (obrigatório com --yes)
  --target DIR                   Diretório do projeto (padrão: raiz do repo-padrao)
  --yes                          Não perguntar (exige --frontend)
  -h, --help                     Esta ajuda

Exemplos:
  ./stacks/jhipster/scripts/choose-frontend-framework.sh
  ./stacks/jhipster/scripts/choose-frontend-framework.sh --frontend angular --yes
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --frontend)
      FRONTEND="${2:?}"
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

normalize_frontend() {
  local input
  input="$(echo "$1" | tr '[:upper:]' '[:lower:]')"
  case "$input" in
    angular|a|ng) echo "angular" ;;
    react|r) echo "react" ;;
    vue|v) echo "vue" ;;
    *) return 1 ;;
  esac
}

skill_for_frontend() {
  case "$1" in
    angular) echo "jhipster-angular-development" ;;
    react) echo "jhipster-react-development" ;;
    vue) echo "jhipster-vue-development" ;;
  esac
}

remove_frontend_skills() {
  local base="$1"
  rm -rf "$base/.cursor/skills/jhipster-angular-development" \
         "$base/.cursor/skills/jhipster-react-development" \
         "$base/.cursor/skills/jhipster-vue-development" \
         "$base/.claude/skills/jhipster-angular-development" \
         "$base/.claude/skills/jhipster-react-development" \
         "$base/.claude/skills/jhipster-vue-development" \
         "$base/.codex/skills/jhipster-angular-development" \
         "$base/.codex/skills/jhipster-react-development" \
         "$base/.codex/skills/jhipster-vue-development" 2>/dev/null || true
}

install_frontend_skill() {
  local frontend="$1"
  local skill
  skill="$(skill_for_frontend "$frontend")"
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

if [[ -z "$FRONTEND" ]]; then
  if [[ "$NON_INTERACTIVE" == true ]]; then
    echo "Erro: use --frontend angular|react|vue com --yes" >&2
    exit 1
  fi

  echo ""
  echo "Framework frontend JHipster — escolha o frontend do projeto:"
  echo ""
  echo "  1) Angular   — padrão histórico JHipster / mais comum"
  echo "  2) React"
  echo "  3) Vue"
  echo ""
  read -r -p "Opção [1-3] (padrão: 1): " choice
  choice="${choice:-1}"

  case "$choice" in
    1) FRONTEND="angular" ;;
    2) FRONTEND="react" ;;
    3) FRONTEND="vue" ;;
    *)
      echo "Opção inválida: $choice" >&2
      exit 1
      ;;
  esac
fi

FRONTEND="$(normalize_frontend "$FRONTEND")" || {
  echo "Framework inválido. Use: angular, react ou vue" >&2
  exit 1
}

echo ""
echo "Configurando frontend JHipster: $FRONTEND"
echo "  Destino: $TARGET"
echo ""

remove_frontend_skills "$TARGET"
install_frontend_skill "$FRONTEND"

cat > "$TARGET/.jhipster-stack.json" <<EOF
{
  "frontend": "$FRONTEND",
  "frontend_skill": "$(skill_for_frontend "$FRONTEND")",
  "configured_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF

echo "Skill instalada: $(skill_for_frontend "$FRONTEND")"
echo "Config salva em: $TARGET/.jhipster-stack.json"
echo ""
echo "Bootstrap JHipster (exemplo monolith):"
echo "  npm install -g generator-jhipster"
echo "  jhipster jdl app.jdl   # ou jhipster (interativo)"
echo ""
case "$FRONTEND" in
  angular) echo "No JDL: application { config { clientFramework angular } }" ;;
  react) echo "No JDL: application { config { clientFramework react } }" ;;
  vue) echo "No JDL: application { config { clientFramework vue } }" ;;
esac
echo ""
