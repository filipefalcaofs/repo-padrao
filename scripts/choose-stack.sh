#!/usr/bin/env bash
set -euo pipefail

# Escolhe a stack do projeto e aplica as rules/skills correspondentes
# chamando o stacks/<stack>/scripts/apply-stack.sh no destino.
#
# Uso:
#   bash scripts/choose-stack.sh /caminho/do/projeto                       # menu interativo
#   bash scripts/choose-stack.sh /caminho/do/projeto --stack laravel --variant vue
#   bash scripts/choose-stack.sh /caminho/do/projeto --stack none         # agnóstico

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

TARGET=""
STACK=""
VARIANT=""

usage() {
  cat <<'EOF'
Uso:
  bash scripts/choose-stack.sh TARGET [--stack NOME] [--variant NOME]

Stacks e variantes:
  laravel   (variant: vue | react | svelte)
  jhipster  (variant: angular | react | vue)
  abp       (variant: angular | react | blazor | mvc)
  django
  nestjs
  go-api
  none      (agnóstico — sem stack)

Sem --stack, abre menu interativo.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --stack) STACK="${2:?}"; shift 2 ;;
    --variant) VARIANT="${2:?}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
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

if [[ -z "$TARGET" ]]; then
  usage
  exit 1
fi

if [[ ! -d "$TARGET" ]]; then
  echo "Erro: destino não existe: $TARGET" >&2
  exit 1
fi
TARGET="$(cd "$TARGET" && pwd)"

ask_option() {
  # ask_option "Pergunta" opcao1 opcao2 ... — imprime a escolhida em stdout
  local prompt="$1"; shift
  local options=("$@")
  local i choice
  echo "" >&2
  echo "$prompt" >&2
  for i in "${!options[@]}"; do
    echo "  $((i + 1))) ${options[$i]}" >&2
  done
  while true; do
    printf "Escolha [1-%d]: " "${#options[@]}" >&2
    read -r choice
    if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#options[@]} )); then
      echo "${options[$((choice - 1))]}"
      return 0
    fi
    echo "Opção inválida." >&2
  done
}

if [[ -z "$STACK" ]]; then
  STACK="$(ask_option "Qual a stack do projeto?" \
    "laravel (PHP — Laravel + Inertia)" \
    "jhipster (Java — Spring Boot)" \
    "abp (.NET C#)" \
    "django (Python — Django + DRF)" \
    "nestjs (TypeScript — NestJS API)" \
    "go-api (Go — REST API)" \
    "none (agnóstico — sem stack)")"
  STACK="${STACK%% *}"
fi

variant_for() {
  local stack="$1"
  case "$stack" in
    laravel) ask_option "Qual adapter Inertia?" "vue" "react" "svelte" ;;
    jhipster) ask_option "Qual frontend?" "angular" "react" "vue" ;;
    abp) ask_option "Qual UI?" "angular" "react" "blazor" "mvc" ;;
    *) echo "" ;;
  esac
}

validate_variant() {
  local stack="$1" variant="$2"
  case "$stack" in
    laravel) [[ "$variant" =~ ^(vue|react|svelte)$ ]] ;;
    jhipster) [[ "$variant" =~ ^(angular|react|vue)$ ]] ;;
    abp) [[ "$variant" =~ ^(angular|react|blazor|mvc)$ ]] ;;
    *) [[ -z "$variant" ]] ;;
  esac
}

case "$STACK" in
  laravel|jhipster|abp)
    if [[ -z "$VARIANT" ]]; then
      VARIANT="$(variant_for "$STACK")"
    fi
    if ! validate_variant "$STACK" "$VARIANT"; then
      echo "Erro: variante inválida '$VARIANT' para a stack $STACK" >&2
      usage
      exit 1
    fi
    ;;
  django|nestjs|go-api|none)
    if [[ -n "$VARIANT" ]]; then
      echo "Erro: a stack $STACK não tem variantes" >&2
      exit 1
    fi
    ;;
  *)
    echo "Erro: stack desconhecida: $STACK" >&2
    usage
    exit 1
    ;;
esac

GUIDE=""
case "$STACK" in
  laravel)
    bash "$ROOT/stacks/laravel/scripts/apply-stack.sh" "$TARGET" --adapter "$VARIANT" --yes
    GUIDE="LARAVEL.md"
    ;;
  jhipster)
    bash "$ROOT/stacks/jhipster/scripts/apply-stack.sh" "$TARGET" --frontend "$VARIANT" --yes
    GUIDE="JHIPSTER.md"
    ;;
  abp)
    bash "$ROOT/stacks/abp/scripts/apply-stack.sh" "$TARGET" --ui "$VARIANT" --yes
    GUIDE="ABP.md"
    ;;
  django)
    bash "$ROOT/stacks/django/scripts/apply-stack.sh" "$TARGET"
    GUIDE="DJANGO.md"
    ;;
  nestjs)
    bash "$ROOT/stacks/nestjs/scripts/apply-stack.sh" "$TARGET"
    GUIDE="NESTJS.md"
    ;;
  go-api)
    bash "$ROOT/stacks/go-api/scripts/apply-stack.sh" "$TARGET"
    GUIDE="GO.md"
    ;;
  none)
    echo "Projeto agnóstico — nenhuma stack aplicada."
    ;;
esac

if [[ -n "$GUIDE" && -f "$ROOT/docs/stacks/$GUIDE" ]]; then
  mkdir -p "$TARGET/docs/stacks"
  cp "$ROOT/docs/stacks/$GUIDE" "$TARGET/docs/stacks/"
  echo "Guia da stack copiado para docs/stacks/$GUIDE"
fi

cat > "$TARGET/.repo-padrao.json" <<EOF
{
  "overlay": "base",
  "stack": "$STACK",
  "variant": "${VARIANT:-none}",
  "source": "filipefalcaofs/repo-padrao",
  "applied_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF

echo ""
echo "Stack configurada: $STACK${VARIANT:+ ($VARIANT)}"
