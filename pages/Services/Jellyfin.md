# Jellyfin – Audio-Setup mit QNAP (Docker)

## Zweck

Dieses Dokument beschreibt das **verbindliche, reproduzierbare Setup** für Audioinhalte (Musik, Hörspiele, Vorträge) in **Jellyfin** mit **QNAP NAS** als Storage und **Docker** als Laufzeitumgebung.

**Ziel:**

* Audioinhalte zuverlässig **sichtbar** und **abspielbar** machen
* typische Fallstricke vermeiden
* Restore- und Review-taugliche Dokumentation

> **Verbindliche Regel:** 1 Thema = 1 Markdown-Datei.

---

## Kurzfassung (Executive Summary)

* **Audio funktioniert in Jellyfin ausschließlich in Bibliotheken vom Typ *Musik*.**
* Andere Bibliothekstypen (**Bücher**, **Heimvideos & Bilder**, **Musikvideos**) **ignorieren Audio-Dateien**.
* Jellyfin erwartet mindestens die Struktur **Artist → Album → Track**.
* Rechteprobleme äußern sich oft als „Ordner sichtbar, Inhalte leer“ – sind hier aber **nachrangig**.

---

## Architektur

```
[Jellyfin Container]
        │  (read-only)
        ▼
   /media/Musik
        │
        ▼
[QNAP NAS: Multimedia]
```

* **Jellyfin:** Docker-Container
* **Mount:** Read-only (`/media`)
* **Storage:** QNAP NAS (NFS)
* **Formate:** WAV, MP3

---

## Verbindliche Bibliothekstypen

| Inhalt                         | Bibliothekstyp | Ergebnis                    |
| ------------------------------ | -------------- | --------------------------- |
| Musik (WAV, MP3, FLAC)         | **Musik**      | ✔ sichtbar & abspielbar     |
| Hörspiele                      | **Musik**      | ✔ sichtbar & abspielbar     |
| Vorträge / Lesungen            | **Musik**      | ✔ sichtbar & abspielbar     |
| Audiobooks (Kapitel/Metadaten) | Bücher         | ⚠️ nur mit sauberem Tagging |
| Videos                         | Filme / Serien | ✔                           |

> **Merksatz:** Audio gehört immer in **Musik** – unabhängig vom Inhalt.

---

## Verbindliche Ordnerstruktur (Audio)

Jellyfin verarbeitet Audio **nur**, wenn folgende Mindeststruktur eingehalten wird:

```
/media/Musik/
└── Interpret/
    └── Album/
        ├── Track01.wav
        ├── Track02.mp3
```

### Beispiel (funktionierend)

```
/media/Musik/Gaston/
├── The Best of Tschaikowsky/
│   ├── CD01-Track01.wav
│   ├── CD01-Track02.wav
├── Faust/
│   ├── Faust-01.wav
```

### Hörspiele (empfohlen)

```
/media/Musik/Hörspiele/
└── Die lymphatersche Formel/
    ├── Teil01.mp3
    ├── Teil02.mp3
```

* **Interpret** = Künstler, Sprecher, Serie
* **Album** = Sammlung, Werk, Titel
* **Tracks** = einzelne Dateien

---

## Mount & Berechtigungen (QNAP)

### Mount

* **Read-only Mount** im Container (empfohlen)
* Rechteänderungen erfolgen **ausschließlich auf dem QNAP**

### Mindestanforderungen (POSIX)

* Verzeichnisse: **Lesen + Ausführen (r-x)**
* Dateien: **Lesen (r)**

> Ohne **Execute (x)** auf Verzeichnissen kann Jellyfin Dateien nicht traversieren.

---

## Einrichtung in Jellyfin

### Bibliothek anlegen

* **Typ:** Musik
* **Name:** Audio (oder spezifisch, z. B. Gaston)
* **Pfad:** `/media/Musik` oder `/media/Musik/<Interpret>`

### Scan

* Bibliothek anlegen
* **Bibliothek scannen**
* Ergebnis prüfen: **Alben sichtbar**

---

## Debug-Checkliste

### 1. Sichtbarkeit im Container

```
docker exec -it jellyfin find /media/Musik -type f | head
```

### 2. Rechte prüfen

```
docker exec -it jellyfin ls -l /media/Musik/Interpret/Album
```

### 3. Codec-Test

```
docker exec -it jellyfin /usr/lib/jellyfin-ffmpeg/ffprobe <datei>
```

### 4. Jellyfin UI

* Bibliothekstyp = **Musik**
* Alben sichtbar = Erfolg

---

## Typische Fehlerbilder & Ursachen

| Symptom                              | Ursache                          | Lösung                         |
| ------------------------------------ | -------------------------------- | ------------------------------ |
| Ordner sichtbar, Inhalte leer        | Falscher Bibliothekstyp          | Bibliothek **Musik** verwenden |
| Dateien per `find` sichtbar, UI leer | Audio in falscher Bibliothek     | Struktur + Typ korrigieren     |
| `Permission denied`                  | fehlendes `x` auf Verzeichnissen | Rechte auf QNAP setzen         |

---

## Lessons Learned (verbindlich)

1. **Bibliothekstyp schlägt alles** (Rechte, Codecs, Metadaten)
2. Jellyfin ist **kein generischer Dateibrowser**
3. Audio wird **nur** in Musik-Bibliotheken indexiert
4. Read-only Mounts sind sicher und ausreichend
5. Fehleranalyse beginnt immer bei: **Bibliothekstyp → Struktur → Rechte**

---

## Status

* Setup: **produktionsreif**
* Dokumentation: **final**
* Wiederholbarkeit: **gegeben**
