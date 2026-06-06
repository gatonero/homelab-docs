---
title: "Home-Assistant-KI-Wetterempfehlung-WordPress"
---

# Automatische KI-Wetterempfehlung für WordPress

## Ziel

Home Assistant erzeugt aus den stündlichen Wetterdaten von OpenWeatherMap automatisch eine kurze KI-basierte Kleidungsempfehlung und veröffentlicht diese auf einer WordPress-Webseite.

Der gesamte Ablauf erfolgt vollautomatisch ohne manuelle Eingriffe.

---

## Architektur

```text
OpenWeatherMap
        ↓
weather.get_forecasts
        ↓
Home Assistant
        ↓
AI Task
        ↓
ai_response.data
        ↓
shell_command.weather_upload
        ↓
SSH
        ↓
Webserver
        ↓
/var/www/html/data/weather.txt
        ↓
WordPress Shortcode
        ↓
Website
```

---

## Komponenten

### Home Assistant

Verantwortlich für:

- Abruf der Wetterdaten
- Verarbeitung der Wetterdaten
- KI-Auswertung
- Bereitstellung des Ergebnisses
- Upload zum Webserver

### OpenWeatherMap

Liefert die stündliche Wettervorhersage.

Verwendete Entität:

```text
weather.openweathermap
```

### AI Task Integration

Erzeugt aus den Wetterdaten:

- Kleidungsempfehlung
- Wetterzusammenfassung

Verwendeter Dienst:

```text
ai_task.generate_data
```

### Webserver

Speichert den aktuellen Text in:

```text
/var/www/html/data/weather.txt
```

### WordPress

Bindet die Datei über einen bestehenden Shortcode in die Webseite ein.

---

## Home Assistant Konfiguration

### shell_command.yaml

Datei:

```text
/config/shell_command.yaml
```

Inhalt:

```yaml
weather_upload: '/config/upload_weather.sh "{{ text }}"'
```

---

### Upload-Skript

Datei:

```text
/config/upload_weather.sh
```

Inhalt:

```bash
#!/bin/sh

printf '%s' "$1" | ssh \
-i /config/.ssh/weather_upload \
-o StrictHostKeyChecking=no \
root@192.168.1.50 \
"cat > /var/www/html/data/weather.txt"
```

Berechtigungen:

```bash
chmod 700 /config/upload_weather.sh
```

---

## SSH-Konfiguration

SSH-Schlüssel:

```text
/config/.ssh/weather_upload
```

Verwendungszweck:

```text
Home Assistant → Webserver
```

Authentifizierung erfolgt ausschließlich per SSH-Key.

Passwortlose Anmeldung erforderlich.

---

## Automation

Auslöser:

```text
input_button.start_automation
```

Ablauf:

1. Wetterdaten abrufen
2. Wetterdaten in JSON umwandeln
3. KI-Auswertung durchführen
4. Ergebnis in Home Assistant speichern
5. Ergebnis zum Webserver übertragen
6. Ergebnis als Benachrichtigung anzeigen

---

## Verwendete Entitäten

### Wetter

```text
weather.openweathermap
```

### Start-Button

```text
input_button.start_automation
```

### Zwischenspeicher

```text
input_text.weather_website_text
```

---

## Prompt-Vorgaben

Die KI erzeugt ausschließlich reinen Webseitentext.

Vorgaben:

- Keine Markdown-Formatierung
- Keine Überschriften
- Keine Listen
- Keine Aufzählungen
- Keine Emojis
- Keine Einleitung
- Keine Schlussformel

Ausgabeformat:

1. Absatz: Kleidungsempfehlung
2. Absatz: Wetterüberblick für die nächsten 6 Stunden

---

## Zielzustand

Nach jedem Lauf der Automation enthält:

```text
/var/www/html/data/weather.txt
```

den aktuellen KI-generierten Text.

Die WordPress-Webseite zeigt dadurch automatisch die aktuelle wetterabhängige Kleidungsempfehlung an.

---

## Verifikation

### Home Assistant

Template-Test:

```jinja2
{{ states('input_text.weather_website_text') }}
```

---

### Webserver

Dateiinhalt prüfen:

```bash
cat /var/www/html/data/weather.txt
```

---

### Proxmox

Dateiinhalt prüfen:

```bash
pct exec 120 -- cat /var/www/html/data/weather.txt
```

---

## Erkenntnisse

### Shell Command Parameter

Direkte Übergabe über:

```yaml
data:
  text: "{{ ai_response.data }}"
```

funktioniert zuverlässig.

---

### Dateischreiben

Die Installation besitzt keinen Dienst:

```text
file.write_file
```

Deshalb erfolgt die Übertragung über ein Shell-Skript und SSH.

---

### Markdown

Markdown-Markierungen werden von WordPress in diesem Anwendungsfall nicht interpretiert.

Die KI-Ausgabe muss deshalb reiner Text sein.
