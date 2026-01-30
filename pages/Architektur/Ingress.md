---
title: "Ingress & externe Absicherung"
---

## Überblick

Der externe Zugriff auf die Homelab-Services erfolgt ausschließlich über einen dedizierten Ingress-Host (VM 1000).
Ziel ist ein stabiler, nachvollziehbarer und bewusst begrenzter Eintrittspunkt nach außen.

Der aktuelle Stand ist das Ergebnis einer vollständigen Härtung inklusive praktischer Zugriffstests und stellt den eingefrorenen Referenzzustand dar.

---

## Architektur

### Ingress-Host

- Host: VM 1000 (`ci-debian12-base`)
- Rolle: einziger externer Entry Point
- Funktion: Reverse Proxy (nginx) vor der Applikation (WordPress)
- Firewall: nftables, fail-closed

### Netzwerkprinzipien

- Extern erreichbar: TCP 80 / TCP 443
- Administrativer Zugriff (SSH): nur intern
  - LAN
  - WireGuard-Zugriff über die Fritz!Box
- IPv6: nicht verwendet / effektiv ausgeschlossen

---

## Firewall-Status (Referenz)

- INPUT: DROP
- FORWARD: DROP
- OUTPUT: ACCEPT
- Explizite Freigaben:
  - established/related
  - loopback
  - TCP 80 / 443 (extern)
  - TCP 22 (nur 192.168.1.0/24)

Firewall-Regeln sind vollständig per Ansible reproduzierbar und wurden live verifiziert.

---

## nginx & HTTP-Sicherheit

### TLS

- Debian-konforme Standardkonfiguration
- TLS ≥ 1.2
- Keine manuelle Überschreibung von `ssl_*`-Direktiven außerhalb von `nginx.conf`

### Security Header (Ist-Zustand)

- X-Content-Type-Options: nosniff
- Referrer-Policy: strict-origin-when-cross-origin
- X-Frame-Options: SAMEORIGIN (applikationsseitig gesetzt)
- Kein Strict-Transport-Security (HSTS)

#### Begründung

- WordPress setzt Header selbst und überschreibt nginx-seitige Vorgaben
- Ein erzwungener Header-Kampf zwischen Ingress und Applikation wurde bewusst vermieden
- SAMEORIGIN wird als sicher und praxisgerecht akzeptiert
- HSTS ist bewusst nicht erzwungen, um Ingress und Applikation sauber zu trennen

---

## Härtetest – durchgeführte Prüfungen

### Zulässige Zugriffe
- HTTPS-Zugriff auf elselevy7.org: erfolgreich
- HTTP → HTTPS Redirect: korrekt

### Unzulässige Pfade
- /.env, /.git/: 404
- /wp-config.php: kein Inhalt
- /wp-admin: Login erforderlich
- /wp-admin/install.php: Information sichtbar, keine Installation möglich
- /server-status: 403 (Server-Signatur sichtbar, akzeptiert)

### HTTP-Methoden
- TRACE: blockiert (405)
- OPTIONS: beantwortet (200), kein Allow-Leak

---

## Bewusste Akzeptanzen

- Keine Erzwingung von HSTS auf Ingress-Ebene
- X-Frame-Options: SAMEORIGIN statt DENY
- Erreichbarkeit von /wp-admin/install.php mit Statusinformation
- OPTIONS-Anfragen ohne Methoden-Leak
- Sichtbare Backend-Signatur bei abgewiesenen Anfragen

Diese Entscheidungen dienen der Stabilität, Wartbarkeit und Update-Festigkeit des Systems.

---

## Referenzstatus

Der beschriebene Zustand ist:
- technisch verifiziert
- sicherheitsseitig bewertet
- methodisch sauber
- eingefrorener Referenzstand

Änderungen erfolgen nur bei neuen Anforderungen oder nach erneuter Bewertung.
