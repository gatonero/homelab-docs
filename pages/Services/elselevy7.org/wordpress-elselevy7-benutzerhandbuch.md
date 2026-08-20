
# WordPress elselevy7.org – Benutzerhandbuch

**Version:** 4.1
**Stand:** 20.08.2026

## Änderungen Version 4.1

- WordPress 7.1 erfolgreich aktualisiert.
- HTTP-500 nach Update analysiert und behoben.
- `wp-config.php` Rechte dauerhaft auf `root:www-data 640`.
- NGINX auf Debian-Standard (`sites-available` + Symlink in `sites-enabled`) umgestellt.
- JSON-Endpunkt `/status/wordpress-security.json` produktiv.
- Recovery-Prozedur für `wordpress-security-check.sh` ergänzt.
- Homelab-Arbeitsregeln (Eye-Catcher, vollständige `cat <<'EOF'` Dateien).

## Incident: HTTP 500 nach WordPress-Update

### Ursache

`wp-config.php` gehörte `root:root` und war für PHP-FPM nicht lesbar.

### Lösung

```bash
chown root:www-data /var/www/html/wp-config.php
chmod 640 /var/www/html/wp-config.php
```

### Prüfung

```bash
curl -I https://elselevy7.org/
```

Erwartung: `HTTP/2 200`.

## NGINX-Standard

### Verzeichnisstruktur

```
/etc/nginx/
├── sites-available/
│   └── elselevy7.org
├── sites-enabled/
│   └── elselevy7.org -> /etc/nginx/sites-available/elselevy7.org
└── snippets/
```

### Regeln

1. Nur `sites-available` bearbeiten.
2. `sites-enabled` enthält ausschließlich Symlinks.
3. Backups liegen **nicht** in `sites-enabled`.

## JSON-Endpunkt

```
https://elselevy7.org/status/wordpress-security.json
```

Lieferant:

```
/var/lib/wordpress-security/status.json
```

## Recovery `wordpress-security-check.sh`

```bash
cp /usr/local/sbin/wordpress-security-check.sh.v2.1.backup    /usr/local/sbin/wordpress-security-check.sh
chmod 755 /usr/local/sbin/wordpress-security-check.sh
```

## Aktueller Produktivstand

| Komponente | Status |
|------------|--------|
| WordPress | 7.1 |
| PHP | 8.4-FPM |
| NGINX | OK |
| Security Check | Version 2.1 |
| JSON-Endpunkt | HTTP 200 |
