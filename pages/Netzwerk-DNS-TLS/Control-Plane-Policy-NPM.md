# Control-Plane-Policy – Was darf **nicht** über NPM?

## Ziel
Diese Policy schützt die **Stabilität der Infrastruktur**, indem kritische Komponenten **bewusst von Reverse Proxy, TLS-Spielereien und Komfortfunktionen ausgeschlossen** werden.

Diese Policy ist **verbindlich**.

## 1. Definition: Control Plane
Als **Control Plane** gelten alle Komponenten, deren Ausfall **den Betrieb mehrerer Services gleichzeitig gefährdet**.

**Bestandteile der Control Plane:**
- Proxmox VE
- AdGuard Home
- Router / Firewall
- Backup-Targets (z. B. Proxmox Backup Server, NAS-Backupspeicher)

## 2. Grundregeln (nicht verhandelbar)
**Control-Plane-Systeme werden niemals:**
- über NGINX Proxy Manager geführt
- mit mkcert- oder Let’s-Encrypt-Zertifikaten ausgestattet
- über alternative DNS-Namen „verschönert“
- per HTTP erreichbar gemacht

## 3. Proxmox VE (Sonderfall)

### Erlaubt
- DNS-Alias  
  `proxmox.home.arpa → 192.168.1.26`
- Zugriff  
  `https://proxmox.home.arpa:8006`
- Akzeptieren der Browser-Security-Warnung

### Verboten
- Reverse Proxy vor Port 8006
- Änderung von Hostname oder Cluster-Namen
- Import externer Zertifikate
- Ausführung von `pvecm updatecerts`

## 4. AdGuard Home

### Zugriff
- Direktzugriff  
  `http://192.168.1.28`

AdGuard ist Teil der **Control Plane** und wird **bewusst ohne Reverse Proxy und ohne TLS** betrieben.

### Verboten
- Proxy über NGINX Proxy Manager
- DNS-Namen, die auf sich selbst zeigen

## 5. Begründung
Erfahrungen zeigen, dass **Identitätsänderungen an der Control Plane** zu folgenden Problemen führen:
- Service-Ausfälle
- nicht startende Daemons
- inkonsistente Systemzustände

**Stabilität schlägt Komfort.**

## 6. Entscheidungshilfe

| System        | Proxy erlaubt | TLS im NPM |
|---------------|---------------|------------|
| Proxmox       | Nein          | Nein       |
| AdGuard       | Nein          | Nein       |
| Router        | Nein          | Nein       |
| Web-Services  | Ja            | Ja         |

## Merksätze
- Die Control Plane wird nicht optimiert.
- Sie wird nur eindeutig benannt.
- Im Zweifel: Finger weg.

## Status
- risikoarm
- crash-vermeidend
- betriebserprobt
