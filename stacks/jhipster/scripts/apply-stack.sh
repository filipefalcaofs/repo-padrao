#!/usr/bin/env bash
set -euo pipefail

# Aplica o stack JHipster do repo-padrao na raiz do projeto atual.
#
# Uso:
#   bash stacks/jhipster/scripts/apply-stack.sh
#   bash stacks/jhipster/scripts/apply-stack.sh /caminho/do/jhipster
#   bash stacks/jhipster/scripts/apply-stack.sh . --frontend angular
#
# Variável de ambiente:
#   JHIPSTER_FRONTEND=angular|react|vue

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
STACK="$(cd "$SCRIPT_DIR/.." && pwd)"
ROOT="$(cd "$STACK/../.." && pwd)"

TARGET=""
FRONTEND="${JHIPSTER_FRONTEND:-}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --frontend)
      FRONTEND="${2:?}"
      shift 2
      ;;
    --yes)
      shift
      ;;
    -h|--help)
      echo "Uso: apply-stack.sh [TARGET] [--frontend angular|react|vue]"
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
  echo "Erro: stack JHipster não encontrado em $STACK" >&2
  exit 1
fi

echo "Aplicando stack JHipster..."
echo "  Origem: $STACK"
echo "  Destino: $TARGET"

mkdir -p "$TARGET/.cursor/rules" "$TARGET/.cursor/skills"
mkdir -p "$TARGET/.claude/skills" "$TARGET/.codex/skills"

cp -R "$STACK/.cursor/rules/." "$TARGET/.cursor/rules/"

for skill in jhipster-development jhipster-jdl spring-testing; do
  if [[ -d "$STACK/.cursor/skills/$skill" ]]; then
    cp -R "$STACK/.cursor/skills/$skill" "$TARGET/.cursor/skills/"
    cp -R "$STACK/.cursor/skills/$skill" "$TARGET/.claude/skills/"
    cp -R "$STACK/.cursor/skills/$skill" "$TARGET/.codex/skills/"
  fi
done

GITIGNORE_TEMPLATE="$ROOT/docs/templates-linguagem/gitignore-java-jhipster.txt"
if [[ ! -f "$GITIGNORE_TEMPLATE" ]]; then
  GITIGNORE_TEMPLATE="$ROOT/docs/templates-linguagem/gitignore-java.txt"
fi

if [[ -f "$GITIGNORE_TEMPLATE" ]]; then
  if ! grep -q "# JHipster (repo-padrao stack)" "$TARGET/.gitignore" 2>/dev/null; then
    touch "$TARGET/.gitignore"
    echo "" >> "$TARGET/.gitignore"
    echo "# JHipster (repo-padrao stack)" >> "$TARGET/.gitignore"
    cat "$GITIGNORE_TEMPLATE" >> "$TARGET/.gitignore"
    echo "  Anexado template .gitignore Java/JHipster"
  fi
fi

echo ""
echo "Escolhendo framework frontend..."
if [[ -n "$FRONTEND" ]]; then
  bash "$SCRIPT_DIR/choose-frontend-framework.sh" --frontend "$FRONTEND" --yes --target "$TARGET"
else
  bash "$SCRIPT_DIR/choose-frontend-framework.sh" --target "$TARGET"
fi

echo ""
echo "Stack JHipster aplicado."
echo ""
echo "Próximos passos:"
echo "  npm install -g generator-jhipster"
echo "  jhipster   # ou jhipster jdl app.jdl"
echo "  ./mvnw test   # ou ./gradlew test"
echo ""
echo "Documentação: docs/stacks/JHIPSTER.md"
echo ""
