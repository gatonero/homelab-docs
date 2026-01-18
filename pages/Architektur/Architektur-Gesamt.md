# Architektur – Gesamtüberblick (HomeLab)

## Zweck

Dieses Dokument beschreibt die **bewusst getroffenen Architekturentscheidungen** des HomeLabs.
Es beantwortet die Kernfragen:

* Was läuft wo?
* Warum ist es genau so umgesetzt?
* Welche Dinge werden bewusst **nicht** getan?

Es ist **keine Anleitung**, sondern die **architektonische Leitplanke** für Betrieb, Erweiterung und Fehlersuche.

---

## Grundprinzip: Control Plane ≠ Service Plane

Die zentrale Architekturentscheidung ist die **strikte Trennung** zwischen Control Plane und Service Plane.

Diese Trennung ist verbindlich und wird nicht aus Bequemlichkeit aufgeweicht.

---

## Control Plane

### Komponenten

* Proxmox VE (Virtualisierung)
* AdGuard Home (DNS)
* Router / Firewall

### Eigenschaften

* kritisch für den Gesamtbetrieb
* Änderungen nur mit klarer Begründung
* keine kosmetischen Optimierungen
* **kein Reverse Proxy**
* **kein zentrales TLS-Setup**
* **keine Experimente**

**Merksatz:** Die Control Plane wird stabil gehalten, nicht verschönert.

---

## Service Plane

### Komponenten

* NetBox
* Uptime Kuma
* Home Assistant
* Portainer
* QNAP Web-UI
* weitere Web-Services

### Eigenschaften

* Zugriff ausschließlich über Reverse Proxy
* zentrales TLS
* Services sind austauschbar
* Backends sprechen **ausschließlich HTTP**

---

## Zugriff auf Proxmox (bewusst konservativ)

### Ziel

Stabiler, reproduzierbarer Zugriff auf Proxmox **ohne Risiko für Cluster- oder Zertifikatskonsistenz**.

### Umsetzung

DNS-Alias:

`proxmox.home.arpa → 192.168.1.26`

Zugriff:

`https://proxmox.home.arpa:8006`

### Bewusste Entscheidungen

* kein Reverse Proxy vor Proxmox
* keine Änderung von Hostname oder Cluster-Namen
* keine externen oder mkcert-Zertifikate in Proxmox
* kein `pvecm updatecerts`

### Begründung

Proxmox reagiert extrem sensibel auf **Identitätsänderungen** (Hostname, Zertifikate, Cluster-Informationen).
Frühere Versuche führten zu:

* nicht startenden Proxmox-Diensten
* inkonsistentem `/etc/pve`
* Ausfällen der Web-UI

**Regel:** DNS-Alias ja – alles andere nein.

---

## DNS-Konzept (final)

### Grundregel

**DNS benennt Dienste, nicht Plattformen oder Backends.**

DNS zeigt **immer** auf den Reverse Proxy – **nie** direkt auf ein Backend.

### Aktive DNS-Namen

```
uptime.home.arpa              → 192.168.1.63
homepage.home.arpa            → 192.168.1.63
netbox.home.arpa              → 192.168.1.63
homeassistant.home.arpa       → 192.168.1.63
qnap.home.arpa                → 192.168.1.63
portainer-docker-vm.home.arpa → 192.168.1.63
portainer-qnap.home.arpa      → 192.168.1.63
proxmox.home.arpa             → 192.168.1.26
```

### Bewusst nicht verwendet

```
# docker.home.arpa
# docker-qnap.home.arpa
```

Diese Namen würden **Plattformen statt Dienste** benennen und sind daher unerwünscht.

---

## Reverse Proxy & TLS

* Zentraler Reverse Proxy: **NGINX Proxy Manager**
* TLS-Zertifikat: **Wildcard `*.home.arpa` (mkcert)**
* TLS endet **immer** am Proxy
* Backends sprechen **ausschließlich HTTP**

### Sonderfall: QNAP

* QNAP-Web-UI wird bewusst **über den Reverse Proxy** bereitgestellt
* QNAP selbst betreibt **kein HTTPS** für das Web-UI

**Begründung:**

* einheitliches TLS-Modell
* keine Sonderbehandlung einzelner Systeme

---

## Architektur-Merksätze (verbindlich)

* DNS benennt Dienste, nicht Plattformen
* Der Reverse Proxy ist der einzige TLS-Endpunkt
* Backends sprechen nie HTTPS
* Proxmox wird nicht verändert, nur eindeutig benannt
* Im Zweifel: nichts an der Control Plane ändern

---

## Status

* Architektur: stabil und bewusst gewählt
* Abweichungen: dokumentationspflichtig
* Gültigkeit: verbindlich für alle Erweiterungen
