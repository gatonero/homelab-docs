# WordPress elselevy7.org – Betriebs- und Benutzerhandbuch

**Version:** 4.0
**Stand:** 20.08.2026
**Status:** Produktionssystem

## 1. Systemübersicht

| Komponente | Wert |
|------------|------|
| Hostname | elselevy7-org.home.arpa |
| Domain | https://elselevy7.org |
| Betriebssystem | Debian 12 |
| Webserver | NGINX 1.22 |
| PHP | PHP 8.4-FPM |
| WordPress | 7.1 |

## 2. Architektur

- Cloudflare → NGINX → PHP-FPM → WordPress
- JSON-Monitoring-Endpunkt über NGINX.
- Security-Check erzeugt `/var/lib/wordpress-security/status.json`.

## 3. NGINX-Standard

### Verzeichnisstruktur

```text
/etc/nginx/
├── sites-available/
│   └── elselevy7.org
├── sites-enabled/
│   └── elselevy7.org -> /etc/nginx/sites-available/elselevy7.org
└── snippets/
```

### Regeln

1. Änderungen ausschließlich in `sites-available`.
2. `sites-enabled` enthält nur Symlinks.
3. Backups nach `/root/nginx-backups/`.

## 4. Health- und Monitoring-Endpunkte

| URL | Zweck |
|-----|------|
| `/healthz` | NGINX Healthcheck |
| `/status/wordpress-security.json` | Home Assistant / TRMNL / Uptime Kuma |

## 5. WordPress Security Check

Pfad:

```text
/usr/local/sbin/wordpress-security-check.sh
```

JSON-Datei:

```text
/var/lib/wordpress-security/status.json
```

## 6. Standardprüfungen

```bash
/usr/local/sbin/wordpress-security-check.sh
curl -s https://elselevy7.org/status/wordpress-security.json | jq
wp --path=/var/www/html --allow-root core verify-checksums
```

## 7. Backup und Wiederherstellung

Vor jeder Änderung:

```bash
cp DATEI DATEI.backup
```

Danach:

```bash
nginx -t && systemctl reload nginx
```

## 8. Home Assistant Integration

Home Assistant liest ausschließlich den JSON-Endpunkt.

## 9. Homelab-Regeln

- Vollständige Dateien per `cat <<'EOF'`.
- Keine Diffs.
- Keine Platzhalter.
- Eye-Catcher in allen technischen Anleitungen.
