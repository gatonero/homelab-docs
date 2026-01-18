# 📘 Lokales SSL-Setup mit `home.arpa`

## Zweck

Dieses Dokument beschreibt das **verbindliche und vollständig validierte Setup** für internes HTTPS mit `home.arpa`.
Es basiert auf **mkcert**, **AdGuard DNS** und **NGINX Proxy Manager** und ist mit der Architektur- und Control-Plane-Policy konsistent.

Dieses Dokument ist die **allein gültige Referenzimplementierung**.

## 1. Ziel & Grundprinzipien

### Ziel

* Alle internen Dienste erreichbar unter `https://<dienst>.home.arpa`
* Gültige TLS-Zertifikate ohne öffentliche CAs
* Zentrale TLS-Terminierung
* Reproduzierbar und wartbar

### Verbindliche Prinzipien

* Eine zentrale lokale CA
* TLS endet **immer am Reverse Proxy**
* Backends sprechen **ausschließlich HTTP**
* Keine HTTPS-Zugriffe per IP
* Kein globales HSTS

## 2. Komponentenübersicht

| Komponente          | Aufgabe                      |
| ------------------- | ---------------------------- |
| AdGuard Home        | Lokales DNS (`home.arpa`)    |
| mkcert              | Lokale Root-CA & Zertifikate |
| Debian-VM           | Docker-Host                  |
| NGINX Proxy Manager | TLS-Terminierung & Routing   |
| Docker-Backends     | Anwendungen (HTTP-only)      |
| Clients             | Browser, CLI                 |

## 3. DNS-Konzept (`home.arpa`)

`home.arpa` ist eine **offiziell reservierte interne Zone**.
Die Verwaltung erfolgt über **AdGuard DNS Rewrites**.

`*.home.arpa → 192.168.1.61`

Alle Subdomains zeigen **ausschließlich** auf den Reverse Proxy.
DNS zeigt **niemals** direkt auf ein Backend.

## 4. Zertifikate mit mkcert

### 4.1 Root-CA

* Eine einzige mkcert-CA
* Erzeugung auf dem primären Admin-System

`mkcert -CAROOT`

| Datei          | Zweck                |
| -------------- | -------------------- |
| rootCA.pem     | wird verteilt        |
| rootCA-key.pem | **niemals** kopieren |

### 4.2 Wildcard-Zertifikat

`mkcert "*.home.arpa" home.arpa`

Ergebnis (Beispiel):

* _wildcard.home.arpa+1.pem
* _wildcard.home.arpa+1-key.pem

Import als **Custom Certificate** in **NGINX Proxy Manager**.

### 4.3 Erneuerung von mkcert-Zertifikaten

mkcert-Zertifikate werden **nicht automatisch** erneuert.

**Erneuern wenn:**

* Ablauf < 30 Tage
* Vertrauensprobleme auftreten
* mkcert neu installiert wurde
* Zertifikatsdateien verloren gingen

**Vorgehen:**

1. Neues Zertifikat erzeugen: `mkcert "*.home.arpa" home.arpa`
2. Neues Zertifikat in NPM importieren (Custom Certificate)
3. Proxy Hosts prüfen und Zertifikat neu zuweisen
4. Funktionstest durchführen: `curl -I https://test.home.arpa`

**Root-CA bleibt unverändert**, solange `rootCA-key.pem` existiert.
Eine neue Root-CA erfordert **Client-Re-Onboarding**.

## 5. Reverse Proxy – NGINX Proxy Manager

### 5.1 Grundregeln

* TLS endet am Proxy
* Backends sprechen nur HTTP
* Forward Host ist **immer die Host-IP**
* **Nie 127.0.0.1**
* Fehlerhafte Proxy Hosts werden gelöscht und neu angelegt

### 5.2 Globale Security Header

Pfad im Container:
`/data/nginx/custom/http.conf`

Minimalstandard:

* `add_header X-Frame-Options SAMEORIGIN always;`
* `add_header X-Content-Type-Options nosniff always;`

Kein globales HSTS.

## 6. Test- und Validierungsdienst

### Zweck

Validierung von TLS, Zertifikaten, Routing und Headern.

### Docker-Beispiel

```
services:
  whoami:
    image: traefik/whoami
    ports:
      - "8088:80"
```

### Proxy-Host

| Feld         | Wert           |
| ------------ | -------------- |
| Domain       | test.home.arpa |
| Scheme       | http           |
| Forward Host | 192.168.1.61   |
| Forward Port | 8088           |
| Force SSL    | ja             |
| HSTS         | nein           |

## 7. Client-Onboarding

### Firefox

`mkcert -install`

### Chrome / Chromium (Linux)

* `chrome://settings/certificates`
* Authorities → Import → `rootCA.pem`
* „Zur Identifizierung von Websites vertrauen"
* Browser vollständig neu starten

### curl / CLI (Linux)

```
sudo cp rootCA.pem /usr/local/share/ca-certificates/mkcert-home.crt
sudo update-ca-certificates
```

Test:
`curl -I https://test.home.arpa`

## 8. Standardvorgehen – Neuer Dienst

### DNS

`<dienst>.home.arpa → 192.168.1.61`

### Backend

`ports: 8080:80`

Test:
`curl http://192.168.1.61:8080`

### Proxy Host

* Scheme: http
* Forward Host: 192.168.1.61
* Forward Port: 8080
* Zertifikat: home.arpa wildcard
* Force SSL: ja
* HSTS: nein

## 9. Typische Fehler

| Problem               | Ursache                |
| --------------------- | ---------------------- |
| Zertifikatswarnung    | CA fehlt im Client     |
| 502 Bad Gateway       | Falscher Forward Host  |
| Redirect-Loop         | HTTPS im Backend aktiv |
| Zertifikat abgelaufen | mkcert nicht erneuert  |

## 10. Merksätze

* Eine CA – viele Clients
* TLS endet am Proxy, nie am Backend
* Zertifikate werden **manuell erneuert**
* NPM falsch → löschen, neu anlegen

## Status

* validiert
* stabil
* verbindlich
