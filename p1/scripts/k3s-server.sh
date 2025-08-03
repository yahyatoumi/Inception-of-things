#!/bin/bash
# Install K3s in server mode
SERVER_IP=$1

mkdir -p /home/vagrant/.kube

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip=$SERVER_IP --write-kubeconfig=/home/vagrant/.kube/config --write-kubeconfig-mode=644" sh -

TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)
mkdir -p /home/vagrant/token
echo "$TOKEN" > /home/vagrant/token/token.txt
