#!/bin/bash

set -e

echo "Updating package index..."
sudo apt update

echo "Installing prerequisites..."
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg

echo "Adding Docker GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Updating package index..."
sudo apt update

echo "Installing Docker..."
sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo "Enabling Docker service..."
sudo systemctl enable --now docker

echo "Adding current user to docker group..."
sudo usermod -aG docker "$USER"

echo
echo "Docker installation completed!"
echo
echo "Verify installation:"
echo "  docker --version"
echo "  docker compose version"
echo
echo "To use Docker without sudo, log out and log back in,"
echo "or run:"
echo "  newgrp docker"