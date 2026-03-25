#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

for f in *; do
  [[ -f "$f" ]] || continue

  ext=""
  base="$f"

  # separate extension (only last dot)
  if [[ "$f" == *.* && "$f" != .* ]]; then
    ext=".${f##*.}"
    base="${f%.*}"
  fi

  # lowercase
  base_lc="$(printf '%s' "$base" | tr '[:upper:]' '[:lower:]')"

  # Special: collapse patterns like YYYY-MM-DD -> YYYYMMDD and HH.MM.SS -> HHMMSS
  # Do it on the base (not extension)
  base_lc="$(
    printf '%s' "$base_lc" | sed -E \
      -e 's/([0-9]{4})-([0-9]{2})-([0-9]{2})/\1\2\3/g' \
      -e 's/([0-9]{2})\.([0-9]{2})\.([0-9]{2})/\1\2\3/g'
  )"

  # Replace spaces, dashes, and dots with underscores
  base_clean="$(printf '%s' "$base_lc" | tr ' .-' '___')"

  # Collapse multiple underscores and trim leading/trailing underscores
  base_clean="$(printf '%s' "$base_clean" | sed -E 's/_+/_/g; s/^_+//; s/_+$//')"

  new="${base_clean}${ext}"

  # Skip if unchanged
  [[ "$f" == "$new" ]] && continue

  # Avoid clobbering existing files
  if [[ -e "$new" ]]; then
    echo "SKIP (target exists): '$f' -> '$new'"
    continue
  fi

  echo "RENAME: '$f' -> '$new'"
  mv -- "$f" "$new"
done
