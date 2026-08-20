# WordPress elselevy7.org – ChatGPT-Kontext

**Version:** 4.0
**Stand:** 20.08.2026

## Infrastruktur

| Komponente | Wert |
|------------|------|
| Host | elselevy7-org.home.arpa |
| NGINX | 1.22 |
| PHP | 8.4-FPM |
| WordPress | 7.1 |

## Verbindliche Konventionen

### Dateibearbeitung

- Immer Backup.
- Immer komplette Datei.
- Immer `cat <<'EOF'`.
- Keine Teil-Patches.

### NGINX

- `sites-available` = Single Source of Truth.
- `sites-enabled` = ausschließlich Symlinks.
- Backups außerhalb von `sites-enabled`.

### Monitoring

JSON-Endpunkt:

```text
https://elselevy7.org/status/wordpress-security.json
```

Liefert den Inhalt von:

```text
/var/lib/wordpress-security/status.json
```

## WordPress Security Check

Produktive Version: 2.1

## Dokumentationsstandard

Technische Antworten beginnen immer mit:

- 🖥️ ZIELSYSTEM
- 📄 DATEI
- 🛡️ BACKUP
- 🟢 AKTION
- 🔎 PRÜFUNG
- ✅ ERGEBNIS
- ▶️ NÄCHSTER BEFEHL
