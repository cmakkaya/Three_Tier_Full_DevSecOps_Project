# Three-Tier Full DevSecOps Project

Effectively utilized ArgoCD on Kubernetes to build a CI/CD pipeline with GitOps.

💡 This project demonstrates how modern organizations deliver software in a secure, automated, and scalable way using CI/CD, Kubernetes, and GitOps.

## 🔑 Key Workflow

| Stage                  | Tools             | Purpose                                   |
|-------------------------|------------------|-------------------------------------------|
| 📂 Source Control       | **GitHub**        | Version management & collaboration        |
| ⚡ Continuous Integration | **GitHub Actions** | Orchestrates pipeline                     |
| 🔑 Secret Scanning      | **Gitleaks**      | Detects hardcoded secrets                 |
| 🧹 Code Quality         | **SonarQube**     | Static analysis & maintainability         |
| 🛡️ Security             | **Trivy**         | Container & dependency vulnerability scanning |
| ✅ Testing              | **Jest / npm test** | Unit & integration tests                  |
| 📦 Build                | **Docker**        | Image build & push                        |
| 🔔 Deployment Trigger   | **Webhooks**      | Updates GitOps repo                       |
| 🌊 Continuous Delivery  | **ArgoCD**        | Syncs apps on Kubernetes                  |
| 🏗️ Infrastructure       | **Terraform + EKS** | Cloud-native cluster provisioning         |
| |


🔔 Deployment triggers via webhooks that update the GitOps repository

🌊 Continuous Delivery (CD) with ArgoCD, which keeps the Kubernetes cluster in sync and deploys the Frontend, Backend, and MySQL services

🏗️ Create EKS cluster using Terraform


## Project Overview

The repository includes a basic Node.js API along with a React frontend, designed as a user management demo.
You can set it up locally by following the steps below:

## 🛠️ Local Setup

   ```bash
# 1. Install Node.js (version 18 or later is recommended).

# 2. Install dependencies
cd api && npm install
cd ../client && npm install

# 3. Start API
cd api
npm start

# 4. Start frontend in another terminal
cd client
npm start
   ```

🔗 Access the app  http://localhost:3000 in your browser to access the app.

🎉 The client will now show an animated welcome banner.

-------------------

# 🛠️ DevOps Tooling Setup Guide on Linux 

This guide installs and configures the AWS CLI, Terraform, kubectl, eksctl, and sets up:
✔️ EBS CSI (storage)
✔️ NGINX Ingress (traffic)
✔️ cert-manager (TLS/SSL)


## 📦 Install AWS CLI

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install
aws configure
```

## 📥 Install Terraform

```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt-get update && sudo apt-get install terraform -y

terraform -version
```


## ☸️ Configure kubeconfig for EKS

```bash
aws eks --region ap-south-1 update-kubeconfig --name devopsshack-cluster
```


## 🖥️ Install kubectl

```bash
curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
```


## 📡 Install eksctl

```bash
curl -sLO "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz"
tar -xzf eksctl_$(uname -s)_amd64.tar.gz
sudo mv eksctl /usr/local/bin
eksctl version
```


## 🔗 Associate IAM OIDC Provider with EKS

```bash
eksctl utils associate-iam-oidc-provider \
  --region ap-south-1 \
  --cluster devopsshack-cluster \
  --approve
```

## 🛡️ Create IAM Service Account for EBS CSI Driver

```bash
eksctl create iamserviceaccount \
  --region ap-south-1 \
  --name ebs-csi-controller-sa \
  --namespace kube-system \
  --cluster devopsshack-cluster \
  --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --approve \
  --override-existing-serviceaccounts
```

## 📦 Deploy Add-ons

### 💾 EBS CSI Driver

```bash
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.11"
```

### 🌐 NGINX Ingress Controller

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
```

### 🔑 cert-manager

```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
```


------------
### Connect with me 📫 You can learn more about me

- 🌐 [LinkedIn](https://www.linkedin.com/in/cumhurakkaya/)
- ✏️ [Medium Articles](https://cmakkaya.medium.com/)  100+ Articles
- 🌐 [GitHub](https://github.com/cmakkaya/)
------------

#### 📌 Credit: This Project source codes adapted from Aditya Jaiswal’s repository. I would like to thank him for his valuable sharing.🙏
