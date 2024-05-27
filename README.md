# Azure DevOps Challenge

This project deploys an API and its database in an Azure Kubernetes Service (AKS) cluster using Terraform and Helm. The API is accessible externally while the database is not. The deployment is managed through a CI/CD pipeline using GitHub Actions.

## Project Structure

azure-devops-challenge/
├── .github/
│ └── workflows/
│ └── ci-cd.yaml
├── charts/
│ ├── api/
│ │ ├── Chart.yaml
│ │ ├── values.yaml
│ │ └── templates/
│ │ ├── deployment.yaml
│ │ └── service.yaml
│ └── database/
│ ├── Chart.yaml
│ ├── values.yaml
│ └── templates/
│ ├── deployment.yaml
│ ├── pvc.yaml
│ └── service.yaml
├── terraform/
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
├── database/
│ ├── Dockerfile
│ └── init.sql
├── api/
│ ├── Dockerfile
│ ├── package.json
│ ├── package-lock.json
│ └── server.js
├── README.md


## Prerequisites

- Azure CLI
- Terraform
- Helm
- Docker
- GitHub Account

## Environment Setup

### Install necessary tools


# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install Terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install Docker
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

# Configure Docker to be used without sudo
sudo usermod -aG docker ${USER}
su - ${USER}

# Verify installations
az --version
terraform --version
helm version
docker --version

# Infrastructure Deployment
Configure Terraform
Navigate to the terraform/ directory.

Initialize Terraform:

terraform init
terraform plan
terraform apply

# Deploy the Database
Build and push the Docker image for the database:

docker build -t myrepo/postgres:13 ./database
docker push myrepo/postgres:13

Deploy the database using Helm:

helm upgrade --install database ./charts/database

# Deploy the API

Build and push the Docker image for the API:

docker build -t myrepo/api:latest ./api
docker push myrepo/api:latest

Deploy the API using Helm:

helm upgrade --install api ./charts/api --set env.DATABASE_URL=postgres://myuser:mypassword@database:5432/mydatabase


# CI/CD Pipeline
The CI/CD pipeline in GitHub Actions is set up to automatically build and deploy the infrastructure and applications on each push to the main branch. Make sure to configure the secrets in GitHub:

DOCKER_USERNAME
DOCKER_PASSWORD
AZURE_CREDENTIALS
DATABASE_URL