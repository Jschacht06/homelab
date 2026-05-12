<div align="center">
  <img src="https://img.shields.io/badge/Nginx_Proxy_Manager-242424?style=for-the-badge&logo=nginxproxymanager&logoColor=white" alt="Nginx Proxy Manager" />

  # Internal Proxy

  Central reverse proxy for routing internal homelab services through clean hostnames and HTTPS.

  <p>
    <a href="https://nginxproxymanager.com/"><img src="https://img.shields.io/badge/Website-nginxproxymanager.com-242424?logo=nginxproxymanager&logoColor=white" alt="Nginx Proxy Manager website" /></a>
    <a href="https://nginxproxymanager.com/guide/"><img src="https://img.shields.io/badge/Docs-Setup_Guide-3178c6?logo=readthedocs&logoColor=white" alt="Nginx Proxy Manager documentation" /></a>
    <a href="https://theforgetful.dev/posts/nginx-proxy-manager-wildcard-ssl-unraid/"><img src="https://img.shields.io/badge/Guide-Wildcard_SSL-f97316?logo=letsencrypt&logoColor=white" alt="Wildcard SSL guide" /></a>
  </p>
</div>

---

## Overview

The internal proxy runs Nginx Proxy Manager. I use it to give my internal services friendly hostnames inside my network and to add HTTPS to those services without manually writing Nginx config for each one.

## Role In The Homelab

| Area | Purpose |
| --- | --- |
| Reverse proxy | Route traffic to internal services by hostname |
| HTTPS management | Manage SSL certificates for proxied services |
| Service access | Provide a cleaner access layer for dashboards and apps |
| Administration | Use the Nginx Proxy Manager web UI for proxy host configuration |

## Container Resources

| Resource | Allocation |
| --- | --- |
| Type | LXC container |
| Operating system | Debian 13 |
| CPU cores | 4 |
| Memory | 2 GB RAM |
| Boot disk | 8 GB |

## Docker Compose

```yaml
services:
  nginx-proxy-manager:
    image: jc21/nginx-proxy-manager:latest
    container_name: nginx-proxy-manager
    ports:
      - "80:80"
      - "443:443"
      - "81:81"
    volumes:
      - npm_data:/data
      - npm_letsencrypt:/etc/letsencrypt
    restart: unless-stopped

volumes:
  npm_data:
  npm_letsencrypt:
```

## Setup

The badge row at the top links to the Nginx Proxy Manager documentation and the wildcard SSL guide used for adding proxy hosts and certificates.

Start the container:

```bash
docker compose up -d
```

Open the admin interface:

```text
http://<ip>:81/
```

Create the initial admin user, then configure proxy hosts for the internal services that should be routed through Nginx Proxy Manager.

## Useful Commands

Start the proxy:

```bash
docker compose up -d
```

View running containers:

```bash
docker compose ps
```

View logs:

```bash
docker compose logs -f nginx-proxy-manager
```

Restart the proxy:

```bash
docker compose restart nginx-proxy-manager
```

Stop the proxy:

```bash
docker compose down
```
