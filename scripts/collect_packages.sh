#!/usr/bin/env bash
set -euo pipefail

PRESET="${1:-default}"
GROUPS="${GROUPS:-}"
EXTRA_PACKAGES="${EXTRA_PACKAGES:-}"
REMOVE_PACKAGES="${REMOVE_PACKAGES:-}"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

preset_file="$ROOT_DIR/config/presets/${PRESET}.txt"
if [[ ! -f "$preset_file" ]]; then
  echo "ERROR: preset not found: $preset_file" >&2
  exit 1
fi

pkgs="$(grep -vE '^\s*#|^\s*$' "$preset_file" | tr '\n' ' ')"

# add group packages
for g in $GROUPS; do
  f="$ROOT_DIR/config/groups/${g}.txt"
  if [[ ! -f "$f" ]]; then
    echo "WARN: group not found, skip: $g" >&2
    continue
  fi
  pkgs+=" $(grep -vE '^\s*#|^\s*$' "$f" | tr '\n' ' ')"
done

# extra + remove
pkgs+=" $EXTRA_PACKAGES $REMOVE_PACKAGES"

# normalize spaces
echo "$pkgs" | tr -s ' ' | sed 's/^ *//; s/ *$//'
