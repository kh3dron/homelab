# Docker Registry on Huey

This directory contains the setup for a local Docker registry running on Huey, which allows you to build and store Docker images locally for deployment to your Kubernetes cluster.

## Overview

The Docker registry runs on port 5000 and provides a local repository for storing Docker images. This is particularly useful for:

- Building images from your git repositories
- Storing images locally without relying on external registries
- Faster deployments since images are stored locally
- Better control over your image lifecycle

## Setup

### Automatic Setup (Recommended)

The Docker registry is automatically deployed to Huey via Ansible:

```bash
# From the ansible directory
ansible-playbook -i inventory/hosts.yaml playbooks/02-docker-registry/000-docker-registry.yaml
```

### Manual Setup

If you prefer to set it up manually on Huey:

1. Copy the files to Huey:

   ```bash
   scp -r docker-registry/ huey:/opt/
   ```

2. Run the setup script:

   ```bash
   ssh huey
   cd /opt/docker-registry
   ./setup.sh
   ```

## Usage

### Building and Pushing Images

Use the `build-and-push.sh` script to build and push your tealgardens.com image:

```bash
# On Huey
cd /opt/docker-registry
./build-and-push.sh
```

This script will:

1. Clone your tealgardens.com repository
2. Pull the latest changes
3. Build the Docker image
4. Push it to the local registry

### Manual Build and Push

You can also build and push manually:

```bash
# Clone your repo
git clone https://github.com/kh3dron/tealgardens.com.git
cd tealgardens.com

# Build the image
docker build -t huey.local:5000/tealgardens-com:latest .

# Push to registry
docker push huey.local:5000/tealgardens-com:latest
```

### Viewing Images

To see what images are in your registry:

```bash
curl http://huey.local:5000/v2/_catalog
```

To see tags for a specific image:

```bash
curl http://huey.local:5000/v2/tealgardens-com/tags/list
```

## Kubernetes Deployment

The Kubernetes manifests in `manifests/static-webapp/` are configured to pull from the local registry:

- Image: `huey.local:5000/tealgardens-com:latest`
- The deployment will automatically pull from the local registry

## Registry Management

### Stopping the Registry

```bash
cd /opt/docker-registry
docker-compose down
```

### Starting the Registry

```bash
cd /opt/docker-registry
docker-compose up -d
```

### Viewing Logs

```bash
cd /opt/docker-registry
docker-compose logs -f
```

## Storage

Images are stored in `/opt/docker-registry/data/` on Huey. Make sure you have sufficient disk space for your images.

## Security Notes

- The registry is currently configured without authentication for simplicity
- It's accessible on the local network at `huey.local:5000`
- For production use, consider adding authentication and TLS
