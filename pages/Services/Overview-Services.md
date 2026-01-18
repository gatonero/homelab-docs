page-name:: Services-Overview
# Services – Overview

## Zweck

Dieses Dokument ist der **Einstiegspunkt** für alle servicebezogenen Dokumentationen im HomeLab.

Es beschreibt die **gemeinsamen Regeln, Erwartungen und den Lebenszyklus** aller Services – unabhängig davon, ob sie auf der Docker-VM, auf dem NAS oder auf einer dedizierten VM laufen.

Dieses Dokument ist **normativ**, nicht service-spezifisch.

---

## Geltungsbereich

Der Ordner *Services* umfasst:

* alle dokumentierten Applikations-Services
* deren Einbindung in DNS, Reverse Proxy und TLS
* service-spezifische Besonderheiten, **nicht** die Grundarchitektur

Die hier beschriebenen Regeln gelten für **jeden Service ohne Ausnahme**.

---

## Was ein „Service“ ist

Ein Service ist eine **benutzerseitig erreichbare Anwendung** oder eine klar abgegrenzte Applikationskomponente, die:

* unter einem festen Namen erreichbar ist
* eine definierte Aufgabe erfüllt
* in DNS, Proxy und ggf. Monitoring eingebunden ist

Ein Service ist **kein**:

* Infrastruktur-Baustein (DNS, Proxy, Router)
* temporärer Test ohne Lebenszyklus
* internes Backend ohne Benutzerbezug

---

## Gemeinsame Service-Regeln

Für alle Services gilt:

* jeder Service folgt dem **Service-Onboarding-Prozess**
* DNS-Namen folgen dem Schema `service.home.arpa`
* TLS endet **immer** am Reverse Proxy
* Backends sprechen **ausschließlich HTTP**
* Services sind logisch von Infrastruktur abhängig

Abweichungen sind **nicht erlaubt**, sondern müssen als neue Architekturentscheidung dokumentiert werden.

---

## Lebenszyklus eines Services

Jeder Service durchläuft dieselben Phasen:

1. Planung & Modellierung (NetBox)
2. Technische Bereitstellung
3. Reverse Proxy & TLS
4. DNS-Anbindung
5. Validierung
6. Betrieb & Monitoring
7. Stilllegung oder Migration

Dokumentation begleitet den gesamten Lebenszyklus.

---

## Dokumente in diesem Ordner

* **Jellyfin.md**
  Medienserver mit besonderem Fokus auf Storage- und Berechtigungskonzepte.

* **Paperless-ngx.md**
  Dokumentenmanagement mit Backend- und Proxy-Trennung.

Weitere Services werden nach demselben Muster ergänzt.

---

## Abgrenzung zur Architektur

* Architektur definiert **Regeln und Prinzipien**
* Service-Dokumente beschreiben **konkrete Umsetzungen**

Service-Dokumente dürfen Architektur **nicht verändern**.

---

## Merksatz

> Services sind austauschbar – die Regeln, nach denen sie integriert werden, nicht.

---

## Status

* gültig
* verbindlich
* Grundlage für alle Service-Dokumente
