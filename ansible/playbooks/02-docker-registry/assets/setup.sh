#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Setting up Docker Registry on Huey...${NC}"

# Create necessary directories
mkdir -p data auth

# Start the registry
echo -e "${YELLOW}Starting Docker registry...${NC}"
docker-compose up -d

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Docker registry started successfully!${NC}"
    echo -e "${GREEN}Registry is available at: http://huey.local:5000${NC}"
    echo -e "${YELLOW}You can now build and push images to: huey.local:5000${NC}"
else
    echo -e "${RED}Failed to start Docker registry${NC}"
    exit 1
fi

# Test the registry
echo -e "${YELLOW}Testing registry connectivity...${NC}"
curl -s http://localhost:5000/v2/_catalog > /dev/null

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Registry is responding correctly!${NC}"
else
    echo -e "${YELLOW}Registry might still be starting up. Try again in a few seconds.${NC}"
fi 