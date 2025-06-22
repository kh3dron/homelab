#!/bin/bash

# Configuration
REGISTRY_HOST="huey.local"  # or your Huey's IP address
REGISTRY_PORT="5000"
IMAGE_NAME="tealgardens-com"
TAG="latest"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Building and pushing tealgardens.com to local registry...${NC}"

# Clone the repository if it doesn't exist
if [ ! -d "tealgardens.com" ]; then
    echo -e "${YELLOW}Cloning tealgardens.com repository...${NC}"
    git clone https://github.com/kh3dron/tealgardens.com.git
fi

# Navigate to the repository
cd tealgardens.com

# Pull latest changes
echo -e "${YELLOW}Pulling latest changes...${NC}"
git pull origin main

# Build the Docker image
echo -e "${YELLOW}Building Docker image...${NC}"
docker build -t ${REGISTRY_HOST}:${REGISTRY_PORT}/${IMAGE_NAME}:${TAG} .

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Docker image built successfully!${NC}"
else
    echo -e "${RED}Failed to build Docker image${NC}"
    exit 1
fi

# Push to local registry
echo -e "${YELLOW}Pushing to local registry...${NC}"
docker push ${REGISTRY_HOST}:${REGISTRY_PORT}/${IMAGE_NAME}:${TAG}

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Image pushed successfully to ${REGISTRY_HOST}:${REGISTRY_PORT}/${IMAGE_NAME}:${TAG}${NC}"
else
    echo -e "${RED}Failed to push image to registry${NC}"
    exit 1
fi

echo -e "${GREEN}Build and push completed successfully!${NC}" 