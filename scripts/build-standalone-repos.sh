#!/usr/bin/env bash
set -euo pipefail

# Gera repositórios standalone em repos/ — um clone por stack + IDE (cursor|claude|codex).
#
# Uso:
#   bash scripts/build-standalone-repos.sh
#   bash scripts/build-standalone-repos.sh --clean
#   bash scripts/build-standalone-repos.sh repo-padrao-laravel-vue-cursor

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/repos"
IDES=(cursor claude codex)

UNIVERSAL_RULES=(
  superpowers.mdc
  idioma.mdc
  comunicacao.mdc
  git.mdc
  docker-publish.mdc
  portugues-gramatica.mdc
  entrega-funcional.mdc
  parametrizacao.mdc
)

usage() {
  cat <<'EOF'
Gera repos standalone em repos/ — suffix -cursor, -claude ou -codex.

Uso:
  bash scripts/build-standalone-repos.sh              # todos (42 repos)
  bash scripts/build-standalone-repos.sh --clean      # limpa repos/ antes
  bash scripts/build-standalone-repos.sh NOME         # um repo

Exemplos:
  repo-padrao-base-cursor
  repo-padrao-laravel-vue-claude
  repo-padrao-abp-angular-codex
EOF
}

ide_label() {
  case "$1" in
    cursor) echo "Cursor" ;;
    claude) echo "Claude Code" ;;
    codex) echo "Codex" ;;
    *) echo "$1" ;;
  esac
}

ide_entrypoint() {
  case "$1" in
    cursor) echo '`.cursor/rules/`, `.cursor/skills/`, `.cursor/plugins/superpowers/`' ;;
    claude) echo '`CLAUDE.md`, `.claude/skills/`' ;;
    codex) echo '`AGENTS.md`, `.codex/skills/`' ;;
  esac
}

superpowers_skills_dir() {
  find "$ROOT/.cursor/plugins/superpowers" -type d -name skills 2>/dev/null | head -1
}

copy_superpowers_skills_to() {
  local target_skills="$1"
  local skills_root
  skills_root="$(superpowers_skills_dir)"
  [[ -n "$skills_root" && -d "$skills_root" ]] || return 0
  mkdir -p "$target_skills"
  local skill_path
  for skill_path in "$skills_root"/*/; do
    [[ -f "${skill_path}SKILL.md" ]] || continue
    cp -R "$skill_path" "$target_skills/"
  done
}

copy_base() {
  local dest="$1"
  mkdir -p "$dest"

  cp "$ROOT/.editorconfig" "$dest/" 2>/dev/null || true
  cp "$ROOT/.gitignore" "$dest/"
  cp "$ROOT/AGENTS.md" "$dest/"
  cp "$ROOT/CLAUDE.md" "$dest/"
  mkdir -p "$dest/docs/brain" "$dest/docs/stacks"
  cp -R "$ROOT/docs/brain/." "$dest/docs/brain/"
  cp -R "$ROOT/docs/templates-linguagem" "$dest/docs/"
  cp "$ROOT/docs/CLONAGEM_POR_LINGUAGEM.md" "$dest/docs/"
  cp "$ROOT/docs/README.md" "$dest/docs/"
  cp "$ROOT/docs/MANUTENCAO.md" "$dest/docs/"

  mkdir -p "$dest/.cursor/rules" "$dest/.cursor/skills" "$dest/.cursor/plugins"
  cp -R "$ROOT/.cursor/plugins/superpowers" "$dest/.cursor/plugins/"

  if [[ -d "$ROOT/.cursor/skills-cursor" ]]; then
    cp -R "$ROOT/.cursor/skills-cursor" "$dest/.cursor/"
  fi

  for rule in "${UNIVERSAL_RULES[@]}"; do
    if [[ -f "$ROOT/.cursor/rules/$rule" ]]; then
      cp "$ROOT/.cursor/rules/$rule" "$dest/.cursor/rules/"
    fi
  done

  mkdir -p "$dest/.claude/skills" "$dest/.codex/skills"
}

finalize_ide() {
  local dest="$1"
  local ide="$2"

  case "$ide" in
    cursor)
      rm -rf "$dest/.claude" "$dest/.codex" "$dest/CLAUDE.md" "$dest/AGENTS.md"
      ;;
    claude)
      copy_superpowers_skills_to "$dest/.claude/skills"
      rm -rf "$dest/.cursor" "$dest/.codex" "$dest/AGENTS.md" "$dest/.mcp.json"
      ;;
    codex)
      copy_superpowers_skills_to "$dest/.codex/skills"
      rm -rf "$dest/.cursor" "$dest/.claude" "$dest/CLAUDE.md" "$dest/.mcp.json"
      ;;
    *)
      echo "IDE inválida: $ide" >&2
      exit 1
      ;;
  esac
}

write_claude_md() {
  local dest="$1"
  local title="$2"
  local skills_line="$3"
  cat > "$dest/CLAUDE.md" <<EOF
# CLAUDE.md

${title}

${skills_line}

$(cat "$ROOT/docs/templates/CLAUDE-universal.md")
EOF
}

strip_factory_refs() {
  local dest="$1"
  local f
  while IFS= read -r f; do
    [[ -f "$f" ]] || continue
    perl -pi -e '
      s/Antigravity \(Google\), //g;
      s/, Antigravity \(Google\)//g;
      s/Antigravity \(Google\)//g;
      s/, Antigravity, /, /g;
      s/Antigravity, //g;
      s/, Antigravity//g;
    ' "$f"
  done < <(find "$dest" -name '*.md' -type f 2>/dev/null)
}

write_stack_json() {
  local dest="$1"
  local id="$2"
  local stack="$3"
  local variant="$4"
  local ide="$5"
  cat > "$dest/.repo-stack.json" <<EOF
{
  "template_id": "$id",
  "stack": "$stack",
  "variant": "$variant",
  "ide": "$ide",
  "generated_from": "filipefalcaofs/repo-padrao",
  "generated_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF
}

build_base() {
  local ide="$1"
  local id="repo-padrao-base-${ide}"
  local dest="$OUT/$id"
  echo ">>> $id"
  rm -rf "$dest"
  copy_base "$dest"
  cp "$ROOT/docs/COMO_USAR.md" "$dest/docs/COMO_USAR.md"
  finalize_ide "$dest" "$ide"
  strip_factory_refs "$dest"
  write_stack_json "$dest" "$id" "none" "agnostic" "$ide"
  if [[ "$ide" == "claude" ]]; then
    write_claude_md "$dest" "Template **agnóstico** — sem stack de framework." "Skills Superpowers em \`.claude/skills/\`."
  fi
  cat > "$dest/README.md" <<EOF
# ${id}

**IDE:** $(ide_label "$ide") · **Linguagem:** agnóstico (sem stack)

Superpowers, segundo cérebro e configuração **somente para $(ide_label "$ide")**.

## Entrada da IDE

$(ide_entrypoint "$ide")

## Escolheu a stack?

Ver [**docs/CLONAGEM_POR_LINGUAGEM.md**](docs/CLONAGEM_POR_LINGUAGEM.md).
EOF
}

build_laravel() {
  local adapter="$1"
  local ide="$2"
  local id="repo-padrao-laravel-${adapter}-${ide}"
  local dest="$OUT/$id"
  local mcp_note=""
  [[ "$ide" == "cursor" ]] && mcp_note=$'\n\nHabilitar `laravel-boost` no MCP Settings (Cursor).'

  echo ">>> $id"
  rm -rf "$dest"
  copy_base "$dest"
  bash "$ROOT/stacks/laravel/scripts/apply-stack.sh" "$dest" --adapter "$adapter" --yes
  rm -rf "$dest/.cursor/skills/livewire-development" "$dest/.cursor/skills/tailwindcss-development"
  cp "$ROOT/docs/stacks/LARAVEL.md" "$dest/docs/stacks/LARAVEL.md"
  finalize_ide "$dest" "$ide"
  strip_factory_refs "$dest"
  write_stack_json "$dest" "$id" "laravel" "inertia-${adapter}" "$ide"
  if [[ "$ide" == "claude" ]]; then
    write_claude_md "$dest" "Stack: **Laravel + Inertia ${adapter}** (PHP)." "Skills: \`laravel-best-practices\`, \`laravel-boost\`, \`pest-testing\`, \`inertia-${adapter}-development\`."
  fi
  cat > "$dest/README.md" <<EOF
# ${id}

**IDE:** $(ide_label "$ide") · **Linguagem:** PHP · **Frontend:** Inertia ${adapter}

Template **Laravel + Inertia (${adapter})** — arquivos só para $(ide_label "$ide").

## Clone

\`\`\`bash
git clone https://github.com/filipefalcaofs/${id}.git meu-app
cd meu-app
rm -rf .git && git init
composer create-project laravel/laravel .
composer require laravel/boost --dev
php artisan boost:install
\`\`\`

Ver [\`docs/stacks/LARAVEL.md\`](docs/stacks/LARAVEL.md).${mcp_note}

## Entrada da IDE

$(ide_entrypoint "$ide")
EOF
}

build_jhipster() {
  local frontend="$1"
  local ide="$2"
  local id="repo-padrao-jhipster-${frontend}-${ide}"
  local dest="$OUT/$id"

  echo ">>> $id"
  rm -rf "$dest"
  copy_base "$dest"
  bash "$ROOT/stacks/jhipster/scripts/apply-stack.sh" "$dest" --frontend "$frontend" --yes
  cp "$ROOT/docs/stacks/JHIPSTER.md" "$dest/docs/stacks/JHIPSTER.md"
  finalize_ide "$dest" "$ide"
  strip_factory_refs "$dest"
  write_stack_json "$dest" "$id" "jhipster" "$frontend" "$ide"
  if [[ "$ide" == "claude" ]]; then
    write_claude_md "$dest" "Stack: **JHipster + ${frontend}** (Java)." "Skills: \`jhipster-development\`, \`jhipster-jdl\`, \`spring-testing\`, \`jhipster-${frontend}-development\`."
  fi
  cat > "$dest/README.md" <<EOF
# ${id}

**IDE:** $(ide_label "$ide") · **Linguagem:** Java · **Frontend:** ${frontend}

Template **JHipster + ${frontend}** — arquivos só para $(ide_label "$ide").

## Clone

\`\`\`bash
git clone https://github.com/filipefalcaofs/${id}.git meu-app
cd meu-app
rm -rf .git && git init
npm install -g generator-jhipster
jhipster
\`\`\`

Ver [\`docs/stacks/JHIPSTER.md\`](docs/stacks/JHIPSTER.md).

## Entrada da IDE

$(ide_entrypoint "$ide")
EOF
}

build_abp() {
  local ui="$1"
  local ide="$2"
  local id="repo-padrao-abp-${ui}-${ide}"
  local dest="$OUT/$id"
  local mcp_note=""
  [[ "$ide" == "cursor" ]] && mcp_note=$'\n\nInclui `.mcp.json` — habilitar `abp-studio` no Cursor e abrir a solution no ABP Studio.'

  echo ">>> $id"
  rm -rf "$dest"
  copy_base "$dest"
  bash "$ROOT/stacks/abp/scripts/apply-stack.sh" "$dest" --ui "$ui" --yes
  cp "$ROOT/docs/stacks/ABP.md" "$dest/docs/stacks/ABP.md"
  finalize_ide "$dest" "$ide"
  strip_factory_refs "$dest"
  write_stack_json "$dest" "$id" "abp" "$ui" "$ide"
  local create_cmd
  case "$ui" in
    angular) create_cmd="abp new MeuApp -u ng -d ef" ;;
    react) create_cmd="abp new MeuApp --template app --modern --ui-framework react" ;;
    blazor) create_cmd="abp new MeuApp -u blazor -d ef" ;;
    mvc) create_cmd="abp new MeuApp -u mvc -d ef" ;;
  esac
  if [[ "$ide" == "claude" ]]; then
    local react_skill=""
    [[ "$ui" == "react" ]] && react_skill=" Skill \`abp-react-development\`."
    write_claude_md "$dest" "Stack: **ABP + ${ui}** (.NET C#)." "Skills ABP em \`.claude/skills/\`.${react_skill}"
  fi
  cat > "$dest/README.md" <<EOF
# ${id}

**IDE:** $(ide_label "$ide") · **Linguagem:** .NET (C#) · **UI:** ${ui}

Template **ABP + ${ui}** — arquivos só para $(ide_label "$ide").

## Clone

\`\`\`bash
git clone https://github.com/filipefalcaofs/${id}.git meu-app
cd meu-app
rm -rf .git && git init
${create_cmd}
\`\`\`

Ver [\`docs/stacks/ABP.md\`](docs/stacks/ABP.md).${mcp_note}

## Entrada da IDE

$(ide_entrypoint "$ide")
EOF
}

build_django() {
  local ide="$1"
  local id="repo-padrao-django-${ide}"
  local dest="$OUT/$id"

  echo ">>> $id"
  rm -rf "$dest"
  copy_base "$dest"
  bash "$ROOT/stacks/django/scripts/apply-stack.sh" "$dest"
  cp "$ROOT/docs/stacks/DJANGO.md" "$dest/docs/stacks/DJANGO.md"
  finalize_ide "$dest" "$ide"
  strip_factory_refs "$dest"
  write_stack_json "$dest" "$id" "django" "drf" "$ide"
  if [[ "$ide" == "claude" ]]; then
    write_claude_md "$dest" "Stack: **Django + DRF** (Python)." "Skills: \`django-development\`, \`django-drf\`, \`pytest-django\`."
  fi
  cat > "$dest/README.md" <<EOF
# ${id}

**IDE:** $(ide_label "$ide") · **Linguagem:** Python

Template **Django + DRF** — arquivos só para $(ide_label "$ide").

## Clone

\`\`\`bash
git clone https://github.com/filipefalcaofs/${id}.git meu-app
cd meu-app
rm -rf .git && git init
python -m venv .venv && source .venv/bin/activate
pip install django djangorestframework pytest-django
django-admin startproject config .
\`\`\`

Ver [\`docs/stacks/DJANGO.md\`](docs/stacks/DJANGO.md).

## Entrada da IDE

$(ide_entrypoint "$ide")
EOF
}

build_nestjs() {
  local ide="$1"
  local id="repo-padrao-nestjs-${ide}"
  local dest="$OUT/$id"

  echo ">>> $id"
  rm -rf "$dest"
  copy_base "$dest"
  bash "$ROOT/stacks/nestjs/scripts/apply-stack.sh" "$dest"
  cp "$ROOT/docs/stacks/NESTJS.md" "$dest/docs/stacks/NESTJS.md"
  finalize_ide "$dest" "$ide"
  strip_factory_refs "$dest"
  write_stack_json "$dest" "$id" "nestjs" "api" "$ide"
  if [[ "$ide" == "claude" ]]; then
    write_claude_md "$dest" "Stack: **NestJS API** (TypeScript)." "Skills: \`nestjs-development\`, \`nestjs-testing\`."
  fi
  cat > "$dest/README.md" <<EOF
# ${id}

**IDE:** $(ide_label "$ide") · **Linguagem:** TypeScript (Node.js)

Template **NestJS API** — arquivos só para $(ide_label "$ide").

## Clone

\`\`\`bash
git clone https://github.com/filipefalcaofs/${id}.git meu-app
cd meu-app
rm -rf .git && git init
npx @nestjs/cli new . --package-manager npm
\`\`\`

Ver [\`docs/stacks/NESTJS.md\`](docs/stacks/NESTJS.md).

## Entrada da IDE

$(ide_entrypoint "$ide")
EOF
}

build_go_api() {
  local ide="$1"
  local id="repo-padrao-go-api-${ide}"
  local dest="$OUT/$id"

  echo ">>> $id"
  rm -rf "$dest"
  copy_base "$dest"
  bash "$ROOT/stacks/go-api/scripts/apply-stack.sh" "$dest"
  cp "$ROOT/docs/stacks/GO.md" "$dest/docs/stacks/GO.md"
  finalize_ide "$dest" "$ide"
  strip_factory_refs "$dest"
  write_stack_json "$dest" "$id" "go-api" "rest" "$ide"
  if [[ "$ide" == "claude" ]]; then
    write_claude_md "$dest" "Stack: **Go REST API** (Go)." "Skills: \`go-api-development\`, \`go-testing\`."
  fi
  cat > "$dest/README.md" <<EOF
# ${id}

**IDE:** $(ide_label "$ide") · **Linguagem:** Go

Template **Go REST API** — arquivos só para $(ide_label "$ide").

## Clone

\`\`\`bash
git clone https://github.com/filipefalcaofs/${id}.git meu-api
cd meu-api
rm -rf .git && git init
go mod init github.com/seu-usuario/meu-api
mkdir -p cmd/api internal/handler internal/service internal/repository
\`\`\`

Ver [\`docs/stacks/GO.md\`](docs/stacks/GO.md).

## Entrada da IDE

$(ide_entrypoint "$ide")
EOF
}

build_one() {
  local name="$1"
  local ide="${name##*-}"
  local base="${name%-${ide}}"

  case "$ide" in
    cursor|claude|codex) ;;
    *)
      echo "Repo desconhecido (suffix IDE esperado: -cursor|-claude|-codex): $1" >&2
      exit 1
      ;;
  esac

  case "$base" in
    repo-padrao-base) build_base "$ide" ;;
    repo-padrao-laravel-vue) build_laravel vue "$ide" ;;
    repo-padrao-laravel-react) build_laravel react "$ide" ;;
    repo-padrao-laravel-svelte) build_laravel svelte "$ide" ;;
    repo-padrao-jhipster-angular) build_jhipster angular "$ide" ;;
    repo-padrao-jhipster-react) build_jhipster react "$ide" ;;
    repo-padrao-jhipster-vue) build_jhipster vue "$ide" ;;
    repo-padrao-abp-angular) build_abp angular "$ide" ;;
    repo-padrao-abp-react) build_abp react "$ide" ;;
    repo-padrao-abp-blazor) build_abp blazor "$ide" ;;
    repo-padrao-abp-mvc) build_abp mvc "$ide" ;;
    repo-padrao-django) build_django "$ide" ;;
    repo-padrao-nestjs) build_nestjs "$ide" ;;
    repo-padrao-go-api) build_go_api "$ide" ;;
    *)
      echo "Repo desconhecido: $1" >&2
      exit 1
      ;;
  esac
}

build_all() {
  local ide
  for ide in "${IDES[@]}"; do
    build_base "$ide"
    build_laravel vue "$ide"
    build_laravel react "$ide"
    build_laravel svelte "$ide"
    build_jhipster angular "$ide"
    build_jhipster react "$ide"
    build_jhipster vue "$ide"
    build_abp angular "$ide"
    build_abp react "$ide"
    build_abp blazor "$ide"
    build_abp mvc "$ide"
    build_django "$ide"
    build_nestjs "$ide"
    build_go_api "$ide"
  done
}

write_repos_catalog() {
  cat > "$OUT/README.md" <<'EOF'
# Templates gerados (`repos/`)

Cópias locais dos **42 repositórios standalone** (14 stacks × 3 IDEs), produzidas por `bash scripts/build-standalone-repos.sh`.

> Clone no GitHub com suffix **`-cursor`**, **`-claude`** ou **`-codex`**. Guia: [**docs/CLONAGEM_POR_LINGUAGEM.md**](../docs/CLONAGEM_POR_LINGUAGEM.md).

## Convenção de nome

```
repo-padrao-{stack}-{cursor|claude|codex}
```

Exemplos: `repo-padrao-laravel-vue-cursor`, `repo-padrao-django-claude`, `repo-padrao-base-codex`.

## Stacks (×3 IDEs cada)

| Base do nome | Linguagem | Stack |
|---|---|---|
| `repo-padrao-base` | Agnóstico | Superpowers + brain |
| `repo-padrao-laravel-vue` | PHP | Laravel + Inertia Vue |
| `repo-padrao-laravel-react` | PHP | Laravel + Inertia React |
| `repo-padrao-laravel-svelte` | PHP | Laravel + Inertia Svelte |
| `repo-padrao-jhipster-angular` | Java | JHipster + Angular |
| `repo-padrao-jhipster-react` | Java | JHipster + React |
| `repo-padrao-jhipster-vue` | Java | JHipster + Vue |
| `repo-padrao-abp-angular` | .NET | ABP + Angular |
| `repo-padrao-abp-react` | .NET | ABP + React |
| `repo-padrao-abp-blazor` | .NET | ABP + Blazor |
| `repo-padrao-abp-mvc` | .NET | ABP + MVC |
| `repo-padrao-django` | Python | Django + DRF |
| `repo-padrao-nestjs` | TypeScript | NestJS API |
| `repo-padrao-go-api` | Go | Go REST API |

## Regenerar (mantenedores)

```bash
bash scripts/build-standalone-repos.sh --clean
bash scripts/push-standalone-repos.sh
```

Ver [**docs/MANUTENCAO.md**](../docs/MANUTENCAO.md).
EOF
}

CLEAN=false
TARGET=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --clean) CLEAN=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) TARGET="$1"; shift ;;
  esac
done

mkdir -p "$OUT"
if [[ "$CLEAN" == true ]]; then
  rm -rf "$OUT"/repo-padrao-*
fi

if [[ -n "$TARGET" ]]; then
  build_one "$TARGET"
else
  build_all
fi

write_repos_catalog

echo ""
echo "Concluído. Repositórios em: $OUT"
