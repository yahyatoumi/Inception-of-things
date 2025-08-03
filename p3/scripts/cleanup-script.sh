#!/bin/bash

set -e

echo "🚨 Starting cleanup..."

# Stop and delete k3d cluster
echo "🧹 Deleting k3d cluster..."
k3d cluster delete mycluster || true

# Remove ArgoCD password file
echo "🧹 Removing ArgoCD password file..."
rm -f argocd-admin-password.txt

# Remove kubectl binary and checksum
echo "🧹 Removing kubectl..."
sudo rm -f /usr/local/bin/kubectl
rm -f kubectl kubectl.sha256

# Remove Docker and related packages
echo "🧹 Removing Docker and related packages..."
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo apt-get autoremove -y
sudo rm -rf /etc/apt/keyrings/docker.asc
sudo rm -f /etc/apt/sources.list.d/docker.list

# Remove k3d binary
echo "🧹 Removing k3d..."
sudo rm -f /usr/local/bin/k3d

# Optionally remove KUBECONFIG env and default config file
unset KUBECONFIG
rm -f ~/.kube/config

echo "✅ Cleanup complete."
