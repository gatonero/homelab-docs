# Homelab – Repository Overview

Dieses Repository enthält die **strukturierte, versionierte Dokumentation** meines Homelabs.
Es ist **Git-führend** aufgebaut und **Logseq-kompatibel**.

Die Dokumentation dient:

* der **Reproduzierbarkeit** (Restore, Neuaufbau)
* der **architektonischen Klarheit**
* der **langfristigen Wartbarkeit**
* der Nutzung als **persönliche Wissensbasis (PKM)**

> Alle technischen Beispiele, IP-Adressen, Hostnamen und Konfigurationen
> sind abstrahiert und nicht 1:1 als produktive Umgebung zu verstehen.

---
- ## Zielsetzung
  
  Dieses Repository beantwortet dauerhaft die Fragen:
  
  * Was existiert im Homelab?
  * Warum ist es genau so umgesetzt?
  * Was darf bewusst **nicht** verändert werden?
  * Wie kann das System reproduziert oder wiederhergestellt werden?
  
  Es ist **keine lose Notizensammlung**, sondern eine **bewusst gepflegte technische Referenz**.
  
  ---
- ## Grundprinzipien
  
  * **Git ist die Source of Truth**
  * **Logseq ist Editor und Wissensgraph**
  * **`pages/` enthält alle Inhalte**
  * **Architektur vor Implementierung**
  * **Stabilität vor Komfort**
  * **Dokumentation schlägt Erinnerung**
  
  ---
- ## Repository-Struktur
  
  ```text
  Homelab/
  ├── pages/                   # Alle inhaltlichen Dokumente
  │   ├── Architektur/         # Architektur & Grundentscheidungen
  │   ├── Betrieb/             # Betrieb, Restore, Drills
  │   ├── NetBox/              # NetBox-Arbeitsmodell
  │   ├── Netzwerk-DNS-TLS/    # DNS, TLS, Reverse Proxy
  │   ├── Services/            # Service-spezifische Dokumentation
  │   ├── 00-Overview-Homelab.md
  │   └── README.md            # Einstiegspunkt im Logseq-Graph
  ├── assets/                  # Bilder, Diagramme
  ├── files/                   # Anhänge, Exporte
  ├── .gitignore
  └── README.md                # Dieses Dokument
  ```
  
  ---
- ## Git und Logseq – klare Trennung
  
  | Aspekt              | Git  | Logseq |
  | ------------------- | ---- | ------ |
  | Quelle der Wahrheit | ja   | nein   |
  | Versionierung       | ja   | nein   |
  | Graph / Backlinks   | nein | ja     |
  | Editor              | nein | ja     |
  | Reproduzierbarkeit  | ja   | nein   |
- ### Verbindliche Regeln
  
  * `pages/`, `assets/`, `files/` werden versioniert
  * `logseq/` und `journals/` werden **nie** versioniert
  * Nach Umbenennungen:
  
  * Logseq schließen
  * `logseq/` lokal löschen
  * Logseq neu indexieren
  
  ---
- ## Namens- und Datei-Policy (Kurzfassung)
  
  * Jede Markdown-Datei hat einen **global eindeutigen H1-Titel**
  * Keine mehrfachen gleich benannten Overview-Dateien
  * Ordner-Overviews haben **eindeutige Dateinamen**
  * Dateinamen:
  
  * sprechend
  * ohne Leerzeichen
  * Architektur erklärt **Warum**, nicht **Wie**
  
  Details: `pages/Namenskonvention-und-Datei-Policy.md`
  
  ---
- ## Architektur-Leitlinien (Kurzfassung)
  
  * **Control Plane ≠ Service Plane**
  * Control Plane:
  
  * Proxmox
  * DNS
  * Router
  * kein Reverse Proxy
  * kein zentrales TLS
  * Service Plane:
  
  * Zugriff über Reverse Proxy
  * zentrales TLS
  * austauschbare Services
  
  Referenzen:
  
  * `pages/Architektur/Architektur-Gesamt.md`
  * `pages/Netzwerk-DNS-TLS/Control-Plane-Policy-NPM.md`
  
  ---
- ## Arbeits-Workflow
  
  1. Änderung planen (Architektur / NetBox)
  2. Technisch umsetzen
  3. Dokumentation anpassen
  4. Git committen
- ### Commit-Empfehlung
  
  * kleine, thematisch saubere Commits
  * sprechende Commit-Messages
  
  ---
- ## Backup & Reproduktion
  
  Dieses Repository ist so aufgebaut, dass es:
  
  * lokal
  * auf GitHub
  * auf Gitea oder GitLab
  * read-only gespiegelt
  
  werden kann.
  
  Empfehlung:
  
  * mindestens ein externes Remote
  * keine Abhängigkeit von Logseq-internen Daten
  
  ---
- ## Status
  
  * Struktur: stabil
  * Logseq-Import: konfliktfrei
  * Git-Historie: sauber
  * Erweiterbar: ja
  
  ---
- ## License
  
  This documentation is licensed under the  Creative Commons Attribution-ShareAlike 4.0 International License (CC BY-SA 4.0).  See the LICENSE file for details.
  
  ---
  
  
  **Dieses Repository ist kein Tagebuch.**
  **Es ist eine technische Referenz.**
  
  ---
