# Docker VM

**Betriebsreferenz V1.0**

Dokumentation des standardisierten Wartungs- und Update-Workflows der Docker-VM des Homelabs.

---

## Zweck

Die Docker-VM stellt Docker-Compose-basierte Dienste des Homelabs bereit. Diese Betriebsreferenz beschreibt den produktiven Ablauf für Wartung, Updates, Verifikation und Rollback.

---

## 1. Auslöser (TRMNL-Update-Instanz)

Der Wartungsprozess beginnt ausschließlich aufgrund einer Update-Meldung im Homelab.

**Auslöser**

- TRMNL zeigt verfügbare Docker-Updates.
- Home Assistant meldet verfügbare Docker-Updates.
- Der Update-Aggregator zeigt einen Eintrag für die Docker-VM.

**Verwendete Sensoren**

- sensor.docker_update_count
- sensor.docker_update_summary

Die Betriebsreferenz beschreibt ausschließlich den Wartungsprozess nach einer vorhandenen Update-Erkennung.

---

## 2. Datenquelle (Collector)

Die Update-Information stammt ausschließlich vom Docker-Collector.

### Sensoren

| Sensor | Bedeutung |
|--------|-----------|
| sensor.docker_update_count | Anzahl verfügbarer Docker-Container-Updates. |
| sensor.docker_update_summary | Zusammenfassung der betroffenen Container. |

### Verifikation in Home Assistant

Die Sensoren werden ausschließlich in den Entwicklerwerkzeugen geprüft.

Es erfolgen keine REST-Aufrufe und keine zusätzlichen Scanner.

---

## 3. Vorbedingungen

Vor Beginn müssen folgende Bedingungen erfüllt sein.

### Infrastruktur

- Docker-VM (docker-vm) erreichbar.
- SSH-Zugriff vorhanden.
- Docker Compose installiert.
- Internetzugang verfügbar.
- nginx-Webserver der Docker-VM betriebsbereit.

### Datensicherung

Vor jedem Update muss eine aktuelle Sicherung vorhanden sein.

Kontrollpunkte:

- Letzte automatische Homelab-Sicherung erfolgreich.
- QNAP TS-464 erreichbar.
- Genügend freier Speicher vorhanden.

### Betriebszustand dokumentieren

Vor dem Update werden dokumentiert:

- Datum/Uhrzeit.
- Betroffene Container laut Collector.
- Aktiver Zustand aller Container.

---

## 4. Durchführung

Der Wartungsprozess verwendet ausschließlich Docker Compose.

### Schritt 1 — Auf die Docker-VM wechseln

SSH auf docker-vm.

### Schritt 2 — Compose-Projekt öffnen

In das Verzeichnis des betroffenen Compose-Projekts wechseln.

### Schritt 3 — Neue Images herunterladen

```bash
docker compose pull
```

Es werden ausschließlich neue Images geladen.

### Schritt 4 — Container aktualisieren

```bash
docker compose up -d
```

Docker ersetzt ausschließlich Container mit neuem Image.

### Schritt 5 — Nicht mehr benötigte Images entfernen

```bash
docker image prune -f
```

Nicht verwendete Images werden entfernt.

### Standard-Reihenfolge

1. docker compose pull
2. docker compose up -d
3. docker image prune -f

Weitere Optimierungen oder Watchtower werden nicht verwendet.

---

## 5. Verifikation

Nach jedem Update erfolgt eine vollständige Kontrolle.

### Containerstatus

```bash
docker compose ps
```

Alle produktiven Container müssen den Status **Up** besitzen.

### Containerprotokolle

```bash
docker compose logs --tail=50
```

Kontrolle auf:

- Startfehler
- Datenbankfehler
- Zertifikatsfehler
- Port-Konflikte

### Funktionstest

Für jeden aktualisierten Dienst wird geprüft:

- Weboberfläche erreichbar.
- HTTPS erreichbar.
- Anmeldung möglich.

### TLS-/Zertifikatsprüfung

Für jeden aktualisierten Webdienst wird geprüft:

- HTTPS ist erreichbar.
- Das Zertifikat ist gültig.
- Das Zertifikat entspricht *.home.arpa.

Wird festgestellt, dass ein Container kein gültiges Zertifikat besitzt, wird die Zertifikatskonfiguration unmittelbar eingerichtet oder korrigiert, bevor der Wartungsvorgang als erfolgreich abgeschlossen gilt.

### Home Assistant

In den Entwicklerwerkzeugen prüfen:

- sensor.docker_update_count
- sensor.docker_update_summary

Erwartung:

- Update-Anzahl reduziert.
- Zusammenfassung aktualisiert.

### Monitoring

Uptime Kuma prüfen.

Erwartung:

- Dienst weiterhin **UP**.
- Keine neuen Ausfälle.

---

## 6. Rollback

Rollback erfolgt ausschließlich über Docker Compose und vorhandene Sicherungen.

### Voraussetzungen

- Vorheriges Image noch vorhanden.

### Image wiederherstellen

Im Compose-File die vorherige Image-Version eintragen.

Danach:

```bash
docker compose pull
docker compose up -d
```

### Falls Image entfernt wurde

Image aus Registry erneut laden.

### Falls Konfiguration beschädigt wurde

Konfiguration aus Homelab-Backup wiederherstellen.

### Falls Daten beschädigt wurden

Daten aus QNAP-Sicherung zurückspielen.

Rollback beendet den Wartungsvorgang erst nach erfolgreicher Verifikation.

---

## 7. Besonderheiten

### Docker Compose

Alle produktiven Dienste der Docker-VM werden über Docker Compose verwaltet.

### nginx-Webserver auf der Docker-VM

Die Docker-VM betreibt einen eigenen nginx-Webserver für Docker-Dienste.

Der zentrale Reverse Proxy des Homelabs (nginx-base) bleibt davon unabhängig bestehen. Je nach Dienst erfolgt die HTTPS-Bereitstellung entweder über den nginx-Webserver der Docker-VM oder über nginx-base.

Nach Container-Updates ist zu prüfen, dass die nginx-Konfiguration weiterhin gültig ist und die HTTPS-Bereitstellung funktioniert.

### Zertifikate

Wildcard-Zertifikate (*.home.arpa) werden im Homelab mit mkcert verwaltet.

Nach einem Container-Update muss geprüft werden, ob der Dienst weiterhin ein gültiges Zertifikat verwendet.

Fehlt ein gültiges Zertifikat oder ist die TLS-Konfiguration unvollständig, wird diese im Rahmen des Wartungsvorgangs eingerichtet oder korrigiert.

### Monitoring

Uptime Kuma dient als Betriebsreferenz für die Erreichbarkeit nach Updates.

### Update-Erkennung

Die Erkennung erfolgt ausschließlich über den Docker-Collector.

Diese Betriebsreferenz implementiert keine eigene Update-Erkennung.

---

## Änderungsprotokoll

| Version | Datum | Beschreibung |
|----------|-------|--------------|
| V1.0 | 2026-08-31 | Erste Produktionsreferenz für den Docker-VM-Wartungsprozess im Projekt UPSYS-001. |
