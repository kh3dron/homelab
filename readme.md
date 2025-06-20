# Homelab

This repo stores a few things:

- Ansible playbooks for configuring hardware
- Gitops repo for hosting applications on a cluster
- Docker swarm YAMLs to host large applications outside the cluster

## Hardware

| Name | Model | CPU | RAM | Storage | GPU |
|------|-------|-----|-----|---------|-----|
| Huey | Desktop | i7-13700K 24C | 64GB | 4TB SSD, 2x4TB HDD | RTX 4060 Ti 8GB |
| Ned | Raspberry Pi 5 Model B Rev 1.1 | 4C | 8GB | 32GB SD | - |
| Maude | Raspberry Pi 4 Model B Rev 1.2 | 4C | 4GB | 32GB SD | - |
| Rod | Raspberry Pi 3 Model B Plus Rev 1.3 | 4C| 1GB | 32GB SD | - |
| Todd | Raspberry Pi 3 Model B Rev 1.2 | 4C | 1GB | 32GB SD | - |

## leaderboard of stupid issues that have wasted tremendous time

- 6 Hours: overwriting kernel arguments in the rpis with ansible, killing all 4 of them and requiring fresh OS installs
- 3 Hours: left ufw enabled on Huey, breaking cluster ingress and DNS
- 2 Hours: not reading tailscale docs closely enough and screwing something up that was clearly explained
