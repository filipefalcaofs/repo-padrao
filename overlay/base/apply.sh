#!/usr/bin/env bash
set -euo pipefail

# Aplica o overlay base do repo-padrao em um projeto (criado pelo aiox-core ou existente).
#
# Copia para o destino, a partir das fontes na raiz do meta-repo:
#   - Rules universais (.cursor/rules/*.mdc)
#   - Plugin Superpowers (.cursor/plugins/superpowers/) + skills para .claude/ e .codex/
#   - Skills internas Cursor (.cursor/skills-cursor/)
#   - Segundo cérebro (docs/brain/)
#   - Templates de .gitignore por linguagem (docs/templates-linguagem/)
#   - AGENTS.md e CLAUDE.md (cria ou anexa com marcadores — preserva conteúdo do aiox-core)
#   - .editorconfig e bloco universal no .gitignore
#
# Uso:
#   bash overlay/base/apply.sh /caminho/do/projeto

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

MARKER_BEGIN="<!-- repo-padrao:inicio -->"
MARKER_END="<!-- repo-padrao:fim -->"

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
  echo "Uso: bash overlay/base/apply.sh /caminho/do/projeto"
}

TARGET="${1:-}"
if [[ -z "$TARGET" || "$TARGET" == "-h" || "$TARGET" == "--help" ]]; then
  usage
  [[ -z "$TARGET" ]] && exit 1 || exit 0
fi

mkdir -p "$TARGET"
TARGET="$(cd "$TARGET" && pwd)"

if [[ "$TARGET" == "$ROOT" ]]; then
  echo "Erro: o destino não pode ser o próprio meta-repo ($ROOT)" >&2
  exit 1
fi

echo "Aplicando overlay base do repo-padrao..."
echo "  Origem:  $ROOT"
echo "  Destino: $TARGET"

# --- Rules universais (Cursor) -----------------------------------------------
mkdir -p "$TARGET/.cursor/rules"
for rule in "${UNIVERSAL_RULES[@]}"; do
  if [[ -f "$ROOT/.cursor/rules/$rule" ]]; then
    cp "$ROOT/.cursor/rules/$rule" "$TARGET/.cursor/rules/"
  fi
done
echo "  Rules universais copiadas para .cursor/rules/"

# --- Plugin Superpowers -------------------------------------------------------
if [[ -d "$ROOT/.cursor/plugins/superpowers" ]]; then
  mkdir -p "$TARGET/.cursor/plugins"
  rm -rf "$TARGET/.cursor/plugins/superpowers"
  cp -R "$ROOT/.cursor/plugins/superpowers" "$TARGET/.cursor/plugins/"
  echo "  Plugin Superpowers copiado para .cursor/plugins/"
fi

# --- Skills internas Cursor ---------------------------------------------------
if [[ -d "$ROOT/.cursor/skills-cursor" ]]; then
  rm -rf "$TARGET/.cursor/skills-cursor"
  cp -R "$ROOT/.cursor/skills-cursor" "$TARGET/.cursor/"
  echo "  Skills internas copiadas para .cursor/skills-cursor/"
fi

# --- Skills Superpowers para Claude Code e Codex ------------------------------
SP_SKILLS="$(find "$ROOT/.cursor/plugins/superpowers" -type d -name skills 2>/dev/null | head -1 || true)"
if [[ -n "$SP_SKILLS" && -d "$SP_SKILLS" ]]; then
  mkdir -p "$TARGET/.claude/skills" "$TARGET/.codex/skills"
  for skill_path in "$SP_SKILLS"/*/; do
    [[ -f "${skill_path}SKILL.md" ]] || continue
    skill_dir="${skill_path%/}"
    skill_name="$(basename "$skill_dir")"
    rm -rf "$TARGET/.claude/skills/$skill_name" "$TARGET/.codex/skills/$skill_name"
    cp -R "$skill_dir" "$TARGET/.claude/skills/"
    cp -R "$skill_dir" "$TARGET/.codex/skills/"
  done
  echo "  Skills Superpowers copiadas para .claude/skills/ e .codex/skills/"
fi

# --- Segundo cérebro (docs/brain/) --------------------------------------------
mkdir -p "$TARGET/docs/brain"
cp -R "$ROOT/docs/brain/." "$TARGET/docs/brain/"
echo "  Segundo cérebro copiado para docs/brain/"

# --- Templates de .gitignore por linguagem ------------------------------------
if [[ -d "$ROOT/docs/templates-linguagem" ]]; then
  mkdir -p "$TARGET/docs/templates-linguagem"
  cp -R "$ROOT/docs/templates-linguagem/." "$TARGET/docs/templates-linguagem/"
  echo "  Templates de .gitignore copiados para docs/templates-linguagem/"
fi

# --- .editorconfig (não sobrescreve) ------------------------------------------
if [[ -f "$ROOT/.editorconfig" && ! -f "$TARGET/.editorconfig" ]]; then
  cp "$ROOT/.editorconfig" "$TARGET/"
  echo "  .editorconfig criado"
fi

# --- .gitignore universal (anexa com marcador, idempotente) -------------------
if ! grep -q "# repo-padrao (base universal)" "$TARGET/.gitignore" 2>/dev/null; then
  touch "$TARGET/.gitignore"
  {
    echo ""
    echo "# repo-padrao (base universal)"
    cat "$ROOT/.gitignore"
  } >> "$TARGET/.gitignore"
  echo "  Bloco universal anexado ao .gitignore"
fi

# --- AGENTS.md (cria ou anexa — preserva conteúdo do aiox-core) ---------------
if [[ -f "$TARGET/AGENTS.md" ]] && grep -qF "$MARKER_BEGIN" "$TARGET/AGENTS.md"; then
  echo "  AGENTS.md já contém o bloco repo-padrao (pulado)"
elif [[ -f "$TARGET/AGENTS.md" ]]; then
  {
    echo ""
    echo "---"
    echo ""
    echo "$MARKER_BEGIN"
    echo ""
    cat "$ROOT/AGENTS.md"
    echo ""
    echo "$MARKER_END"
  } >> "$TARGET/AGENTS.md"
  echo "  Convenções repo-padrao anexadas ao AGENTS.md existente"
else
  {
    echo "$MARKER_BEGIN"
    echo ""
    cat "$ROOT/AGENTS.md"
    echo ""
    echo "$MARKER_END"
  } > "$TARGET/AGENTS.md"
  echo "  AGENTS.md criado"
fi

# --- CLAUDE.md (cria ou anexa — preserva conteúdo do aiox-core) ---------------
claude_block() {
  echo "$MARKER_BEGIN"
  echo ""
  echo "## Convenções repo-padrao"
  echo ""
  echo "Fonte de verdade universal: [AGENTS.md](./AGENTS.md)."
  echo ""
  cat "$ROOT/docs/templates/CLAUDE-universal.md"
  echo ""
  echo "$MARKER_END"
}

if [[ -f "$TARGET/CLAUDE.md" ]] && grep -qF "$MARKER_BEGIN" "$TARGET/CLAUDE.md"; then
  echo "  CLAUDE.md já contém o bloco repo-padrao (pulado)"
elif [[ -f "$TARGET/CLAUDE.md" ]]; then
  {
    echo ""
    echo "---"
    echo ""
    claude_block
  } >> "$TARGET/CLAUDE.md"
  echo "  Convenções repo-padrao anexadas ao CLAUDE.md existente"
else
  {
    echo "# CLAUDE.md"
    echo ""
    claude_block
  } > "$TARGET/CLAUDE.md"
  echo "  CLAUDE.md criado"
fi

# --- Metadados ----------------------------------------------------------------
cat > "$TARGET/.repo-padrao.json" <<EOF
{
  "overlay": "base",
  "stack": "none",
  "variant": "none",
  "source": "filipefalcaofs/repo-padrao",
  "applied_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF

echo ""
echo "Overlay base aplicado."
echo ""
echo "Próximo passo: escolher a stack com"
echo "  bash scripts/choose-stack.sh $TARGET"
