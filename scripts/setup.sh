#!/usr/bin/env bash
set -euo pipefail

# Ponto de entrada para criar um projeto com aiox-core + overlay repo-padrao.
#
# Fluxo:
#   1. npx aiox-core@latest init <nome>      (infraestrutura multi-IDE, agentes, squads)
#   2. overlay/base/apply.sh <destino>       (convenções universais do repo-padrao)
#   3. scripts/choose-stack.sh <destino>     (rules/skills da stack escolhida)
#
# Uso:
#   bash scripts/setup.sh meu-projeto                          # cria ../meu-projeto (irmão do repo-padrao)
#   bash scripts/setup.sh meu-projeto --stack laravel --variant vue
#   bash scripts/setup.sh --existing /caminho/projeto          # projeto existente (aiox-core install)
#   bash scripts/setup.sh meu-projeto -- --skip-install        # args após -- vão para o aiox-core

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PARENT="$(dirname "$ROOT")"

NAME=""
EXISTING=""
STACK=""
VARIANT=""
AIOX_ARGS=()

usage() {
  cat <<'EOF'
Uso:
  bash scripts/setup.sh NOME-PROJETO [--stack NOME] [--variant NOME] [-- ARGS-AIOX]
  bash scripts/setup.sh --existing /caminho/projeto [--stack NOME] [--variant NOME]

Opções:
  --existing DIR     Aplica em projeto existente (usa aiox-core install em vez de init)
  --stack NOME       Stack: laravel | jhipster | abp | django | nestjs | go-api | none
  --variant NOME     Variante da stack (ex.: vue, react, angular, blazor)
  -- ARGS            Argumentos extras repassados ao aiox-core (ex.: -- --skip-install)

Sem --stack, o menu interativo de stacks é exibido ao final.

O projeto novo é criado como irmão do repo-padrao:
  repo-padrao/ ../NOME-PROJETO
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --existing) EXISTING="${2:?}"; shift 2 ;;
    --stack) STACK="${2:?}"; shift 2 ;;
    --variant) VARIANT="${2:?}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    --)
      shift
      AIOX_ARGS=("$@")
      break
      ;;
    *)
      if [[ -z "$NAME" ]]; then
        NAME="$1"
      else
        echo "Argumento desconhecido: $1" >&2
        usage
        exit 1
      fi
      shift
      ;;
  esac
done

if [[ -z "$NAME" && -z "$EXISTING" ]]; then
  usage
  exit 1
fi

if [[ -n "$NAME" && -n "$EXISTING" ]]; then
  echo "Erro: use NOME-PROJETO ou --existing, não os dois" >&2
  exit 1
fi

if ! command -v npx >/dev/null 2>&1; then
  echo "Erro: npx não encontrado. Instale Node.js >= 18 (https://nodejs.org)" >&2
  exit 1
fi

# --- 1. aiox-core (sempre latest) ----------------------------------------------
if [[ -n "$EXISTING" ]]; then
  if [[ ! -d "$EXISTING" ]]; then
    echo "Erro: diretório não existe: $EXISTING" >&2
    exit 1
  fi
  DEST="$(cd "$EXISTING" && pwd)"
  echo ">>> Instalando aiox-core@latest no projeto existente: $DEST"
  (cd "$DEST" && npx aiox-core@latest install "${AIOX_ARGS[@]+"${AIOX_ARGS[@]}"}")
else
  case "$NAME" in
    */*)
      DEST="$NAME"
      mkdir -p "$(dirname "$DEST")"
      ;;
    *)
      DEST="$PARENT/$NAME"
      ;;
  esac
  if [[ -e "$DEST" ]]; then
    echo "Erro: destino já existe: $DEST" >&2
    echo "Para projeto existente, use: bash scripts/setup.sh --existing $DEST" >&2
    exit 1
  fi
  echo ">>> Criando projeto com aiox-core@latest: $DEST"
  (cd "$(dirname "$DEST")" && npx aiox-core@latest init "$(basename "$DEST")" "${AIOX_ARGS[@]+"${AIOX_ARGS[@]}"}")
  if [[ ! -d "$DEST" ]]; then
    echo "Erro: o aiox-core não criou o diretório esperado: $DEST" >&2
    exit 1
  fi
fi

# --- 2. Overlay base (convenções universais) -----------------------------------
echo ""
echo ">>> Aplicando overlay base do repo-padrao"
bash "$ROOT/overlay/base/apply.sh" "$DEST"

# --- 3. Stack -------------------------------------------------------------------
echo ""
echo ">>> Configurando stack"
CHOOSE_ARGS=("$DEST")
[[ -n "$STACK" ]] && CHOOSE_ARGS+=(--stack "$STACK")
[[ -n "$VARIANT" ]] && CHOOSE_ARGS+=(--variant "$VARIANT")
bash "$ROOT/scripts/choose-stack.sh" "${CHOOSE_ARGS[@]}"

echo ""
echo "Projeto pronto: $DEST"
echo ""
echo "Próximos passos:"
echo "  cd $DEST"
echo "  Criar o esqueleto da aplicação (comandos no guia em docs/stacks/, se houver stack)"
echo "  Registrar a escolha da stack em docs/brain/3-resources/adrs/"
