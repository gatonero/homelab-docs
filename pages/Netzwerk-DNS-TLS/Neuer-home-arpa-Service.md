# Neuer *.home.arpa Service – Standardvorgehen

## Zweck

Dieses Dokument definiert das **verbindliche Standardvorgehen**, um einen neuen internen Service unter `*.home.arpa` **planvoll, konsistent und revisionssicher** einzuführen.

Es gilt für **alle internen Services** und folgt strikt dem etablierten Modell:

> **NetBox (Modell) → Umsetzung (Technik) → Abgleich (NetBox) → Betrieb (Monitoring)**

Abweichungen sind **bewusst zu dokumentieren**, nicht implizit.

---

## Leitprinzip

> **Jeder neue Service folgt demselben Pfad:**
>
> **DNS → Reverse Proxy → Backend**

* DNS ist der **einzige Einstiegspunkt**
* TLS endet **immer** am Reverse Proxy
* Backends sprechen **nur HTTP intern**

Ausnahmen (z. B. Proxmox, externe Cloud-Services) sind explizit zu begründen.

---

## 1. Planungsphase (NetBox – zuerst)

### 1.1 Service fachlich definieren

Vor **jeglicher technischer Umsetzung** sind folgende Fragen zu beantworten:

* Zweck des Services?
* Rolle:

  * Backend
  * Entry-Point
  * Infrastruktur
* Laufzeitumgebung:

  * Docker-VM
  * dedizierte VM
  * NAS
* Kritikalität:

  * produktiv / unterstützend / experimentell

> **Wenn diese Punkte nicht klar sind, wird der Service nicht gebaut.**

---

### 1.2 Application Service in NetBox anlegen

**Pfad:** `IPAM → Application Services → Add`

**Pflichtfelder:**

* **Name**
  Schema:

  * `<service>-web`
  * `<service>-api`
  * `<service>-dns`

  Beispiel:

  * `paperless-web`

* **Parent**
  VM oder Device, auf dem der Service tatsächlich läuft

* **Protocol / Port**
  Interner Backend-Port (meist TCP)

* **Description**
  Kurzer, technischer Einzeiler (englisch)

**Explizit noch nicht setzen:**

* DNS-Einträge
* HTTPS-Ports
* Zertifikate

---

### 1.3 Architektur-Kommentare (NetBox)

Empfohlenes Grundgerüst:

```
### Backend Service
- Internal application backend
- HTTP-only service

### Reverse Proxy Integration
- Exposed via NGINX Proxy Manager
- TLS terminated at proxy
```

> Kommentare erklären **Warum**, nicht **Wie**.

---

## 2. Umsetzungsphase (Technik)

### 2.1 Backend deployen

* Service starten (Docker / VM / Container)
* Zugriff testen über:

  * **IP + Port**
* Sicherstellen:

  * Service läuft stabil
  * **kein TLS** auf dem Backend

> Erst ein stabiles Backend rechtfertigt den nächsten Schritt.

---

### 2.2 Reverse Proxy konfigurieren (Nginx Proxy Manager)

**Neuer Proxy Host:**

* **Domain:** `service.home.arpa`
* **Scheme:** `http`
* **Forward Hostname/IP:** Backend-IP
* **Forward Port:** Backend-Port

**TLS:**

* internes Zertifikat
* TLS-Terminierung ausschließlich am Proxy

---

### 2.3 DNS-Eintrag setzen

**DNS Rewrite (intern):**

```
service.home.arpa → <IP des Reverse Proxys>
```

**Verbindliche Regeln:**

* DNS zeigt **niemals** direkt auf das Backend
* keine CNAME-Ketten

---

## 3. Abgleichphase (NetBox finalisieren)

### 3.1 NetBox-Service prüfen

* Port korrekt?
* Rolle korrekt?
* Beschreibung vollständig?

Bei Bedarf:

* Kommentar ergänzen
* Zweck präzisieren

---

### 3.2 Optionale Tags

Nur setzen, wenn sie operativ genutzt werden:

* `backend`
* `infrastructure`
* `internal`

Keine kosmetischen Tags.

---

## 4. Betriebsphase

### 4.1 Monitoring anlegen (Uptime Kuma)

* **Check-URL:** `https://service.home.arpa`
* **Typ:** HTTPS
* **TLS-Fehler ignorieren:** ja (interne Zertifikate)

> Monitoring prüft immer den **realen Nutzerpfad**.

---

### 4.2 Architektur-Review

Frage:

> Hat dieser Service ein Grundprinzip verändert?

* **Nein:** keine Aktion
* **Ja:** `Architektur-Gesamt.md` aktualisieren

---

## 5. Häufige Fehler (verbindlich vermeiden)

* ❌ Service technisch bauen, bevor er modelliert ist
* ❌ DNS direkt auf das Backend zeigen lassen
* ❌ TLS auf dem Backend aktivieren
* ❌ NetBox als Logbuch missbrauchen

---

## 6. Kurzfassung (Checkliste)

* Service in NetBox **modellieren**
* Backend **bauen & testen**
* Reverse Proxy konfigurieren
* DNS-Record setzen
* NetBox **abgleichen**
* Monitoring aktivieren

> **Saubere Planung eliminiert 90 % späterer Fehler.**

---

## Status

**Dieses Vorgehen ist verbindlich für alle neuen `*.home.arpa` Services.**
