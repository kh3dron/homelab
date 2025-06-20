# plans

## done

- Purchase pis
- assemble physical pi cluster
- ansible playbooks: 00-system
  - note that ansible pings fail until you copy the ssh keys over with ssh-keygen. surely doable better somehow but I'm impatient
  - for ez ssh: update both /etc/hosts and ~/.ssh/config
- kubeconfig retrieved, got k3s cluster up with one node
- argocd enabled
  - need ingres
- ansible playbooks extended to cover Huey, my ubuntu server
- cluster with 5 nodes
- r53 records to tailscale IPs
- signed in to argocd CLI

## todo

- tls certs for argo
- add moar apps
