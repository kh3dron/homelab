# plans

## done

- Layer 1
  - Purchase pis
  - assemble physical pi cluster
- ansible
  - ansible playbooks: 00-system
    - note that ansible pings fail until you copy the ssh keys over with ssh-keygen. surely doable better somehow but I'm impatient
    - for ez ssh: update both /etc/hosts and ~/.ssh/config
  - kubeconfig retrieved, got k3s cluster up with one node
  - ansible playbooks extended to cover Huey, my ubuntu server
  - cluster with 5 nodes
- argocd
  - got tailscale operator running
  - r53 records to tailscale IPs
  - signed in to argocd CLI
  - updated password
  - create guestbook application
- librechat

## Questions

- how do I determine what apps get a tailscale ingress operator
- How do I make argoCD manage shit
- How do I connect kustomize files 