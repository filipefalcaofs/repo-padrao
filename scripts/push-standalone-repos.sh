#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPOS_DIR="$ROOT/repos"
OWNER="filipefalcaofs"
IDES=(cursor claude codex)

# base_id|descrição curta
STACKS=(
  "repo-padrao-base|Agnóstico"
  "repo-padrao-laravel-vue|Laravel Inertia Vue"
  "repo-padrao-laravel-react|Laravel Inertia React"
  "repo-padrao-laravel-svelte|Laravel Inertia Svelte"
  "repo-padrao-jhipster-angular|JHipster Angular"
  "repo-padrao-jhipster-react|JHipster React"
  "repo-padrao-jhipster-vue|JHipster Vue"
  "repo-padrao-abp-angular|ABP Angular"
  "repo-padrao-abp-react|ABP React"
  "repo-padrao-abp-blazor|ABP Blazor"
  "repo-padrao-abp-mvc|ABP MVC"
  "repo-padrao-django|Django DRF"
  "repo-padrao-nestjs|NestJS API"
  "repo-padrao-go-api|Go REST API"
)

ide_label() {
  case "$1" in
    cursor) echo "Cursor" ;;
    claude) echo "Claude Code" ;;
    codex) echo "Codex" ;;
  esac
}

push_repo() {
  local name="$1"
  local desc="$2"
  local dir="$REPOS_DIR/$name"

  if [[ ! -d "$dir" ]]; then
    echo "SKIP $name (pasta ausente)"
    return 0
  fi

  echo ">>> $name"
  cd "$dir"

  if [[ ! -d .git ]]; then
    git init -b main >/dev/null
    git add -A
    git commit -m "chore: template $name" >/dev/null
  else
    git add -A
    if ! git diff --cached --quiet; then
      git commit -m "chore: atualiza template $name" >/dev/null
    fi
  fi

  if gh repo view "$OWNER/$name" >/dev/null 2>&1; then
    if ! git remote get-url origin >/dev/null 2>&1; then
      git remote add origin "https://github.com/$OWNER/$name.git"
    fi
    git fetch origin main 2>/dev/null || true
    if git push -u origin main 2>/dev/null; then
      :
    else
      git push --force origin main
    fi
  else
    gh repo create "$OWNER/$name" \
      --private \
      --description "$desc" \
      --source=. \
      --remote=origin \
      --push
  fi

  echo "OK $name"
}

for entry in "${STACKS[@]}"; do
  IFS='|' read -r base desc <<< "$entry"
  for ide in "${IDES[@]}"; do
    push_repo "${base}-${ide}" "${desc} ($(ide_label "$ide"))"
  done
done

echo ""
echo "Concluído. Repositórios publicados em https://github.com/$OWNER"
