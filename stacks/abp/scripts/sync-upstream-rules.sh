#!/usr/bin/env bash
set -euo pipefail

# Atualiza rules oficiais do cursor-abp-plugin em stacks/abp/rules-upstream/ e .cursor/rules/
#
# Uso:
#   bash stacks/abp/scripts/sync-upstream-rules.sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
STACK="$(cd "$SCRIPT_DIR/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "Clonando abpframework/cursor-abp-plugin..."
git clone --depth 1 https://github.com/abpframework/cursor-abp-plugin.git "$TMP/plugin" >/dev/null

echo "Copiando rules oficiais..."
cp "$TMP/plugin/rules/"*.mdc "$STACK/rules-upstream/"
cp "$TMP/plugin/rules/"*.mdc "$STACK/.cursor/rules/"

# Preservar rules custom do repo-padrao (não vêm do upstream)
echo "Rules custom preservadas: abp-mcp.mdc, abp-ui.mdc, ui-react.mdc"

if [[ -f "$TMP/plugin/.mcp.json" ]]; then
  cp "$TMP/plugin/.mcp.json" "$STACK/.mcp.json.example"
fi

echo "Sync concluído. Revise diff antes de commitar."
