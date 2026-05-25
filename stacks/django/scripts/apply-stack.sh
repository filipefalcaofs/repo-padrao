#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
STACK="$(cd "$SCRIPT_DIR/.." && pwd)"
ROOT="$(cd "$STACK/../.." && pwd)"
TARGET="${1:-$(pwd)}"

echo "Aplicando stack Django..."
mkdir -p "$TARGET/.cursor/rules" "$TARGET/.cursor/skills"
mkdir -p "$TARGET/.claude/skills" "$TARGET/.codex/skills"

cp -R "$STACK/.cursor/rules/." "$TARGET/.cursor/rules/"
for skill in django-development django-drf pytest-django; do
  cp -R "$STACK/.cursor/skills/$skill" "$TARGET/.cursor/skills/"
  cp -R "$STACK/.cursor/skills/$skill" "$TARGET/.claude/skills/"
  cp -R "$STACK/.cursor/skills/$skill" "$TARGET/.codex/skills/"
done

GITIGNORE="$ROOT/docs/templates-linguagem/gitignore-python.txt"
if [[ -f "$GITIGNORE" ]] && ! grep -q "# Django (repo-padrao)" "$TARGET/.gitignore" 2>/dev/null; then
  touch "$TARGET/.gitignore"
  echo -e "\n# Django (repo-padrao stack)" >> "$TARGET/.gitignore"
  cat "$GITIGNORE" >> "$TARGET/.gitignore"
fi

cat > "$TARGET/.django-stack.json" <<EOF
{
  "stack": "django",
  "variant": "django-drf",
  "configured_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF

echo "Stack Django aplicado em: $TARGET"
