#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
STACK="$(cd "$SCRIPT_DIR/.." && pwd)"
ROOT="$(cd "$STACK/../.." && pwd)"
TARGET="${1:-$(pwd)}"

echo "Aplicando stack Go API..."
mkdir -p "$TARGET/.cursor/rules" "$TARGET/.cursor/skills"
mkdir -p "$TARGET/.claude/skills" "$TARGET/.codex/skills"

cp -R "$STACK/.cursor/rules/." "$TARGET/.cursor/rules/"
for skill in go-api-development go-testing; do
  cp -R "$STACK/.cursor/skills/$skill" "$TARGET/.cursor/skills/"
  cp -R "$STACK/.cursor/skills/$skill" "$TARGET/.claude/skills/"
  cp -R "$STACK/.cursor/skills/$skill" "$TARGET/.codex/skills/"
done

GITIGNORE="$ROOT/docs/templates-linguagem/gitignore-go.txt"
if [[ -f "$GITIGNORE" ]] && ! grep -q "# Go API (repo-padrao)" "$TARGET/.gitignore" 2>/dev/null; then
  touch "$TARGET/.gitignore"
  echo -e "\n# Go API (repo-padrao stack)" >> "$TARGET/.gitignore"
  cat "$GITIGNORE" >> "$TARGET/.gitignore"
fi

cat > "$TARGET/.go-stack.json" <<EOF
{
  "stack": "go-api",
  "variant": "rest",
  "configured_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF

echo "Stack Go API aplicado em: $TARGET"
