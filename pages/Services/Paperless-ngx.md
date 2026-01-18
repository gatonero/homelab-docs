# Paperless-ngx – paperless.home.arpa

## Zweck

Paperless-ngx ist das interne Dokumentenmanagement-System für gescannte
und digital erzeugte Unterlagen. Der Zugriff erfolgt ausschließlich über
den Fully Qualified Domain Name `paperless.home.arpa` mittels Reverse Proxy.
Direkte Zugriffe auf Backend-Ports oder IP-Adressen sind nicht vorgesehen
und kein Bestandteil des Betriebsmodells.

---

## NetBox-Abbildung

Paperless-ngx ist in NetBox unter IPAM → Application Services modelliert.

Der logische Applikationsdienst `paperless-ngx` beschreibt die Anwendung
aus Benutzersicht. Der technische Backend-Service `paperless-ngx-web`
repräsentiert den tatsächlich laufenden TCP-Dienst auf Port 40200/TCP
auf dem Host QNAP TS-464. Der logische Dienst nutzt ausschließlich diesen
Backend-Service. Benutzerzugriffe erfolgen nicht direkt auf den Backend-Port.

---

## Architektur

Der Zugriff auf Paperless-ngx erfolgt über eine DNS-gestützte
Reverse-Proxy-Architektur. Die Namensauflösung für
`paperless.home.arpa` erfolgt über AdGuard Home, welches den
FQDN auf die IP-Adresse des Nginx Proxy Managers auflöst.

Der Nginx Proxy Manager übernimmt die TLS-Terminierung sowie
die vollständige Weiterleitung der HTTP-Anfragen an den
internen Backend-Service. Der Backend-Service
`paperless-ngx-web` läuft containerisiert auf dem Host
QNAP TS-464 und lauscht intern auf TCP Port 40200.

Die Kommunikation zwischen Reverse Proxy und Backend erfolgt
unverschlüsselt per HTTP. Der Backend-Service ist nicht direkt
aus dem Client-Netz erreichbar.

Der vollständige Zugriffspfad lautet:

Client  
→ DNS (AdGuard Home)  
→ https://paperless.home.arpa  
→ Nginx Proxy Manager  
→ http://192.168.1.31:40200  

---

## Netzwerk und Ports

Extern ist ausschließlich Port 443/TCP für HTTPS vorgesehen. Intern wird
Port 40200/TCP für die Kommunikation zwischen Reverse Proxy und Backend
verwendet. Ein direkter Zugriff auf den Backend-Port ist nicht vorgesehen
und nicht Bestandteil des Betriebs.

---

## TLS und Sicherheit

Das TLS-Zertifikat wird im Nginx Proxy Manager verwaltet. Der Backend-
Service akzeptiert ausschließlich HTTP-Verbindungen aus dem internen
Netz. Zertifikate werden entweder über eine interne CA oder über ACME
bereitgestellt. Der Backend-Service selbst führt keine TLS-Terminierung
durch.

---

## Reverse Proxy – Nginx Proxy Manager (Advanced)

Paperless-ngx ist host-header-sensitiv und erfordert eine korrekte
Weitergabe des vom Client übermittelten Host-Headers durch den Reverse
Proxy. Entsprechende Einstellungen sind im Bereich „Advanced“ des
Nginx Proxy Managers gesetzt.

Diese Advanced-Konfiguration stellt sicher, dass der Hostname
`paperless.home.arpa` unverändert an den Backend-Service weitergereicht
wird. Ohne diese Weitergabe reagiert Paperless-ngx mit einem
HTTP/1.1 400 Bad Request. Die Advanced-Konfiguration ist integraler
Bestandteil des Betriebsmodells und muss bei einem Restore oder
Neuaufbau des Reverse Proxys berücksichtigt werden.

---

## Betriebsbesonderheiten

Paperless-ngx reagiert auf Zugriffe ohne korrekten Host-Header,
insbesondere auf direkte Zugriffe per IP-Adresse oder localhost,
mit einem HTTP/1.1 400 Bad Request. Funktionstests, Monitoring und
Diagnose müssen daher immer über den FQDN `paperless.home.arpa`
erfolgen. Direkte Backend-Tests sind kein gültiges Diagnosemittel.

---

## Diagnose

Für die Funktionsprüfung sind ausschließlich die korrekte DNS-Auflösung
über AdGuard Home sowie die HTTPS-Erreichbarkeit des FQDN relevant.
Der Backend-Port 40200/TCP wird ausschließlich durch den Reverse Proxy
genutzt. Der Reverse Proxy muss auf das Ziel
`http://192.168.1.31:40200` konfiguriert sein und den Hostnamen
unverändert weiterreichen.

---

## Restore- und Wiederanlauf-Reihenfolge

Nach einem Ausfall oder Restore ist sicherzustellen, dass AdGuard Home
verfügbar ist und `paperless.home.arpa` korrekt auf den Reverse Proxy
auflöst. Anschließend muss der Host QNAP TS-464 erreichbar sein und der
Backend-Service `paperless-ngx-web` auf Port 40200 laufen. Danach ist
der Nginx Proxy Manager inklusive der Advanced-Konfiguration zu
aktivieren. Der abschließende Funktionstest erfolgt ausschließlich über
den HTTPS-Zugriff auf `https://paperless.home.arpa`.

---

## Lessons Learned

Paperless-ngx erfordert eine saubere Trennung zwischen logischem
Applikationsdienst und technischem Backend-Service. DNS und Reverse Proxy
sind integrale Bestandteile der Anwendung. Direkte IP- oder Port-Tests
führen zu Fehlinterpretationen. Die feste Reihenfolge DNS → Reverse Proxy
→ Application ist zwingend einzuhalten.
