# Inception of Things (IoT)

<div align="center">

![42 School](https://img.shields.io/badge/42-School-000000?style=flat&logo=42&logoColor=white)
![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=flat&logo=kubernetes&logoColor=white)
![Vagrant](https://img.shields.io/badge/vagrant-%231563FF.svg?style=flat&logo=vagrant&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=flat&logo=docker&logoColor=white)

*A 42 School system administration project introducing Kubernetes from a developer perspective*

</div>

## 📋 Table of Contents

- [About](#about)
- [Project Structure](#project-structure)
- [Technologies Used](#technologies-used)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Project Parts](#project-parts)
  - [Part 1: K3s and Vagrant](#part-1-k3s-and-vagrant)
  - [Part 2: K3s and Applications](#part-2-k3s-and-applications)
  - [Part 3: K3d and Argo CD](#part-3-k3d-and-argo-cd)
  - [Bonus: GitLab Integration](#bonus-gitlab-integration)
- [Learning Objectives](#learning-objectives)
- [Resources](#resources)
- [Author](#author)

## 🎯 About

**Inception of Things** is a system administration project from 42 School that aims to introduce students to Kubernetes from a developer perspective. This project focuses on setting up small clusters and discovering the mechanics of continuous integration.

By the end of this project, you will have:
- A working Kubernetes cluster in Docker
- A usable continuous integration pipeline for applications
- Hands-on experience with modern DevOps tools and practices

## 📁 Project Structure

```
inception-of-things/
├── p1/                     # Part 1: K3s and Vagrant
│   ├── Vagrantfile
│   ├── scripts/
│   │   └── setup-script.sh
│   └── confs/
├── p2/                     # Part 2: K3s and Applications
│   ├── Vagrantfile
│   ├── scripts/
│   └── confs/
├── p3/                     # Part 3: K3d and Argo CD
│   ├── scripts/
│   │   └── setup-script.sh
│   └── confs/
├── bonus/                  # Bonus: GitLab Integration with Ansible
│   ├── scripts/
│   ├── confs/
│   ├── group_vars/        # Ansible variables
│   ├── playbooks/         # Ansible playbooks
└── README.md
```

## 🛠 Technologies Used

- **[Vagrant](https://www.vagrantup.com/)** - Virtual machine management
- **[K3s](https://k3s.io/)** - Lightweight Kubernetes distribution
- **[K3d](https://k3d.io/)** - K3s in Docker
- **[Docker](https://www.docker.com/)** - Containerization platform
- **[Argo CD](https://argoproj.github.io/argo-cd/)** - GitOps continuous delivery tool
- **[Kubernetes](https://kubernetes.io/)** - Container orchestration
- **[GitLab](https://gitlab.com/)** - DevOps platform (Bonus)
- **[Ansible](https://www.ansible.com/)** - Configuration management and automation (Bonus)

## 📋 Prerequisites

Before running this project, ensure you have the following installed:

- **VirtualBox** (≥ 6.1)
- **Vagrant** (≥ 2.2)
- **Docker** (≥ 20.10)
- **kubectl** (Kubernetes CLI)
- **Ansible** (≥ 2.9) - For bonus part
- **Git**

### System Requirements
- RAM: 4GB minimum (8GB recommended)
- Disk Space: 10GB free space
- OS: Linux, macOS, or Windows with WSL2

## 🚀 Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yahyatoumi/Inception-of-things.git
   cd Inception-of-things
   ```

2. **Make scripts executable:**
   ```bash
   find . -name "*.sh" -exec chmod +x {} \;
   ```

3. **Verify prerequisites:**
   ```bash
   vagrant --version
   docker --version
   kubectl version --client
   ansible --version  # For bonus part
   ```

## 💻 Usage

Each part of the project can be run independently. Navigate to the respective directory and follow the instructions below.

### Quick Start
```bash
# For Part 1
cd p1 && vagrant up

# For Part 2  
cd p2 && vagrant up

# For Part 3
cd p3 && ./scripts/setup-script.sh
```

## 📚 Project Parts

### Part 1: K3s and Vagrant

**Objective:** Set up a basic K3s cluster using Vagrant

**What you'll learn:**
- Virtual machine provisioning with Vagrant
- K3s installation and configuration
- Basic Kubernetes cluster setup

**Setup:**
```bash
cd p1
vagrant up
```

**Verification:**
```bash
vagrant ssh
kubectl get nodes
```

### Part 2: K3s and Applications

**Objective:** Deploy multiple applications with Kubernetes Ingress

**What you'll learn:**
- Kubernetes deployments and services
- Ingress controller configuration
- Load balancing and routing

**Features:**
- Multiple application deployments
- Ingress-based routing
- Service mesh basics

**Setup:**
```bash
cd p2
vagrant up
```

### Part 3: K3d and Argo CD

**Objective:** Implement GitOps with Argo CD using K3d

**What you'll learn:**
- K3d cluster management
- GitOps principles and practices
- Argo CD installation and configuration
- Continuous deployment pipelines

**Setup:**
```bash
cd p3
./scripts/setup-script.sh
```

**Access Argo CD:**
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
# Visit: https://localhost:8080
```

### Bonus: GitLab Integration with Ansible

**Objective:** Integrate GitLab with the K3d cluster using Ansible for automated CI/CD

**What you'll learn:**
- Ansible playbook development
- Infrastructure automation with Ansible
- GitLab Runner setup and configuration
- CI/CD pipeline configuration
- Integration with Kubernetes using Ansible
- Advanced GitOps workflows with automation

**Features:**
- Automated GitLab deployment using Ansible
- Ansible-managed Kubernetes resources
- Configuration management with Ansible variables
- Automated CI/CD pipeline setup

**Setup:**
```bash
cd bonus
# Configure your inventory and variables
ansible-playbook -i inventory/hosts playbooks/deploy.yml
```

## 🎓 Learning Objectives

By completing this project, you will gain practical experience with:

- **Container Orchestration:** Understanding Kubernetes concepts and operations
- **Infrastructure as Code:** Using Vagrant for reproducible environments
- **Configuration Management:** Automating deployments with Ansible
- **GitOps:** Implementing continuous deployment with Argo CD
- **Service Mesh:** Managing microservices communication
- **DevOps Practices:** Setting up complete CI/CD pipelines
- **System Administration:** Managing clusters and deployments

## 📖 Resources

### Official Documentation
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [K3s Documentation](https://docs.k3s.io/)
- [K3d Documentation](https://k3d.io/v5.4.6/)
- [Argo CD Documentation](https://argo-cd.readthedocs.io/)
- [Ansible Documentation](https://docs.ansible.com/)
- [Vagrant Documentation](https://www.vagrantup.com/docs)

### Useful Commands

**Vagrant:**
```bash
vagrant up          # Start VMs
vagrant ssh         # SSH into VM
vagrant halt        # Stop VMs
vagrant destroy     # Remove VMs
```

**Kubernetes:**
```bash
kubectl get pods                    # List pods
kubectl get services               # List services
kubectl describe pod <pod-name>    # Pod details
kubectl logs <pod-name>            # Pod logs
```

**K3d:**
```bash
k3d cluster create <name>          # Create cluster
k3d cluster list                   # List clusters
k3d cluster delete <name>          # Delete cluster
```

## 🤝 Contributing

This is a school project, but suggestions and improvements are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -am 'Add some improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Create a Pull Request
