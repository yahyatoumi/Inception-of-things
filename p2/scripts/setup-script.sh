SERVER_IP="192.168.56.110"


# Install Docker
apt-get update
apt-get install -y ca-certificates curl gnupg git avahi-daemon libnss-mdns
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
usermod -aG docker vagrant

mkdir -p /home/vagrant/.kube

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip=$SERVER_IP --write-kubeconfig=/home/vagrant/.kube/config --write-kubeconfig-mode=644" sh -

cd app1

docker build -t app1-image .
docker save app1-image -o app1-image.tar
sudo k3s ctr images import app1-image.tar
kubectl apply -f app1.yaml

cd ..

# make app2 image
cd app2
docker build -t app2-image .
docker save app2-image -o app2-image.tar
sudo k3s ctr images import app2-image.tar
kubectl apply -f app2.yaml
cd ..

# make app3 image
cd app3
docker build -t app3-image .
docker save app3-image -o app3-image.tar
sudo k3s ctr images import app3-image.tar
kubectl apply -f app3.yaml
cd ..

# set up ingress
kubectl apply -f ingress/ingress.yaml

