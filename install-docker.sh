#!/bin/bash
set -e

echo "Updating system..."
sudo dnf update -y

echo "Installing Docker..."
sudo dnf install -y docker

echo "Starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Adding current user to the docker group..."
sudo usermod -aG docker $USER

echo "Verifying installation..."
docker --version
sudo docker run hello-world

echo ""
echo "=========================================="
echo "Docker installation completed successfully!"
echo "Log out and log back in (or run 'newgrp docker')"
echo "to use Docker without sudo."
<<<<<<< HEAD
echo "=========================================="
=======
echo "=========================================="
>>>>>>> 8a5de5b (initial commit)
