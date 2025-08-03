#!/bin/bash

# Add Docker's official GPG key:
apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
usermod -aG docker root

# Download correct kubectl binary and checksum
KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)

ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" ]]; then
  ARCH="amd64"
elif [[ "$ARCH" == "aarch64" ]]; then
  ARCH="arm64"
fi

curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl"
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl.sha256"

# Verify checksum
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

# Install kubectl
chmod +x kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Verify kubectl
kubectl version --client --output=yaml

curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

k3d cluster create mycluster -p "80:80@loadbalancer" -p "443:443@loadbalancer"
k3d kubeconfig write mycluster
export KUBECONFIG=$(k3d kubeconfig write mycluster)

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
echo "Waiting for pods..."
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=200s
echo "Argocd is ready"

kubectl apply -f ../confs/ingress.yaml
kubectl patch configmap argocd-cmd-params-cm -n argocd --type merge -p '{"data":{"server.insecure": "true"}}'

kubectl create namespace dev
kubectl get ns

kubectl rollout restart deployment argocd-server -n argocd

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > argocd-admin-password.txt

kubectl apply -f ../confs/application.yaml

echo "Waiting for pods"

# Wait until at least one pod appears in the namespace
while [[ $(kubectl get pods -n dev --no-headers | wc -l) -eq 0 ]]; do
  sleep 1
done

echo "Waiting for pods to be Ready..."

kubectl wait --for=condition=Ready pods --all -n dev --timeout=200s

echo "Ready."

