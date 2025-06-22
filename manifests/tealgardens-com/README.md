# Tealgardens.com Deployment

This directory contains the Kubernetes manifests to deploy tealgardens.com to your cluster using ArgoCD.

## Architecture

This deployment uses a local Docker registry on Huey to build and store the Docker image:

1. **Docker Registry on Huey**: Runs on port 5000, stores Docker images locally
2. **Build Process**: Images are built from your git repository and pushed to the local registry
3. **Kubernetes Deployment**: Pulls images from the local registry and deploys them

## Setup Instructions

### 1. Deploy Docker Registry

First, deploy the Docker registry to Huey:

```bash
# From the ansible directory
ansible-playbook -i inventory/hosts.yaml playbooks/00-system/042-docker-registry.yaml
```

### 2. Build and Push Your Image

On Huey, build and push your tealgardens.com image:

```bash
# SSH to Huey
ssh huey

# Navigate to the registry directory
cd /opt/docker-registry

# Build and push the image
./build-and-push.sh
```

### 3. Deploy to Kubernetes

Apply the ArgoCD manifests:

```bash
kubectl apply -f manifests/apps/appproj-tealgardens-com.yaml
kubectl apply -f manifests/apps/app-tealgardens-com.yaml
```

ArgoCD will automatically sync and deploy your application.

## Workflow

### For Updates

When you update your tealgardens.com repository:

1. **Build new image**:

   ```bash
   ssh huey
   cd /opt/docker-registry
   ./build-and-push.sh
   ```

2. **Redeploy** (optional - ArgoCD will auto-sync):

   ```bash
   kubectl rollout restart deployment/tealgardens-com -n tealgardens-com
   ```

### For New Versions

To deploy a new version:

1. Update the tag in `build-and-push.sh` (e.g., change `latest` to `v1.0.1`)
2. Update the image tag in `deployment.yaml`
3. Build and push the new image
4. Apply the updated manifests

## File Structure

- `deployment.yaml` - Kubernetes deployment using local registry image
- `service.yaml` - Service to expose the deployment
- `ingress.yaml` - Ingress for external access at tealgardens.com
- `kustomization.yaml` - Kustomize configuration

## Configuration

### Image Source

- **Registry**: `huey.local:5000`
- **Image**: `tealgardens-com:latest`
- **Repository**: `https://github.com/kh3dron/tealgardens.com.git`

### Domain

- **Host**: `tealgardens.com`
- **SSL**: Automatically provisioned by cert-manager

## Monitoring

Check the deployment status:

```bash
kubectl get pods -n tealgardens-com
kubectl logs -f deployment/tealgardens-com -n tealgardens-com
```

## Registry Management

View images in your local registry:

```bash
curl http://huey.local:5000/v2/_catalog
curl http://huey.local:5000/v2/tealgardens-com/tags/list
```

## Notes

- The deployment uses 2 replicas for high availability
- Health checks are configured for both liveness and readiness
- Resource limits are set to prevent resource exhaustion
- SSL certificates are automatically managed by cert-manager
