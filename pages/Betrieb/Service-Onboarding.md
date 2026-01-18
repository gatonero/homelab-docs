# Service-Onboarding – home.arpa

## Zweck

Dieses Dokument beschreibt das **verbindliche Vorgehen** zur Einführung neuer interner Services unter `*.home.arpa`.

Es stellt sicher, dass:

* Architekturprinzipien eingehalten werden
* DNS, Reverse Proxy und TLS konsistent bleiben
* neue Services reproduzierbar und betriebssicher integriert werden

Dieses Dokument ist **prozessual**, nicht technisch-experimentell.

---

## Geltungsbereich

Gilt für **alle neuen Services**, die:

* intern betrieben werden
* über den Reverse Proxy erreichbar sind
* unter `*.home.arpa` veröffentlicht werden

Ausnahmen (z. B. Control Plane) sind **explizit ausgeschlossen** und in der Control-Plane-Policy geregelt.

---

## Verbindliches Onboarding-Modell

Jeder Service wird in **dieser Reihenfolge** eingeführt:

1. Architektur- & Zweckklärung
2. Modellierung in NetBox
3. Technische Bereitstellung (Backend)
4. Reverse Proxy & TLS
5. DNS-Eintrag
6. Validierung
7. Dokumentation & Monitoring

Abweichungen sind **nicht erlaubt**.

---

## 1. Architektur- & Zweckklärung

Vor jeglicher Umsetzung ist festzulegen:

* Zweck des Services
* Rolle:

  * Backend
  * Web-Service
  * Infrastruktur
* Laufzeitumgebung:

  * Docker-VM
  * dedizierte VM
  * NAS
* Kritikalität (produktiv / unterstützend / experimentell)

Ohne klare Antworten wird **kein Service gebaut**.

---

## 2. Modellierung in NetBox

### Application Service anlegen

* **Name:** `<service>-web`, `<service>-api` o. ä.
* **Parent:** tatsächliche VM oder Device
* **Protocol / Port:** interner Backend-Port
* **Beschreibung:** kurzer technischer Zweck

### Kommentare

Mindestens:

* Art des Backends
* Reverse-Proxy-Nutzung
* TLS-Terminierung am Proxy

NetBox ist **Modell**, nicht Logbuch.

---

## 3. Backend bereitstellen

* Service technisch deployen (Docker / VM)
* Erreichbarkeit prüfen über:

  * IP + Port
* Backend **spricht nur HTTP**

Erst bei stabilem Backend geht es weiter.

---

## 4. Reverse Proxy & TLS

* Proxy Host im **NGINX Proxy Manager** anlegen
* Domain: `<service>.home.arpa`
* Scheme: `http`
* Forward Host: Backend-IP
* Forward Port: Backend-Port
* TLS: Wildcard `*.home.arpa`

TLS endet **ausschließlich** am Proxy.

---

## 5. DNS-Eintrag

* DNS Rewrite in AdGuard:

`<service>.home.arpa → IP des Reverse Proxys`

DNS zeigt **niemals** auf das Backend.

---

## 6. Validierung

### Lokal (Backend)

* Service antwortet stabil

### Extern (Client)

* HTTPS erreichbar
* Zertifikat gültig
* Keine Redirect-Loops

Validiert wird **der reale Nutzerpfad**.

---

## 7. Dokumentation & Monitoring

* Service in der Service-Dokumentation erfassen
* Monitoring in Uptime Kuma anlegen
* Architektur-Dokument **nicht** ohne Grund ändern

---

## Häufige Fehler (vermeiden)

* Service bauen ohne NetBox-Modell
* DNS direkt auf Backend zeigen lassen
* HTTPS im Backend aktivieren
* Sonderlösungen außerhalb des Standards

---

## Merksätze

* Architektur zuerst, Technik danach
* DNS benennt Dienste, nicht Plattformen
* TLS endet am Proxy
* Standards sparen Zeit im Betrieb

---

## Status

* verbindlich
* betriebserprobt
* konsistent zur Architektur
