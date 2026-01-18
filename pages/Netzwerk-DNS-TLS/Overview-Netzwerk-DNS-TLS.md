page-name:: Netzwerk-DNS-TLS-Overview
# Netzwerk · DNS · TLS – Overview

## Zweck

Dieses Dokument ist der **zentrale Einstiegspunkt** für alle Themen rund um Netzwerk-Namensauflösung, TLS und Reverse-Proxy-Nutzung im HomeLab.

Es definiert die **verbindlichen Leitlinien**, nach denen DNS-Namen vergeben, TLS eingesetzt und Zugriffe auf Services ermöglicht werden.

Dieses Dokument beschreibt **Prinzipien und Abgrenzungen**, keine Implementierungsdetails.

---

## Geltungsbereich

Dieser Ordner regelt:

* das DNS-Namenskonzept (`home.arpa`)
* die Rolle von AdGuard als DNS-Komponente
* den Einsatz von TLS im internen Netz
* die Funktion des Reverse Proxys als zentraler Zugriffspunkt

Die hier beschriebenen Regeln gelten für **alle internen Services**.

---

## Zentrale Leitprinzipien

* DNS benennt **Dienste**, nicht Plattformen oder Backends
* TLS wird **zentral** terminiert
* der Reverse Proxy ist der **einzige TLS-Endpunkt**
* Backends sprechen **ausschließlich HTTP**
* die Control Plane ist von DNS- und TLS-Spielereien ausgenommen

Diese Prinzipien sind **nicht optional**.

---

## Abgrenzung: Control Plane vs. Service Plane

* Control-Plane-Komponenten (z. B. Proxmox, DNS, Router) werden:

  * nicht über den Reverse Proxy geführt
  * nicht mit zentralem TLS versehen
  * nicht kosmetisch „verschönert"

* Service-Plane-Komponenten:

  * werden über den Reverse Proxy erreichbar gemacht
  * nutzen TLS ausschließlich am Proxy

Die Begründungen dazu sind verbindlich dokumentiert.

---

## Dokumente in diesem Ordner

* **Control-Plane-Policy-NPM.md**
  Verbindliche Ausschlussregeln für Control-Plane-Komponenten.

* **Lokales-SSL-home-arpa.md**
  Referenzimplementierung für internes TLS mit mkcert und NGINX Proxy Manager.

* **Neuer-home-arpa-Service.md**
  Standardisiertes Vorgehen zur Einführung neuer `*.home.arpa`-Services.

---

## Änderungsregeln

* Änderungen an DNS- oder TLS-Prinzipien sind selten
* jede Änderung ist architekturwirksam
* Anpassungen müssen konsistent zur Control-Plane-Policy bleiben

Operative Änderungen (z. B. Zertifikatserneuerung) ändern **nicht** die Architektur.

---

## Merksatz

> DNS und TLS sind Infrastruktur – kein Komfortfeature.

---

## Status

* gültig
* verbindlich
* architekturrelevant
