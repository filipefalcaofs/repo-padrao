#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPOS_DIR="$ROOT/repos"
OWNER="filipefalcaofs"

descriptions=(
  "repo-padrao-base|Template agnóstico com Superpowers e segundo cérebro"
  "repo-padrao-laravel-vue|Template Laravel + Inertia Vue"
  "repo-padrao-laravel-react|Template Laravel + Inertia React"
  "repo-padrao-laravel-svelte|Template Laravel + Inertia Svelte"
  "repo-padrao-jhipster-angular|Template JHipster + Angular"
  "repo-padrao-jhipster-react|Template JHipster + React"
  "repo-padrao-jhipster-vue|Template JHipster + Vue"
  "repo-padrao-abp-angular|Template ABP + Angular"
  "repo-padrao-abp-react|Template ABP + React modern"
  "repo-padrao-abp-blazor|Template ABP + Blazor"
  "repo-padrao-abp-mvc|Template ABP + MVC"
  "repo-padrao-django|Template Django + DRF"
  "repo-padrao-nestjs|Template NestJS API"
  "repo-padrao-go-api|Template Go REST API"
)

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
    git push -u origin main
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

for entry in "${descriptions[@]}"; do
  IFS='|' read -r name desc <<< "$entry"
  push_repo "$name" "$desc"
done

echo ""
echo "Concluído. Repositórios publicados em https://github.com/$OWNER"
