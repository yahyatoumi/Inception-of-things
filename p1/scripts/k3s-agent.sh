#!/bin/bash
SERVER_IP=$1
SERVER_PORT=$2
PRIVATE_IP=$3

# Read the token from the shared directory
TOKEN=$(cat /home/vagrant/token/token.txt)

# Install K3s in agent mode and join the cluster
curl -sfL https://get.k3s.io | K3S_URL=https://$SERVER_IP:$SERVER_PORT K3S_TOKEN=$TOKEN INSTALL_K3S_EXEC="--node-ip $PRIVATE_IP" sh -

echo "Done!"
