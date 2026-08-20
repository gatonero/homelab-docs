
# WordPress elselevy7.org – ChatGPT-Kontext

**Version:** 4.1
**Stand:** 20.08.2026

## Produktivstand

- WordPress 7.1.
- Security Check 2.1.
- JSON-Endpunkt produktiv.
- NGINX Debian-Standard.

## Persistente Homelab-Regeln

### H-001

Kurze und mittlere Dateien vollständig als `cat <<'EOF'`.

### H-002

Kein geöffneter `cat <<'EOF'` ohne abschließendes `EOF`.

### H-003

Keine Platzhalter (`...`) in installierbaren Dateien.

### H-004

Große Skripte modularisieren oder als Datei liefern.

### H-005

Jede technische Antwort verwendet Eye-Catcher:

- 🖥️ ZIELSYSTEM
- 📄 DATEI
- 🛡️ BACKUP
- 🟢 AKTION
- 🔎 PRÜFUNG
- ✅ ERGEBNIS
- ▶️ NÄCHSTER BEFEHL

## Wichtige Pfade

```
/usr/local/sbin/wordpress-security-check.sh
/etc/wordpress-security/
/var/lib/wordpress-security/status.json
/etc/nginx/sites-available/elselevy7.org
```

## Monitoring

Home Assistant und TRMNL lesen ausschließlich den JSON-Endpunkt.
