#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# formatter-phase1.sh
#
# Phase 1: Rein mechanische Normalisierung des Formatters
# - korrektes YAML-Frontmatter
# - genau eine H1
# - Navigationszeile unter der H1
# - Pflichtabschnitte erzwingen
#
# KEINE inhaltlichen Änderungen
# KEINE Link-Korrekturen
# ============================================================

ROOT="pages"

# ---------- Hilfsfunktion: Overview-Link je Pfad ----------
overview_link() {
  case "$1" in
    pages/Betrieb/*)
      echo "/pages/Betrieb/Overview-Betrieb.md"
      ;;
    pages/Architektur/*)
      echo "/pages/Architektur/Overview-Architektur.md"
      ;;
    pages/Services/*)
      echo "/pages/Services/Overview-Services.md"
      ;;
    pages/Netzwerk-DNS-TLS/*)
      echo "/pages/Netzwerk-DNS-TLS/Overview-Netzwerk-DNS-TLS.md"
      ;;
    pages/Governance/*)
      echo "/pages/Governance/Dokumentationsprinzipien.md"
      ;;
    pages/NetBox/*)
      echo "/pages/NetBox/Overview-NetBox.md"
      ;;
    pages/Sicherheit/*)
      echo "/pages/Sicherheit/Overview-Sicherheit.md"
      ;;
    pages/Einstieg/*)
      echo "/pages/00-Overview-Homelab.md"
      ;;
    pages/Admin/*)
      echo "/pages/00-Overview-Homelab.md"
      ;;
    pages/*)
      echo "/pages/00-Overview-Homelab.md"
      ;;
    *)
      echo ""
      ;;
  esac
}

# ---------- Schritt 1: Ungueltige '## title:' entfernen ----------
grep -RIl '^## title:' "$ROOT" | while read -r f; do
  sed -i '/^## title:/d' "$f"
done

# ---------- Schritt 2: YAML-Frontmatter aus erster H1 erzeugen ----------
find "$ROOT" -name "*.md" | while read -r f; do
  # Wenn bereits korrektes YAML existiert -> überspringen
  if head -n 3 "$f" | grep -q '^---'; then
    continue
  fi

  awk '
    BEGIN { done=0 }
    NR==1 && $0 ~ /^# / && done==0 {
      title=substr($0,3)
      print "---"
      print "title: \"" title "\""
      print "---"
      print ""
      print $0
      done=1
      next
    }
    { print }
  ' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
done

# ---------- Schritt 3: Navigation unter H1 einsetzen ----------
find "$ROOT" -name "*.md" | while read -r f; do
  nav=$(overview_link "$f")

  # Navigation nur einfügen, wenn noch nicht vorhanden
  if ! grep -q '^← Zurueck zur' "$f"; then
    awk -v nav="$nav" '
      BEGIN { inserted=0 }
      /^# / && inserted==0 {
        print
        print ""
        print "← Zurueck zur [`Overview`](" nav ")"
        inserted=1
        next
      }
      { print }
    ' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
  fi
done

# ---------- Schritt 4: Pflichtabschnitte erzwingen ----------
find "$ROOT" -name "*.md" | while read -r f; do
  grep -q '^## Zweck' "$f" || cat >> "$f" <<'EOF'

---

## Zweck

EOF

  grep -q '^## Abgrenzung' "$f" || cat >> "$f" <<'EOF'

---

## Abgrenzung

EOF

  grep -q '^## Weiterfuehrend' "$f" || cat >> "$f" <<'EOF'

---

## Weiterfuehrend

EOF
done

echo "Formatter Phase 1 abgeschlossen."
