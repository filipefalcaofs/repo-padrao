#!/usr/bin/env bash
set -euo pipefail

# Arquiva os 42 repositórios standalone no GitHub com notice apontando para o repo-padrao.
#
# Para cada repo:
#   1. Insere notice de descontinuação no topo do README.md (via API — sem clone)
#   2. Arquiva o repositório (somente leitura)
#
# Idempotente: pula repos já arquivados ou com notice já presente.
#
# Uso:
#   bash scripts/archive-standalone-repos.sh            # todos os 42
#   bash scripts/archive-standalone-repos.sh NOME       # um repo específico

OWNER="filipefalcaofs"
IDES=(cursor claude codex)

BASES=(
  repo-padrao-base
  repo-padrao-laravel-vue
  repo-padrao-laravel-react
  repo-padrao-laravel-svelte
  repo-padrao-jhipster-angular
  repo-padrao-jhipster-react
  repo-padrao-jhipster-vue
  repo-padrao-abp-angular
  repo-padrao-abp-react
  repo-padrao-abp-blazor
  repo-padrao-abp-mvc
  repo-padrao-django
  repo-padrao-nestjs
  repo-padrao-go-api
)

NOTICE_MARK="**ARQUIVADO**"

read -r -d '' NOTICE <<'EOF' || true
> **ARQUIVADO** — Este template foi descontinuado. Use o fluxo único do [repo-padrao](https://github.com/filipefalcaofs/repo-padrao):
>
> ```bash
> git clone https://github.com/filipefalcaofs/repo-padrao.git
> cd repo-padrao
> bash scripts/setup.sh meu-projeto
> ```

---

EOF

archive_one() {
  local name="$1"
  local full="$OWNER/$name"

  if ! gh repo view "$full" --json isArchived --jq .isArchived >/tmp/.archive-check 2>/dev/null; then
    echo "SKIP $name (não existe no GitHub)"
    return 0
  fi

  if [[ "$(cat /tmp/.archive-check)" == "true" ]]; then
    echo "SKIP $name (já arquivado)"
    return 0
  fi

  local sha content current
  if sha="$(gh api "repos/$full/contents/README.md" --jq .sha 2>/dev/null)"; then
    current="$(gh api "repos/$full/contents/README.md" --jq .content | tr -d '\n' | base64 --decode)"
    if printf '%s' "$current" | head -3 | grep -qF "$NOTICE_MARK"; then
      echo "  $name: notice já presente"
    else
      content="$(printf '%s\n%s' "$NOTICE" "$current" | base64 | tr -d '\n')"
      gh api -X PUT "repos/$full/contents/README.md" \
        -f message="docs: arquiva template — usar repo-padrao" \
        -f content="$content" \
        -f sha="$sha" >/dev/null
      echo "  $name: notice adicionado ao README"
    fi
  else
    content="$(printf '%s' "$NOTICE" | base64 | tr -d '\n')"
    gh api -X PUT "repos/$full/contents/README.md" \
      -f message="docs: arquiva template — usar repo-padrao" \
      -f content="$content" >/dev/null
    echo "  $name: README criado com notice"
  fi

  gh repo archive "$full" --yes >/dev/null
  echo "OK $name (arquivado)"
}

if [[ $# -ge 1 && "$1" != "" ]]; then
  archive_one "$1"
  exit 0
fi

for base in "${BASES[@]}"; do
  for ide in "${IDES[@]}"; do
    archive_one "${base}-${ide}"
  done
done

echo ""
echo "Concluído. Repositórios arquivados em https://github.com/$OWNER"
