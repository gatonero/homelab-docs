# Proxmox Cluster

**Betriebsreferenz V1.0**

Standardisierter Wartungs- und Update-Workflow des dreiknotigen Proxmox-Clusters des Homelabs.

---

## Zweck

Diese Betriebsreferenz beschreibt den vollständigen produktiven Wartungsprozess des Proxmox-Clusters des Homelabs.

Sie dokumentiert ausschließlich den sicheren Ablauf für Wartung, Aktualisierung, Verifikation und Wiederherstellung des Clusters.

Die Dokumentation beantwortet die Frage:

> Wie wird der Proxmox-Cluster sicher aktualisiert, verifiziert und bei Bedarf zurückgesetzt?

Nicht Bestandteil dieser Referenz sind:

- Update-Erkennung.
- Collector-Implementierung.
- Änderungen an Home-Assistant-Sensoren.
- Änderungen am TRMNL-Update-Aggregator.

---

## Geltungsbereich

Diese Betriebsreferenz gilt für den produktiven Proxmox-Cluster des Homelabs.

### Cluster-Knoten

| Host | Rolle |
|------|------|
| `pve-01` | Infrastruktur-Host (Home Assistant, Netzwerkdienste, produktive Infrastruktur-VMs) |
| `pve-02` | Docker-, KI- und GPU-Host |
| `pve-03` | Dedizierter Quorum-Knoten ohne produktive Workloads |

### Cluster-Eigenschaften

- Drei-Knoten-Proxmox-Cluster.
- Gemeinsames Cluster-Quorum.
- Kein Ceph.
- Gemeinsamer NFS-Storage auf der QNAP TS-464.
- Zusätzliche produktive SMB-Freigabe der QNAP.
- Hostweise Wartung.
- Keine parallelen Host-Updates.
- VM- und LXC-Migrationen nur wenn technisch erforderlich.

---

## Ziel der Wartungsstrategie

Die Wartungsstrategie verfolgt folgende Prioritäten:

1. Erhalt des Cluster-Quorums.
2. Schutz der zentralen Infrastruktur.
3. Minimierung von Risiken durch hostweise Wartung.
4. Vermeidung unnötiger Migrationen.
5. Vollständige Verifikation nach jedem Host.

Temporäre Ausfälle nicht systemrelevanter Dienste sind während eines Host-Neustarts zulässig.

---

## Auslöser (TRMNL-Update-Instanz)

Der Wartungsprozess beginnt ausschließlich aufgrund der zentralen Update-Anzeige des Homelabs.

### Primärer Auslöser

TRMNL zeigt verfügbare Proxmox-Updates an.

### Datenquelle

Die Anzeige stammt nicht aus Proxmox selbst, sondern aus Home Assistant.

Der TRMNL-Bildschirm verwendet ausschließlich den Aggregator-Sensor:

`sensor.proxmox_update_summary`

### Bedeutung

| Anzeige | Bedeutung |
|---------|-----------|
| `0 Updates` | Keine Wartung erforderlich. |
| `1–n Updates` | Wartungsfenster vorbereiten. |
| Mehrere Hosts mit Updates | Hosts nacheinander aktualisieren. |

### Wartungsbeginn

Ein Wartungsfenster wird nur eröffnet, wenn:

- Updates vorhanden sind.
- Backup erfolgreich durchgeführt wurde.
- Keine kritischen Arbeiten im Homelab laufen.

---

## Datenquelle (Collector)

Die Betriebsreferenz verwendet ausschließlich vorhandene Home-Assistant-Collector.

### Verwendete Sensoren

| Sensor | Bedeutung |
|--------|-----------|
| `sensor.pve01_update_count` | Anzahl Updates auf `pve-01`. |
| `sensor.pve02_update_count` | Anzahl Updates auf `pve-02`. |
| `sensor.pve03_update_count` | Anzahl Updates auf `pve-03`. |
| `sensor.proxmox_update_summary` | Zusammenfassung aller Proxmox-Updates. |

### Nicht Bestandteil

Diese Referenz verwendet ausdrücklich keine:

- REST-Abfragen.
- SSH-Scanner.
- zusätzlichen Collector.
- API-Aufrufe zur Update-Erkennung.

---

## Vorbedingungen

Vor jedem Wartungsfenster werden sämtliche Vorbedingungen erfüllt.

Die Wartung beginnt erst nach erfolgreicher Prüfung aller Punkte.

### Checkliste Wartungsfenster

| Prüfung | Erwarteter Zustand |
|---------|--------------------|
| Wartungsfenster definiert | Ja |
| Cluster quorate | Ja |
| Alle drei Cluster-Knoten online | Ja |
| Keine laufenden Backups | Ja |
| Keine laufenden Migrationen | Ja |
| Keine laufenden Replikationen | Ja |
| NFS-Storage erreichbar | Ja |
| SMB-Storage erreichbar | Ja |
| Backup vorhanden | Ja |
| Uptime Kuma ohne kritische Fehler | Ja |

---

## Vorbedingung — Clusterzustand prüfen

Vor Beginn der Wartung wird der Clusterzustand kontrolliert.

### Clusterstatus

Geprüft werden:

- Alle Nodes erreichbar.
- Cluster quorate.
- Keine Warnungen.
- Kein Split-Brain.

### Erwarteter Zustand

- `pve-01` online.
- `pve-02` online.
- `pve-03` online.
- Quorum aktiv.

Erst danach darf ein Host aktualisiert werden.

---

## Vorbedingung — Laufende Aufgaben prüfen

Während produktiver Aufgaben erfolgt keine Hostwartung.

### Es dürfen nicht aktiv sein

- Backup-Jobs.
- Restore-Jobs.
- VM-Migrationen.
- LXC-Migrationen.
- Storage-Migrationen.
- Replikationen.

### Begründung

Ein Neustart eines Hosts darf keine produktive Aufgabe unterbrechen.

---

## Vorbedingung — Backup-Status prüfen

Vor jedem Host-Update existiert ein aktuelles Backup der produktiven Systeme.

### Backup-Richtlinie

Retention des Homelabs:

| Typ | Aufbewahrung |
|------|--------------|
| Last | 3 |
| Daily | 14 |
| Weekly | 8 |
| Monthly | 12 |
| Yearly | 1 |

### Erwarteter Zustand

Der tägliche Backup-Job um **03:00 Uhr** war erfolgreich.

Bei fehlgeschlagenem Backup wird die Wartung verschoben.

---

## Vorbedingung — Storage prüfen

Die QNAP TS-464 stellt zentrale Infrastruktur bereit.

### NFS-Storage

Prüfen:

- Storage `TS-464-nfs` erreichbar.
- Mountpoint vorhanden.
- Schreib-/Lesetest erfolgreich.

### Erwarteter Mountpoint

`/mnt/pve/TS-464-nfs`

### SMB-Storage

Zusätzlich wird die produktive SMB-Freigabe geprüft.

Diese Freigabe wird vom Proxmox-Cluster genutzt und dient produktiven Diensten.

Prüfen:

- SMB-Mount vorhanden.
- Freigabe erreichbar.
- Lesbar.
- Schreibbar (falls vorgesehen).

### Bedeutung

Der SMB-Mount ist Voraussetzung für Dienste innerhalb des Clusters.

Insbesondere nutzt die Docker-VM die Freigabe für Jellyfin.

---

## Vorbedingung — Produktive Dienste erfassen

Vor Beginn wird dokumentiert, welche produktiven Dienste auf dem jeweiligen Host laufen.

### Produktive virtuelle Maschinen

Mindestens dokumentieren:

| VM | Bedeutung |
|----|-----------|
| Home Assistant | Zentrale Hausautomation |
| Docker VM | Docker-Compose-Dienste |
| Paperless VM | Dokumentenmanagement |
| Weitere VMs | Infrastruktur laut Homelab |

### Produktive LXC-Container

Mindestens dokumentieren:

| LXC | Bedeutung |
|-----|-----------|
| AdGuard | DNS |
| Uptime Kuma | Monitoring |
| Weitere Infrastruktur-LXCs | Produktive Infrastruktur |

### Wartungsregel

Nicht systemrelevante Dienste dürfen während des Neustarts kurzzeitig ausfallen.

Beispiele:

- Jellyfin.
- Paperless.
- Komfortdienste.

Infrastruktur besitzt Vorrang.

---

## Vorbedingung — Wartungsreihenfolge festlegen

Der Cluster wird immer in derselben Reihenfolge aktualisiert.

### Verbindliche Reihenfolge

1. `pve-03`
2. `pve-02`
3. `pve-01`

### Begründung

#### pve-03

- Dedizierter Quorum-Knoten.
- Keine produktiven Workloads.
- Geringstes Risiko.

#### pve-02

- Docker.
- KI-/LLM-VMs.
- GPU-Workloads.

#### pve-01

- Home Assistant.
- Infrastruktur.
- Netzwerkdienste.

Der infrastrukturell wichtigste Host wird zuletzt aktualisiert.

---

## Grundregel der Durchführung

Während der Wartung gelten folgende Regeln uneingeschränkt.

### Es wird niemals durchgeführt

- Mehrere Host-Updates gleichzeitig.
- Gleichzeitige Neustarts mehrerer Nodes.
- Ungeplante VM-Migrationen.
- Ungeplante LXC-Migrationen.

### Es wird immer durchgeführt

- Vollständige Verifikation nach jedem Host.
- Erst danach Beginn des nächsten Hosts.

---

## Durchführung


Die Wartung erfolgt ausschließlich hostweise.

Jeder Host wird vollständig aktualisiert, verifiziert und wieder in den Cluster aufgenommen, bevor der nächste Host beginnt.

---

## Wartungsablauf pro Host

Für jeden Cluster-Knoten gilt derselbe Ablauf.

### Standardablauf

1. Clusterzustand unmittelbar vor der Wartung prüfen.
2. Paketlisten aktualisieren.
3. Verfügbare Updates prüfen.
4. Proxmox VE aktualisieren.
5. Kernel- und Firmware-Updates dokumentieren.
6. Host kontrolliert neu starten.
7. Vollständige Verifikation durchführen.
8. Erst danach den nächsten Host aktualisieren.

---

## Wartungsschritt 1 — Clusterzustand unmittelbar vor Hostwartung

Vor jedem einzelnen Host wird erneut geprüft.

### Prüfpunkte

| Prüfung | Erwarteter Zustand |
|--------|--------------------|
| Cluster quorate | Ja |
| Alle übrigen Nodes online | Ja |
| Keine Migration aktiv | Ja |
| Keine Replikation aktiv | Ja |
| Keine Backups aktiv | Ja |
| Storage ohne Warnungen | Ja |

### Entscheidung

Nur wenn sämtliche Prüfpunkte erfüllt sind, beginnt das Update des jeweiligen Hosts.

---

## Wartungsschritt 2 — Paketlisten aktualisieren

### Ziel

Aktuelle Paketinformationen des jeweiligen Hosts laden.

### Erwartung

- Debian-Repositories erreichbar.
- Proxmox-Repositories erreichbar.
- Keine Signaturfehler.
- Keine Paketquellen deaktiviert.

### Ergebnis

Der Host kennt sämtliche verfügbaren Paketversionen.

---

## Wartungsschritt 3 — Verfügbare Updates prüfen

Vor der Installation werden die verfügbaren Updates dokumentiert.

### Dokumentieren

- Anzahl verfügbarer Updates.
- Proxmox-VE-Pakete.
- Debian-Security-Pakete.
- Kernel-Pakete.
- Firmware-Pakete.
- Microcode-Pakete.

### Erwarteter Zustand

Keine Paketkonflikte.

---

## Wartungsschritt 4 — Proxmox VE aktualisieren

### Ziel

Alle produktiven Pakete des Hosts aktualisieren.

### Umfasst

- Proxmox VE.
- Debian Security Updates.
- Bibliotheken.
- Kernel.
- Firmware.
- Microcode.

### Erwarteter Zustand

- Alle Pakete erfolgreich installiert.
- Keine Paketfehler.
- Keine unterbrochene Installation.

---

## Wartungsschritt 5 — Kernel-Updates dokumentieren

Kernel-Updates besitzen besondere Bedeutung.

### Dokumentieren

| Punkt | Dokumentation |
|------|----------------|
| Aktiver Kernel vor Update | Versionsnummer |
| Neuer Kernel | Versionsnummer |
| Neustart erforderlich | Ja/Nein |

### Erwarteter Zustand

Der neue Kernel wird erst nach dem Neustart aktiv.

### Wartungsregel

Kernelwechsel erfolgt ausschließlich über einen kontrollierten Neustart.

---

## Wartungsschritt 6 — Firmware- und Microcode-Updates

Firmware wird ausdrücklich dokumentiert.

### Prüfen

- Intel-Microcode.
- AMD-Microcode.
- Firmwarepakete.
- Initramfs erfolgreich erzeugt.

### Erwarteter Zustand

Keine Warnungen oder Fehler während der Installation.

---

## Wartungsschritt 7 — Kontrollierter Host-Neustart

Nach erfolgreicher Installation erfolgt der Neustart.

### Ziel

Aktivierung:

- neuer Kernel,
- neuer Microcode,
- aktualisierte Systemdienste.

### Während des Neustarts

Der Host darf kurzzeitig offline sein.

Die übrigen Cluster-Knoten bleiben online.

### Clusterregel

Das Cluster muss während des Neustarts weiterhin quorate bleiben.

---

## Wartungsschritt 8 — Host vollständig online abwarten

Nach dem Neustart wird der Host vollständig gestartet.

### Prüfen

- Host per Netzwerk erreichbar.
- Clusterdienst gestartet.
- Storage verbunden.
- Zeit synchronisiert.
- Netzwerkverbindungen aktiv.

### Erst danach

Beginn der vollständigen Verifikation.

---

## Update-Reihenfolge des Homelab-Clusters

Die Reihenfolge ist verbindlich.

| Reihenfolge | Host | Rolle |
|-------------|------|------|
| 1 | `pve-03` | Quorum-Knoten |
| 2 | `pve-02` | Docker- und KI-Host |
| 3 | `pve-01` | Infrastruktur-Host |

---

## Host 1 — pve-03

### Rolle

Dedizierter Quorum-Knoten.

### Eigenschaften

- Keine produktiven VMs.
- Keine produktiven LXCs.
- Unterstützt ausschließlich das Cluster-Quorum.

### Wartungsziel

Das geringste Risiko wird zuerst beseitigt.

### Durchführung

1. Paketlisten aktualisieren.
2. Updates installieren.
3. Kernel dokumentieren.
4. Neustart durchführen.
5. Cluster vollständig verifizieren.

### Erwarteter Zustand

- `pve-03` wieder online.
- Cluster weiterhin quorate.
- Keine Warnungen.

---

## Verifikation nach pve-03

Nach Abschluss werden geprüft:

- `pve-03` online.
- `pve-01` online.
- `pve-02` online.
- Cluster quorate.
- Kein Split-Brain.
- Keine Clusterwarnungen.

Erst danach beginnt die Wartung von `pve-02`.

---

## Host 2 — pve-02

### Rolle

Compute-Host.

### Produktive Aufgaben

- Docker VM.
- KI-/LLM-VMs.
- GPU-Passthrough.
- Rechenintensive Workloads.

### Vor Neustart prüfen

- Docker-VM führt keine kritischen Arbeiten aus.
- KI-Modelle können beendet werden.
- GPU-Workloads sind beendet.

### Durchführung

1. Paketlisten aktualisieren.
2. Updates installieren.
3. Kernel dokumentieren.
4. Neustart durchführen.
5. GPU-Verfügbarkeit prüfen.

---

## Besonderheit pve-02 — Intel iGPU

Die Intel-iGPU wird produktiv genutzt.

### Prüfen nach Neustart

- `/dev/dri` vorhanden.
- Gerät sichtbar.
- GPU-Passthrough weiterhin möglich.
- KI-/LLM-VMs erkennen die GPU.

### Erwarteter Zustand

GPU-Workloads funktionieren unverändert.

---

## Dienste auf pve-02

Während des Neustarts dürfen folgende Dienste kurzzeitig ausfallen.

| Dienst | Temporärer Ausfall zulässig |
|--------|-----------------------------|
| Docker VM | Ja |
| Jellyfin | Ja |
| KI-/LLM-Dienste | Ja |
| Paperless (falls betroffen) | Ja |

### Nicht betroffen

- Clusterquorum.
- Infrastruktur auf `pve-01`.

---

## Verifikation nach pve-02

Prüfen:

- `pve-02` online.
- Cluster vollständig.
- Docker VM gestartet.
- GPU verfügbar.
- NFS erreichbar.
- SMB erreichbar.

Erst danach beginnt die Wartung von `pve-01`.

---

## Host 3 — pve-01

### Rolle

Infrastruktur-Host.

### Produktive Aufgaben

- Home Assistant.
- Netzwerkdienste.
- Infrastruktur-VMs.
- Systemrelevante Dienste.

### Besonderheit

Dieser Host wird zuletzt aktualisiert.

### Begründung

Home Assistant und die zentrale Infrastruktur bleiben möglichst lange verfügbar.

---

## Vor Neustart pve-01

Vor Beginn prüfen:

- Home Assistant betriebsbereit.
- Keine kritischen Automationen.
- Keine laufenden Wartungen.
- Backup vorhanden.

---

## Durchführung pve-01

1. Paketlisten aktualisieren.
2. Updates installieren.
3. Kernel dokumentieren.
4. Neustart durchführen.
5. Infrastruktur vollständig wieder starten.

---

## Erwartete temporäre Auswirkungen

Während des Neustarts von `pve-01` dürfen kurzzeitig ausfallen:

- Home Assistant.
- Zigbee.
- MQTT.
- Dashboards.
- TRMNL.
- Infrastruktur-VMs dieses Hosts.

Diese Ausfälle sind Bestandteil des Wartungsfensters.

---

## Grundregel nach jedem Host

Nach jedem Neustart wird keine weitere Wartung begonnen.

### Verpflichtende Reihenfolge

1. Host online.
2. Cluster verifizieren.
3. Storage verifizieren.
4. Virtuelle Maschinen verifizieren.
5. LXC-Container verifizieren.
6. Home Assistant verifizieren.
7. Monitoring verifizieren.

Nur bei erfolgreicher Verifikation wird der nächste Cluster-Knoten aktualisiert.

---

## Abschluss der Durchführung

Sind alle drei Hosts erfolgreich aktualisiert, beginnt die vollständige Cluster-Verifikation.


## Verifikation

Nach jedem Host-Update erfolgt eine vollständige technische Verifikation.

Erst wenn sämtliche Prüfungen erfolgreich abgeschlossen sind, gilt der Host als wieder produktiv und der nächste Cluster-Knoten darf aktualisiert werden.

---

## Verifikationsprinzip

Die Verifikation erfolgt in einer festen Reihenfolge.

| Reihenfolge | Prüfbereich |
|-------------|-------------|
| 1 | Cluster-Gesundheit |
| 2 | Storage |
| 3 | Virtuelle Maschinen |
| 4 | LXC-Container |
| 5 | Externe Infrastrukturabhängigkeiten |
| 6 | Home Assistant Collector |
| 7 | TRMNL |
| 8 | Uptime Kuma |

Jeder Prüfbereich muss erfolgreich abgeschlossen werden.

---

## Cluster-Verifikation

Der Cluster besitzt höchste Priorität.

### Prüfpunkte

| Prüfung | Erwarteter Zustand |
|---------|--------------------|
| Cluster quorate | Ja |
| Drei Nodes online | Ja |
| Split-Brain | Nein |
| Cluster-Warnungen | Keine |
| Cluster-Services aktiv | Ja |

### Erfolgsbedingung

Der Cluster arbeitet ohne Warnungen und ohne degradierte Nodes.

---

## Cluster-Knoten prüfen

Für jeden Host wird dokumentiert.

| Host | Erwarteter Zustand |
|------|--------------------|
| `pve-01` | Online |
| `pve-02` | Online |
| `pve-03` | Online |

Alle Hosts besitzen wieder Cluster-Mitgliedschaft.

---

## Cluster-Gesundheit dokumentieren

Nach Abschluss der Wartung werden dokumentiert.

### Dokumentieren

- Cluster quorate.
- Anzahl Nodes.
- Keine verlorenen Votes.
- Keine degradierte Mitgliedschaft.
- Keine Rejoin-Probleme.

### Erwarteter Zustand

Der Cluster entspricht dem Zustand vor Beginn des Wartungsfensters.

---

## Storage-Verifikation

Die QNAP TS-464 stellt zentrale Infrastruktur bereit.

Die Storage-Prüfung erfolgt unmittelbar nach der Clusterprüfung.

---

## Verifikation — NFS-Storage

Prüfen:

| Prüfung | Erwarteter Zustand |
|---------|--------------------|
| Storage `TS-464-nfs` sichtbar | Ja |
| Mountpoint vorhanden | Ja |
| Lesbar | Ja |
| Schreibbar | Ja |

### Mountpoint

`/mnt/pve/TS-464-nfs`

### Erfolgsbedingung

Alle Proxmox-Hosts können auf den gemeinsamen NFS-Storage zugreifen.

---

## Verifikation — SMB-Storage

Zusätzlich wird der produktive SMB-Mount geprüft.

### Prüfpunkte

| Prüfung | Erwarteter Zustand |
|---------|--------------------|
| SMB-Freigabe erreichbar | Ja |
| Mount aktiv | Ja |
| Lesen möglich | Ja |
| Schreiben möglich (falls vorgesehen) | Ja |

### Bedeutung

Der SMB-Mount wird produktiv von Diensten innerhalb des Clusters verwendet.

---

## Backup-Storage prüfen

Nach der Wartung wird geprüft.

| Prüfung | Erwarteter Zustand |
|---------|--------------------|
| Backup-Storage sichtbar | Ja |
| Backup-Verzeichnis erreichbar | Ja |
| Backup-Job kann Storage verwenden | Ja |

### Erfolgsbedingung

Die nächtlichen Backup-Jobs können unverändert ausgeführt werden.

---

## Virtuelle Maschinen verifizieren

Alle produktiven VMs werden kontrolliert.

---

## Home Assistant VM

### Prüfpunkte

| Prüfung | Erwarteter Zustand |
|---------|--------------------|
| VM gestartet | Ja |
| Netzwerk erreichbar | Ja |
| Home Assistant erreichbar | Ja |
| Supervisor gestartet | Ja |
| Dashboard erreichbar | Ja |

### Erfolgsbedingung

Home Assistant arbeitet wieder vollständig.

---

## Docker VM

### Prüfpunkte

| Prüfung | Erwarteter Zustand |
|---------|--------------------|
| VM gestartet | Ja |
| Docker Engine aktiv | Ja |
| Docker Compose Dienste gestartet | Ja |
| Netzwerk erreichbar | Ja |

### Erfolgsbedingung

Alle produktiven Docker-Dienste sind wieder verfügbar.

---

## Paperless VM

### Prüfpunkte

| Prüfung | Erwarteter Zustand |
|---------|--------------------|
| VM gestartet | Ja |
| Weboberfläche erreichbar | Ja |
| Datenverzeichnis erreichbar | Ja |

### Erfolgsbedingung

Paperless arbeitet wieder produktiv.

---

## Weitere produktive VMs

Zusätzlich prüfen.

| VM | Erwarteter Zustand |
|----|--------------------|
| Weitere Homelab-VMs | Gestartet und erreichbar |

### Dokumentieren

Nicht gestartete VMs werden protokolliert.

---

## LXC-Container verifizieren

Alle produktiven Infrastruktur-LXCs werden geprüft.

---

## AdGuard LXC

### Prüfpunkte

| Prüfung | Erwarteter Zustand |
|---------|--------------------|
| Container gestartet | Ja |
| DNS erreichbar | Ja |
| Weboberfläche erreichbar | Ja |

### Erfolgsbedingung

DNS-Auflösung funktioniert wieder vollständig.

---

## Uptime Kuma LXC

### Prüfpunkte

| Prüfung | Erwarteter Zustand |
|---------|--------------------|
| Container gestartet | Ja |
| Dashboard erreichbar | Ja |
| Monitore aktiv | Ja |

### Erfolgsbedingung

Monitoring überwacht wieder alle Systeme.

---

## Weitere Infrastruktur-LXCs

Zusätzlich prüfen.

| LXC | Erwarteter Zustand |
|-----|--------------------|
| Weitere Infrastruktur-LXCs | Gestartet und erreichbar |

---

## Externe Infrastrukturabhängigkeiten

Nach jedem Host werden externe Abhängigkeiten geprüft.

---

## Docker-VM und NFS

Prüfen:

- Docker-VM erreicht den NFS-Storage.
- NFS-Freigaben eingebunden.
- Schreib-/Lesetest erfolgreich.

### Erfolgsbedingung

Docker-Dienste besitzen wieder Zugriff auf gemeinsame Daten.

---

## Docker-VM und SMB

Prüfen:

- SMB-Freigabe erreichbar.
- SMB-Mount vorhanden.
- Medienverzeichnis lesbar.

### Erfolgsbedingung

Docker-Container können wieder auf SMB-Daten zugreifen.

---

## Jellyfin SMB-Medienbibliothek

Jellyfin nutzt die SMB-Freigabe der QNAP.

### Prüfpunkte

| Prüfung | Erwarteter Zustand |
|---------|--------------------|
| SMB-Mount erreichbar | Ja |
| Medienbibliothek sichtbar | Ja |
| Bibliothek lesbar | Ja |

### Erfolgsbedingung

Jellyfin kann seine Medienbibliothek wieder vollständig verwenden.

---

## Home Assistant Collector prüfen

Nach Abschluss der Wartung müssen alle Collector den neuen Zustand melden.

### Prüfen

| Sensor | Erwarteter Zustand |
|--------|--------------------|
| `sensor.pve01_update_count` | `0` |
| `sensor.pve02_update_count` | `0` |
| `sensor.pve03_update_count` | `0` |

### Aggregator

| Sensor | Erwarteter Zustand |
|--------|--------------------|
| `sensor.proxmox_update_summary` | `0 Updates` |

### Erfolgsbedingung

Home Assistant erkennt keine ausstehenden Proxmox-Updates mehr.

---

## TRMNL-Verifikation

TRMNL verwendet den Home-Assistant-Aggregator.

### Prüfpunkte

| Anzeige | Erwarteter Zustand |
|---------|--------------------|
| Proxmox Update-Karte | Keine Updates |
| Homelab Dashboard | Aktualisiert |
| Anzeige erfolgreich gerendert | Ja |

### Erfolgsbedingung

Auf keinem TRMNL-Gerät werden Proxmox-Updates angezeigt.

---

## Uptime Kuma Verifikation

Monitoring besitzt höchste Priorität nach Home Assistant.

### Prüfpunkte

| Prüfung | Erwarteter Zustand |
|---------|--------------------|
| `pve-01` erreichbar | Ja |
| `pve-02` erreichbar | Ja |
| `pve-03` erreichbar | Ja |
| Home Assistant | UP |
| Docker VM | UP |
| Paperless | UP |
| AdGuard | UP |
| Weitere Infrastruktur | UP |

### Erfolgsbedingung

Alle systemrelevanten Monitore melden **UP**.

---

## Dokumentation temporärer Ausfälle

Während der Wartung werden zulässige Ausfälle dokumentiert.

### Dokumentieren

| Dienst | Dauer | Ursache |
|--------|-------|---------|
| Jellyfin | Wartungsfenster | Host-Neustart |
| Paperless | Wartungsfenster | Host-Neustart |
| Weitere Komfortdienste | Wartungsfenster | Host-Neustart |

### Nicht zulässig

Nicht dokumentierte Ausfälle systemrelevanter Infrastruktur.

---

## Abschluss der Verifikation

Die Verifikation ist erfolgreich abgeschlossen, wenn:

- Cluster vollständig online.
- NFS verfügbar.
- SMB verfügbar.
- Backup-Storage verfügbar.
- Alle produktiven VMs gestartet.
- Alle produktiven LXCs gestartet.
- Home Assistant meldet **0 Updates**.
- TRMNL zeigt keine Proxmox-Updates.
- Uptime Kuma meldet alle Infrastrukturkomponenten als erreichbar.


## Rollback

Ein Rollback wird ausschließlich durchgeführt, wenn die Verifikation eines Hosts fehlschlägt oder der Cluster nach einem Update keinen produktiven Zustand erreicht.

Ziel ist die sichere Wiederherstellung des zuletzt bekannten funktionsfähigen Zustands.

---

## Rollback-Prinzip

Für den Proxmox-Cluster gilt:

1. Rollback immer hostweise.
2. Keine parallelen Rollbacks mehrerer Nodes.
3. Cluster-Quorum hat Vorrang.
4. Infrastruktur vor Komfortdiensten.
5. Nach jedem Rollback vollständige Verifikation durchführen.

---

## Host-Rollback

### Anwendungsfall

Der Host startet nach einem Update nicht korrekt oder zeigt einen fehlerhaften Kernel.

### Vorgehen

- Boot des vorherigen Kernels über das GRUB-Menü.
- Host vollständig starten.
- Cluster-Mitgliedschaft prüfen.
- Verifikation durchführen.

### Dokumentieren

| Punkt | Dokumentation |
|-------|---------------|
| Betroffener Host | `pve-01`, `pve-02` oder `pve-03` |
| Fehlerursache | Kernel, Paket oder Firmware |
| Verwendeter Kernel | Versionsnummer |
| Ergebnis | Erfolgreich / Fehlgeschlagen |

### Erwarteter Zustand

Der Host tritt mit dem vorherigen Kernel wieder dem Cluster bei.

---

## Paket-Rollback

Proxmox VE besitzt keinen generischen Paket-Rollback.

### Dokumentierte Strategie

- Fehlerhaftes Paket identifizieren.
- Vorherige Paketversion aus den Repositories verwenden, sofern verfügbar.
- Anschließend Host neu starten.
- Vollständige Verifikation durchführen.

### Einschränkung

Ein Paket-Rollback wird nur durchgeführt, wenn eine bekannte stabile Version verfügbar ist.

---

## VM-Rollback

### Wiederherstellung aus Proxmox Backup

Voraussetzung:

- Erfolgreiches Backup vor dem Wartungsfenster.

### Wiederherstellbare Systeme

| VM | Wiederherstellung |
|----|-------------------|
| Home Assistant | Proxmox Backup |
| Docker VM | Proxmox Backup |
| Paperless VM | Proxmox Backup |
| Weitere produktive VMs | Proxmox Backup |

### Erwarteter Zustand

Die VM entspricht dem Zustand des letzten erfolgreichen Backups.

---

## Snapshot-Rollback

Snapshots dürfen verwendet werden, wenn sie vor der Wartung erstellt wurden.

### Voraussetzungen

- Snapshot vorhanden.
- Snapshot konsistent.
- Keine zwischenzeitlichen produktiven Änderungen erforderlich.

### Einschränkung

Snapshots ersetzen keine regulären Backups.

---

## Cluster-Rollback

### Fehlgeschlagenes Host-Update

Wenn ein Host nicht erfolgreich aktualisiert werden kann:

1. Wartung sofort stoppen.
2. Keine weiteren Hosts aktualisieren.
3. Fehler analysieren.
4. Host wiederherstellen.
5. Cluster erneut verifizieren.

### Ziel

Der Cluster verbleibt jederzeit in einem konsistenten Zustand.

---

## Rollback bei verlorenem Quorum

### Ziel

Cluster-Quorum wiederherstellen.

### Vorgehen

- Verbleibende Nodes prüfen.
- Ursache dokumentieren.
- Fehlerhaften Node wieder online bringen.
- Cluster-Mitgliedschaft bestätigen.

### Wartungsregel

Weitere Wartungsarbeiten werden erst nach erfolgreicher Wiederherstellung des Quorums fortgesetzt.

---

## Wiederaufnahme der Wartung

Nach erfolgreichem Rollback beginnt keine Wartung automatisch.

### Voraussetzungen

- Fehler dokumentiert.
- Cluster vollständig online.
- Storage verfügbar.
- Verifikation erfolgreich.

Danach beginnt der Wartungsprozess erneut beim betroffenen Host.

---

## Besonderheiten

Diese Besonderheiten gelten dauerhaft für den Homelab-Cluster.

---

## Cluster-Betrieb

### Architektur

| Eigenschaft | Zustand |
|-------------|--------|
| Cluster | Drei Nodes |
| Ceph | Nicht vorhanden |
| Gemeinsamer Storage | NFS auf QNAP TS-464 |
| Zusätzlicher Storage | SMB-Freigabe auf QNAP TS-464 |

### Wartungsstrategie

- Hostweise Wartung.
- Keine parallelen Host-Updates.
- Keine VM-/LXC-Migrationen, sofern nicht technisch erforderlich.

---

## Besonderheit pve-03

`pve-03` besitzt ausschließlich die Rolle des Quorum-Knotens.

### Eigenschaften

- Keine produktiven VMs.
- Keine produktiven LXCs.
- Quorum-Unterstützung.

### Konsequenz

Dieser Host wird grundsätzlich zuerst aktualisiert.

---

## Besonderheit pve-02

`pve-02` ist der Compute-Knoten des Homelabs.

### Besondere Aufgaben

- Docker VM.
- KI-/LLM-VMs.
- Intel iGPU für GPU-Passthrough.

### Nach Kernel-Updates prüfen

- `/dev/dri` vorhanden.
- GPU verfügbar.
- KI-/LLM-VMs funktionieren.

---

## Besonderheit pve-01

`pve-01` trägt die zentrale Infrastruktur.

### Produktive Infrastruktur

- Home Assistant.
- Netzwerkdienste.
- Infrastruktur-VMs.

### Wartungsregel

`pve-01` wird grundsätzlich zuletzt aktualisiert.

---

## Verfügbarkeitsstrategie

Für den Cluster gilt folgende Priorisierung.

### Priorität 1

Systemrelevante Infrastruktur:

- Cluster.
- Storage.
- Home Assistant.
- Netzwerkdienste.
- DNS.

### Priorität 2

Produktive Dienste:

- Docker VM.
- Paperless.
- Monitoring.

### Priorität 3

Komfortdienste:

- Jellyfin.
- Weitere Anwendungsdienste.

Temporäre Ausfälle der Priorität 3 sind während eines Host-Neustarts zulässig.

---

## Storage-Besonderheiten

### NFS

Der NFS-Storage ist zentraler gemeinsamer Datenspeicher.

### SMB

Zusätzlich existiert eine produktive SMB-Freigabe.

Diese Freigabe wird vom Proxmox-Cluster gemountet.

### Nutzung

- Docker VM.
- Jellyfin Medienbibliothek.
- Weitere Dienste mit SMB-Abhängigkeit.

Nach jeder Wartung muss dieser Mount erneut geprüft werden.

---

## Infrastruktur-Neustart nach Hostwartung

Nach einem erfolgreichen Host-Neustart erfolgt die Kontrolle in fester Reihenfolge.

### Reihenfolge

1. Cluster vollständig online.
2. NFS-Storage verfügbar.
3. SMB-Mounts verfügbar.
4. Home Assistant VM prüfen.
5. Docker VM prüfen.
6. Jellyfin SMB-Zugriff prüfen.
7. Monitoring prüfen.
8. TRMNL prüfen.

---

## Monitoring und TRMNL

### Home Assistant

Kontrollieren:

- Dashboard erreichbar.
- Collector aktualisiert.
- Keine ausstehenden Updates.

### TRMNL

Kontrollieren:

- Homelab Dashboard aktualisiert.
- Proxmox Update-Karte zeigt keine Updates.

### Uptime Kuma

Kontrollieren:

- Alle Nodes UP.
- Alle Infrastrukturdienste UP.
- Dokumentierte Komfortdienste wieder erreichbar.

---

## Wartungsabschluss

Das Wartungsfenster endet erst nach erfolgreicher Verifikation aller Komponenten.

### Abschlusskriterien

| Bereich | Erwarteter Zustand |
|---------|--------------------|
| Cluster | Vollständig online |
| NFS | Verfügbar |
| SMB | Verfügbar |
| Backup-Storage | Verfügbar |
| Virtuelle Maschinen | Gestartet |
| LXC-Container | Gestartet |
| Home Assistant Collector | 0 Updates |
| TRMNL | Keine Proxmox-Updates |
| Uptime Kuma | Alle Infrastrukturkomponenten UP |

---

## Betriebsstatus nach erfolgreicher Wartung

Der Proxmox-Cluster befindet sich nach erfolgreichem Abschluss wieder im produktiven Regelbetrieb.

Die Betriebsreferenz gilt als verbindliche Arbeitsanweisung für zukünftige Wartungsfenster des Homelabs.

