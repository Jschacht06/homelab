<div align="center">
  <img src="https://img.shields.io/badge/Tailscale-242424?style=for-the-badge&logo=tailscale&logoColor=white" alt="Tailscale" />

  # Tailscale

  Secure remote access into my homelab without exposing internal services directly to the public internet.

  <p>
    <a href="https://tailscale.com/"><img src="https://img.shields.io/badge/Website-tailscale.com-242424?logo=tailscale&logoColor=white" alt="Tailscale website" /></a>
    <a href="https://tailscale.com/kb/"><img src="https://img.shields.io/badge/Docs-Knowledge_Base-3178c6?logo=readthedocs&logoColor=white" alt="Tailscale documentation" /></a>
    <a href="https://tailscale.com/kb/1019/subnets"><img src="https://img.shields.io/badge/Guide-Subnet_Router-f97316?logo=bookstack&logoColor=white" alt="Tailscale subnet router guide" /></a>
  </p>
</div>

---

## Overview

Tailscale is the private mesh network layer for this homelab. I use it to reach my internal network when I am away from home, so services that normally only live on my LAN can still be accessed securely from my trusted devices.

Instead of opening ports for every service, Tailscale gives my devices a private tailnet and lets me route selected internal subnets through an approved node.

## Role In The Homelab

| Area | Purpose |
| --- | --- |
| Remote access | Connect back into my home network from outside the house |
| Private services | Reach internal dashboards, LXCs, VMs, and admin panels without public exposure |
| Subnet routing | Advertise the LAN or selected VLANs into the tailnet |
| Device trust | Only authenticated Tailscale devices can join the private network |

## Container Resources

| Resource | Allocation |
| --- | --- |
| Type | LXC container |
| Operating system | Debian 13 |
| CPU cores | 4 |
| Memory | 2 GB RAM |
| Boot disk | 8 GB |

## Setup

Install Tailscale on the target machine:

```bash
curl -fsSL https://tailscale.com/install.sh | sh
```

Authenticate the node:

```bash
sudo tailscale up
```

Advertise a subnet route so remote Tailscale devices can access the homelab network:

```bash
sudo tailscale set --advertise-routes="<subnet-route>/CIDR"
```

Example:

```bash
sudo tailscale set --advertise-routes="192.168.1.0/24"
```

After advertising routes, approve the route in the Tailscale admin console.

## Useful Commands

Check connection status:

```bash
tailscale status
```

Show this node's Tailscale IP:

```bash
tailscale ip
```

Bring the node back online:

```bash
sudo tailscale up
```

Disable advertised routes if needed:

```bash
sudo tailscale set --advertise-routes=
```
