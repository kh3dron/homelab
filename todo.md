# todo

- [x] Purchase pis
- [x] assemble physical pi cluster
- [x] ansible playbooks: 00-system
  - note that ansible pings fail until you copy the ssh keys over with ssh-keygen. surely doable better somehow but I'm impatient
  - for ez ssh: update both /etc/hosts and ~/.ssh/config
- [x] kubeconfig retrieved, got k3s cluster up with one node

- [ ] argocd enabled
  - [ ] need ingres
- [x] ansible playbooks extended to cover Huey, my ubuntu server
- [ ] cluster with 5 nodes

## TODO

- [ ] moar apps deployed
- [ ] architecture diagrams

## notes

- todo when resetting pis

ssh-keygen -R 192.168.0.84
ssh-copy-id ned@192.168.0.84

ssh-keygen -R 192.168.0.85
ssh-copy-id maude@192.168.0.85

ssh-keygen -R 192.168.0.82
ssh-copy-id rod@192.168.0.82

ssh-keygen -R 192.168.0.83
ssh-copy-id todd@192.168.0.83
