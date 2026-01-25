#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# formatter-phase2-wikilinks.sh
#
# Phase 2 (B2.a):
#   Wiki-Links [[…]] → GitHub-konforme Markdown-Links
#
# Eigenschaften:
#   - --check : read-only, immer Ausgabe
#   - --apply : ersetzt exakt die gefundenen Treffer
#   - KEINE Struktur- oder Inhaltsänderungen
# ============================================================

ROOT="pages"
REPORT="/tmp/phase2-wiki-links.report"
MODE="${1:-}"

if [[ "$MODE" != "--check" && "$MODE" != "--apply" ]]; then
  echo "Usage: $0 --check | --apply"
  exit 1
fi

> "$REPORT"

# ---------- Hilfsfunktionen ----------

normalize_title() {
  echo "$1" \
    | sed 's/–/-/g' \
    | sed 's/  */ /g' \
    | sed 's/ /-/g'
}

resolve_target() {
  local title="$1"
  local norm
  norm="$(normalize_title "$title")"

  mapfile -t matches < <(find "$ROOT" -type f -name "$norm.md")

  if [[ "${#matches[@]}" -eq 0 ]]; then
    echo "ERROR: no match for [[${title}]]" >&2
    return 1
  fi

  if [[ "${#matches[@]}" -gt 1 ]]; then
    echo "ERROR: ambiguous match for [[${title}]]" >&2
    printf '  %s\n' "${matches[@]}" >&2
    return 1
  fi

  echo "/${matches[0]}"
}

# ---------- Scan ----------

echo "Phase 2 Check: Suche nach Wiki-Links [[...]]"

grep -RIn '\[\[[^]]\+\]\]' "$ROOT" | while IFS=: read -r file line text; do
  while [[ "$text" =~ \[\[([^]]+)\]\] ]]; do
    title="${BASH_REMATCH[1]}"
    target="$(resolve_target "$title")" || exit 1

    echo "${file}:${line}" >> "$REPORT"
    echo "  [[${title}]]" >> "$REPORT"
    echo "  -> ${target}" >> "$REPORT"
    echo "" >> "$REPORT"

    text="${text#*\[\[}"
  done
done

# ---------- Check-Modus ----------

if [[ "$MODE" == "--check" ]]; then
  if [[ -s "$REPORT" ]]; then
    cat "$REPORT"
  else
    echo "Keine Wiki-Links gefunden."
  fi
  exit 0
fi

# ---------- Apply-Modus ----------

while read -r line; do
  [[ -z "$line" ]] && continue

  if [[ "$line" =~ ^(.+):([0-9]+)$ ]]; then
    file="${BASH_REMATCH[1]}"
    lineno="${BASH_REMATCH[2]}"

    read -r orig
    read -r arrow
    read -r target

    orig="${orig#  }"
    target="${target#  -> }"

    title="${orig#\[\[}"
    title="${title%\]\]}"

    sed -i "${lineno}s|\[\[${title}\]\]|[\`${title}\`](${target})|" "$file"
  fi
done < "$REPORT"

echo "Phase 2 abgeschlossen. Ersetzte Wiki-Links:"
cat "$REPORT"
