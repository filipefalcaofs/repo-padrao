#!/usr/bin/env bash
set -euo pipefail

# Gera repositórios standalone em repos/ — um clone por stack/variante.
#
# Uso:
#   bash scripts/build-standalone-repos.sh
#   bash scripts/build-standalone-repos.sh --clean
#   bash scripts/build-standalone-repos.sh repo-padrao-laravel-vue

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/repos"

UNIVERSAL_RULES=(
  superpowers.mdc
  idioma.mdc
  comunicacao.mdc
  git.mdc
  docker-publish.mdc
  portugues-gramatica.mdc
)

usage() {
  cat <<'EOF'
Gera repos standalone em repos/ com rules e skills já aplicados.

Uso:
  bash scripts/build-standalone-repos.sh              # todos
  bash scripts/build-standalone-repos.sh --clean      # limpa repos/ antes
  bash scripts/build-standalone-repos.sh NOME         # um repo

Repos gerados:
  repo-padrao-base
  repo-padrao-laravel-vue | -react | -svelte
  repo-padrao-jhipster-angular | -react | -vue
  repo-padrao-abp-angular | -react | -blazor | -mvc
  repo-padrao-django | repo-padrao-nestjs | repo-padrao-go-api  (secundárias)
EOF
}

copy_base() {
  local dest="$1"
  mkdir -p "$dest"

  cp "$ROOT/.editorconfig" "$dest/" 2>/dev/null || true
  cp "$ROOT/.gitignore" "$dest/"
  cp "$ROOT/AGENTS.md" "$dest/"
  cp "$ROOT/CLAUDE.md" "$dest/"
  cp -R "$ROOT/.github" "$dest/"
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
  cat > "$dest/.repo-stack.json" <<EOF
{
  "template_id": "$id",
  "stack": "$stack",
  "variant": "$variant",
  "generated_from": "filipefalcaofs/repo-padrao",
  "generated_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF
}

write_copilot_stack() {
  local dest="$1"
  local stack_line="$2"
  cat > "$dest/.github/copilot-instructions.md" <<EOF
# Instruções para o GitHub Copilot

Fonte de verdade: **[AGENTS.md](../AGENTS.md)**.

## Stack deste template

$stack_line

## Resumo

- pt-BR em textos para humanos; código em inglês
- TDD, Superpowers, debugging sistemático
- Conventional Commits em português
- Decisões em \`docs/brain/3-resources/adrs/\`
EOF
}

build_base() {
  local dest="$OUT/repo-padrao-base"
  echo ">>> repo-padrao-base"
  rm -rf "$dest"
  copy_base "$dest"
  cp "$ROOT/docs/COMO_USAR.md" "$dest/docs/COMO_USAR.md"
  strip_factory_refs "$dest"
  write_stack_json "$dest" "repo-padrao-base" "none" "agnostic"
  write_copilot_stack "$dest" "Agnóstico — escolha um repo \`repo-padrao-<stack>\` se ainda não definiu a stack."
  cat > "$dest/README.md" <<'EOF'
# repo-padrao-base

**Linguagem:** agnóstico (sem stack)

Template com Superpowers, rules universais e segundo cérebro — **sem** rules/skills de framework.

## Quando usar

- Ainda não definiu linguagem ou stack
- Projeto fora das stacks disponíveis (Rust, Ruby, etc.)
- Quer só disciplina de IA (TDD, pt-BR, ADRs)

## Escolheu a stack?

Ver [**docs/CLONAGEM_POR_LINGUAGEM.md**](docs/CLONAGEM_POR_LINGUAGEM.md) — links GitHub de Laravel, JHipster, ABP, Django, NestJS e Go.

## Assistentes

Cursor · Claude Code · Copilot · Codex — ver [`docs/COMO_USAR.md`](docs/COMO_USAR.md) e [`AGENTS.md`](AGENTS.md).
EOF
}

build_laravel() {
  local adapter="$1"
  local id="repo-padrao-laravel-${adapter}"
  local dest="$OUT/$id"
  echo ">>> $id"
  rm -rf "$dest"
  copy_base "$dest"
  bash "$ROOT/stacks/laravel/scripts/apply-stack.sh" "$dest" --adapter "$adapter" --yes
  rm -rf "$dest/.cursor/skills/livewire-development" "$dest/.cursor/skills/tailwindcss-development"
  cp "$ROOT/docs/stacks/LARAVEL.md" "$dest/docs/stacks/LARAVEL.md"
  strip_factory_refs "$dest"
  write_stack_json "$dest" "$id" "laravel" "inertia-${adapter}"
  write_copilot_stack "$dest" "Laravel 12/13 + Inertia **${adapter}** + Laravel Boost (rules/skills/MCP)."
  cat > "$dest/README.md" <<EOF
# ${id}

**Linguagem:** PHP · **Frontend:** Inertia ${adapter}

Template pronto para **Laravel + Inertia (${adapter})** com rules, skills e MCP Laravel Boost.

## Clone

\`\`\`bash
git clone https://github.com/filipefalcaofs/${id}.git meu-app
cd meu-app
rm -rf .git && git init
composer create-project laravel/laravel .
composer require laravel/boost --dev
php artisan boost:install
\`\`\`

Habilitar \`laravel-boost\` no MCP Settings (Cursor). Ver [\`docs/stacks/LARAVEL.md\`](docs/stacks/LARAVEL.md).

## Já incluído

- Superpowers (TDD, brainstorming, debugging)
- Rules: \`laravel-core\`, \`laravel-boost\`, \`laravel-inertia\`
- Skills: \`laravel-best-practices\`, \`laravel-boost\`, \`pest-testing\`, \`inertia-${adapter}-development\`
- \`.laravel-stack.json\` — adapter **${adapter}**

## Assistentes

Cursor, Claude Code, GitHub Copilot, Codex CLI — ver [\`AGENTS.md\`](AGENTS.md).
EOF
  cat > "$dest/docs/COMO_USAR.md" <<EOF
# Como usar — ${id}

1. Clone e \`git init\` (ou Use this template no GitHub).
2. Crie o app Laravel na raiz (\`composer create-project laravel/laravel .\`).
3. \`composer require laravel/boost --dev && php artisan boost:install\`
4. Habilitar MCP \`laravel-boost\` no Cursor.
5. Registrar stack no ADR \`docs/brain/3-resources/adrs/0001-stack-laravel.md\`.

Guia completo: [\`docs/stacks/LARAVEL.md\`](docs/stacks/LARAVEL.md).
EOF
  cat > "$dest/CLAUDE.md" <<EOF
# CLAUDE.md

Stack: **Laravel + Inertia ${adapter}** (PHP). Diretrizes completas em [AGENTS.md](./AGENTS.md).

Skills em \`.claude/skills/\`: \`laravel-best-practices\`, \`laravel-boost\`, \`pest-testing\`, \`inertia-${adapter}-development\`.

Superpowers em \`.cursor/plugins/superpowers/\`.
EOF
}

build_jhipster() {
  local frontend="$1"
  local id="repo-padrao-jhipster-${frontend}"
  local dest="$OUT/$id"
  echo ">>> $id"
  rm -rf "$dest"
  copy_base "$dest"
  bash "$ROOT/stacks/jhipster/scripts/apply-stack.sh" "$dest" --frontend "$frontend" --yes
  cp "$ROOT/docs/stacks/JHIPSTER.md" "$dest/docs/stacks/JHIPSTER.md"
  strip_factory_refs "$dest"
  write_stack_json "$dest" "$id" "jhipster" "$frontend"
  write_copilot_stack "$dest" "JHipster 8+ + frontend **${frontend}** (Spring Boot)."
  cat > "$dest/README.md" <<EOF
# ${id}

**Linguagem:** Java (Spring Boot) · **Frontend:** ${frontend}

Template pronto para **JHipster + ${frontend}**.

## Clone

\`\`\`bash
git clone https://github.com/filipefalcaofs/${id}.git meu-app
cd meu-app
rm -rf .git && git init
npm install -g generator-jhipster
jhipster
\`\`\`

Ver [\`docs/stacks/JHIPSTER.md\`](docs/stacks/JHIPSTER.md).

## Já incluído

- Superpowers + rules universais
- Rules: \`jhipster-core\`, \`jhipster-jdl\`, \`jhipster-frontend\`
- Skills: \`jhipster-development\`, \`jhipster-jdl\`, \`spring-testing\`, \`jhipster-${frontend}-development\`
- \`.jhipster-stack.json\` — frontend **${frontend}**
EOF
  cat > "$dest/CLAUDE.md" <<EOF
# CLAUDE.md

Stack: **JHipster + ${frontend}** (Java). Ver [AGENTS.md](./AGENTS.md).

Skills: \`jhipster-development\`, \`jhipster-jdl\`, \`spring-testing\`, \`jhipster-${frontend}-development\`.
EOF
}

build_abp() {
  local ui="$1"
  local id="repo-padrao-abp-${ui}"
  local dest="$OUT/$id"
  echo ">>> $id"
  rm -rf "$dest"
  copy_base "$dest"
  bash "$ROOT/stacks/abp/scripts/apply-stack.sh" "$dest" --ui "$ui" --yes
  cp "$ROOT/docs/stacks/ABP.md" "$dest/docs/stacks/ABP.md"
  strip_factory_refs "$dest"
  write_stack_json "$dest" "$id" "abp" "$ui"
  write_copilot_stack "$dest" "ABP Framework + UI **${ui}** (rules oficiais cursor-abp-plugin + MCP Studio)."
  local create_cmd
  case "$ui" in
    angular) create_cmd="abp new MeuApp -u ng -d ef" ;;
    react) create_cmd="abp new MeuApp --template app --modern --ui-framework react" ;;
    blazor) create_cmd="abp new MeuApp -u blazor -d ef" ;;
    mvc) create_cmd="abp new MeuApp -u mvc -d ef" ;;
  esac
  cat > "$dest/README.md" <<EOF
# ${id}

**Linguagem:** .NET (C#) · **UI:** ${ui}

Template pronto para **ABP + ${ui}**.

## Clone

\`\`\`bash
git clone https://github.com/filipefalcaofs/${id}.git meu-app
cd meu-app
rm -rf .git && git init
${create_cmd}
\`\`\`

Copiar \`.mcp.json\` já incluído; abrir solution no ABP Studio. Ver [\`docs/stacks/ABP.md\`](docs/stacks/ABP.md).

## Já incluído

- 16 rules oficiais ABP + \`abp-mcp\`, \`abp-ui\`
- UI rule: \`ui-${ui}\`
- \`.abp-stack.json\` — UI **${ui}**
$( [[ "$ui" == "react" ]] && echo "- Skill: \`abp-react-development\`" )
EOF
  cat > "$dest/CLAUDE.md" <<EOF
# CLAUDE.md

Stack: **ABP + ${ui}** (.NET C#). Ver [AGENTS.md](./AGENTS.md).

Rules ABP em \`.cursor/rules/\`.$( [[ "$ui" == "react" ]] && echo " Skill \`abp-react-development\` em \`.claude/skills/\`." )
EOF
}

build_django() {
  local id="repo-padrao-django"
  local dest="$OUT/$id"
  echo ">>> $id"
  rm -rf "$dest"
  copy_base "$dest"
  bash "$ROOT/stacks/django/scripts/apply-stack.sh" "$dest"
  cp "$ROOT/docs/stacks/DJANGO.md" "$dest/docs/stacks/DJANGO.md"
  strip_factory_refs "$dest"
  write_stack_json "$dest" "$id" "django" "drf"
  write_copilot_stack "$dest" "Django + Django REST Framework + pytest-django."
  cat > "$dest/README.md" <<'EOF'
# repo-padrao-django

**Linguagem:** Python

Template pronto para **Django + DRF** (stack secundária).

## Clone

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-django.git meu-app
cd meu-app
rm -rf .git && git init
python -m venv .venv && source .venv/bin/activate
pip install django djangorestframework pytest-django
django-admin startproject config .
```

Ver [`docs/stacks/DJANGO.md`](docs/stacks/DJANGO.md).

## Já incluído

- Rules: `django-core`, `django-drf`
- Skills: `django-development`, `django-drf`, `pytest-django`
- `.django-stack.json`
EOF
  cat > "$dest/CLAUDE.md" <<'EOF'
# CLAUDE.md

Stack: **Django + DRF** (Python). Ver [AGENTS.md](./AGENTS.md).

Skills: `django-development`, `django-drf`, `pytest-django`.
EOF
}

build_nestjs() {
  local id="repo-padrao-nestjs"
  local dest="$OUT/$id"
  echo ">>> $id"
  rm -rf "$dest"
  copy_base "$dest"
  bash "$ROOT/stacks/nestjs/scripts/apply-stack.sh" "$dest"
  cp "$ROOT/docs/stacks/NESTJS.md" "$dest/docs/stacks/NESTJS.md"
  strip_factory_refs "$dest"
  write_stack_json "$dest" "$id" "nestjs" "api"
  write_copilot_stack "$dest" "NestJS API REST (TypeScript) + Jest."
  cat > "$dest/README.md" <<'EOF'
# repo-padrao-nestjs

**Linguagem:** TypeScript (Node.js)

Template pronto para **NestJS API** (stack secundária).

## Clone

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-nestjs.git meu-app
cd meu-app
rm -rf .git && git init
npx @nestjs/cli new . --package-manager npm
```

Ver [`docs/stacks/NESTJS.md`](docs/stacks/NESTJS.md).

## Já incluído

- Rule: `nestjs-core`
- Skills: `nestjs-development`, `nestjs-testing`
- `.nestjs-stack.json`
EOF
  cat > "$dest/CLAUDE.md" <<'EOF'
# CLAUDE.md

Stack: **NestJS API** (TypeScript). Ver [AGENTS.md](./AGENTS.md).

Skills: `nestjs-development`, `nestjs-testing`.
EOF
}

build_go_api() {
  local id="repo-padrao-go-api"
  local dest="$OUT/$id"
  echo ">>> $id"
  rm -rf "$dest"
  copy_base "$dest"
  bash "$ROOT/stacks/go-api/scripts/apply-stack.sh" "$dest"
  cp "$ROOT/docs/stacks/GO.md" "$dest/docs/stacks/GO.md"
  strip_factory_refs "$dest"
  write_stack_json "$dest" "$id" "go-api" "rest"
  write_copilot_stack "$dest" "Go REST API (layout internal/) + testes table-driven."
  cat > "$dest/README.md" <<'EOF'
# repo-padrao-go-api

**Linguagem:** Go

Template pronto para **Go REST API** (stack secundária).

## Clone

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-go-api.git meu-api
cd meu-api
rm -rf .git && git init
go mod init github.com/seu-usuario/meu-api
mkdir -p cmd/api internal/handler internal/service internal/repository
```

Ver [`docs/stacks/GO.md`](docs/stacks/GO.md).

## Já incluído

- Rule: `go-api-core`
- Skills: `go-api-development`, `go-testing`
- `.go-stack.json`
EOF
  cat > "$dest/CLAUDE.md" <<'EOF'
# CLAUDE.md

Stack: **Go API** (Go). Ver [AGENTS.md](./AGENTS.md).

Skills: `go-api-development`, `go-testing`.
EOF
}

build_one() {
  case "$1" in
    repo-padrao-base) build_base ;;
    repo-padrao-laravel-vue) build_laravel vue ;;
    repo-padrao-laravel-react) build_laravel react ;;
    repo-padrao-laravel-svelte) build_laravel svelte ;;
    repo-padrao-jhipster-angular) build_jhipster angular ;;
    repo-padrao-jhipster-react) build_jhipster react ;;
    repo-padrao-jhipster-vue) build_jhipster vue ;;
    repo-padrao-abp-angular) build_abp angular ;;
    repo-padrao-abp-react) build_abp react ;;
    repo-padrao-abp-blazor) build_abp blazor ;;
    repo-padrao-abp-mvc) build_abp mvc ;;
    repo-padrao-django) build_django ;;
    repo-padrao-nestjs) build_nestjs ;;
    repo-padrao-go-api) build_go_api ;;
    *) echo "Repo desconhecido: $1" >&2; exit 1 ;;
  esac
}

build_all() {
  build_base
  build_laravel vue
  build_laravel react
  build_laravel svelte
  build_jhipster angular
  build_jhipster react
  build_jhipster vue
  build_abp angular
  build_abp react
  build_abp blazor
  build_abp mvc
  build_django
  build_nestjs
  build_go_api
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

cat > "$OUT/README.md" <<'EOF'
# Templates gerados (`repos/`)

Cópias locais dos **14 repositórios standalone**, produzidas por `bash scripts/build-standalone-repos.sh`.

> **Para iniciar um projeto**, clone no GitHub — não use esta pasta como destino final. Guia: [**docs/CLONAGEM_POR_LINGUAGEM.md**](../docs/CLONAGEM_POR_LINGUAGEM.md).

## Catálogo (links GitHub)

| Repositório | Linguagem | Clone |
|---|---|---|
| [repo-padrao-base](https://github.com/filipefalcaofs/repo-padrao-base) | Agnóstico | Sem stack — Superpowers + brain |
| [repo-padrao-laravel-vue](https://github.com/filipefalcaofs/repo-padrao-laravel-vue) | PHP | Laravel + Inertia Vue |
| [repo-padrao-laravel-react](https://github.com/filipefalcaofs/repo-padrao-laravel-react) | PHP | Laravel + Inertia React |
| [repo-padrao-laravel-svelte](https://github.com/filipefalcaofs/repo-padrao-laravel-svelte) | PHP | Laravel + Inertia Svelte |
| [repo-padrao-jhipster-angular](https://github.com/filipefalcaofs/repo-padrao-jhipster-angular) | Java | JHipster + Angular |
| [repo-padrao-jhipster-react](https://github.com/filipefalcaofs/repo-padrao-jhipster-react) | Java | JHipster + React |
| [repo-padrao-jhipster-vue](https://github.com/filipefalcaofs/repo-padrao-jhipster-vue) | Java | JHipster + Vue |
| [repo-padrao-abp-angular](https://github.com/filipefalcaofs/repo-padrao-abp-angular) | .NET (C#) | ABP + Angular |
| [repo-padrao-abp-react](https://github.com/filipefalcaofs/repo-padrao-abp-react) | .NET (C#) | ABP + React |
| [repo-padrao-abp-blazor](https://github.com/filipefalcaofs/repo-padrao-abp-blazor) | .NET (C#) | ABP + Blazor |
| [repo-padrao-abp-mvc](https://github.com/filipefalcaofs/repo-padrao-abp-mvc) | .NET (C#) | ABP + MVC |
| [repo-padrao-django](https://github.com/filipefalcaofs/repo-padrao-django) | Python | Django + DRF |
| [repo-padrao-nestjs](https://github.com/filipefalcaofs/repo-padrao-nestjs) | TypeScript | NestJS API |
| [repo-padrao-go-api](https://github.com/filipefalcaofs/repo-padrao-go-api) | Go | Go REST API |

## Regenerar (mantenedores)

```bash
bash scripts/build-standalone-repos.sh --clean
bash scripts/push-standalone-repos.sh
```

Ver [**docs/MANUTENCAO.md**](../docs/MANUTENCAO.md).
EOF

echo ""
echo "Concluído. Repositórios em: $OUT"
