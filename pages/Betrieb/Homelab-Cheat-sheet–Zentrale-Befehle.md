# Homelab Cheat-Sheet

Kompakte Übersicht der **wichtigsten Befehle** für dein System. Fokus: reproduzierbar, robust, ohne implizite Annahmen.

---

## Git (Host: Admin-PC)

### Repository-Status

```bash
git status
git branch
git log --oneline --graph --decorate -10
```

### Änderungen prüfen

```bash
git diff
git diff --staged
```

### Arbeiten mit Commits

```bash
git add <datei>
git add -A
git commit -m "Nachricht"
```

### Remote & Sync

```bash
git remote -v
git pull --rebase
git push origin main
```

### Branching (bewusst und sparsam)

```bash
git switch -c <branch>
git switch main
git merge <branch>
```

### Aufräumen & Kontrolle

```bash
git fetch --prune
git branch -vv
git show <commit>
```

**Merksatz:** Nur committen, was reproduzierbar ist. Secrets gehören **nicht** ins Repository.

---

## Docker (Host: Docker-VM)

### Status & Übersicht

```bash
docker ps
docker ps -a
docker images
docker stats
```

### Container steuern

```bash
docker start <container>
docker stop <container>
docker restart <container>
docker rm <container>
```

### Logs & Debugging

```bash
docker logs <container>
docker logs <container> --tail 100 -f
docker inspect <container>
```

### Docker Compose

```bash
docker compose up -d
docker compose down
docker compose ps
docker compose logs -f
```

### Cleanup (bewusst einsetzen)

```bash
docker system df
docker system prune
```

---

## Nginx (Host: nginx-base)

### Service-Steuerung

```bash
systemctl status nginx
systemctl reload nginx
systemctl restart nginx
```

### Konfiguration prüfen

```bash
nginx -t
```

### Aktive Konfiguration nachvollziehen

```bash
nginx -T | less
```

### Logs

```bash
tail -f /var/log/nginx/access.log
tail -f /var/log/nginx/error.log
```

---

## Ansible (Host: Admin-PC)

### Grundlegendes

```bash
ansible --version
ansible-inventory -i inventory --graph
```

### Ad-hoc Tests

```bash
ansible all -i inventory -m ping
ansible nginx-base -i inventory -m command -a "uptime"
```

### Playbooks

```bash
ansible-playbook -i inventory site.yml
ansible-playbook -i inventory site.yml --check
ansible-playbook -i inventory site.yml --diff
```

### Targeting

```bash
ansible-playbook -i inventory nginx.yml --limit nginx-base
```

---

## Proxmox (Host: pve-01)

### VM & LXC Übersicht

```bash
qm list
pct list
```

### VM steuern

```bash
qm status <vmid>
qm start <vmid>
qm shutdown <vmid>
qm stop <vmid>
```

### Konfiguration anzeigen

```bash
qm config <vmid>
```

---

## Netzwerk / DNS / TLS (Admin-PC)

### DNS prüfen

```bash
dig hostname.home.arpa +short
```

### HTTP / HTTPS prüfen

```bash
curl -I http://host.home.arpa
curl -Ik https://host.home.arpa
```

### Zertifikate prüfen

```bash
openssl x509 -in cert.pem -noout -dates
```

---

## System / Linux allgemein

### Dienste

```bash
systemctl status <service>
journalctl -u <service> -f
```

### Ressourcen

```bash
uptime
free -h
df -h
```

### Netzwerk

```bash
ip a
ip r
ss -tulpen
```

---

## Monitoring / Betrieb

### Erreichbarkeit

```bash
ping <host>
```

### Ports testen

```bash
nc -zv host port
```

---

## Leitplanken (Merksätze)

* **Keine manuellen Änderungen** auf Zielsystemen – alles über Ansible.
* **Explizite Hosts, Pfade, IPs** – keine Annahmen.
* **Check vor Reload/Restart** (nginx -t, ansible --check).
* Erst **Ist-Zustand verstehen**, dann ändern.
* Git ist Teil des Betriebs: *kein Commit = keine Änderung
