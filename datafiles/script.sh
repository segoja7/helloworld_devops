#!/bin/bash
# Update package manager sources
sudo apt-get update
#Install unzip
sudo apt install unzip
# Download AWS CLI https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html#cliv2-linux-install
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# Unzip and install the AWS CLI Console
unzip awscliv2.zip
sudo ./aws/install
# Download EKS CLI https://github.com/weaveworks/eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
# Move eksctl to /usr/local/bin
sudo mv /tmp/eksctl /usr/local/bin

# Donwload last version of kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

#Install Docker from snap
sudo snap install docker

# Adding Docker group and setting permissions
sudo groupadd docker
sudo usermod -aG docker ${USER}

# Install HELM (Debian/Ubuntu) https://helm.sh/es/docs/intro/install/
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

# aws IAM Authenticator
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/aws-iam-authenticator

## Install Terraform

# Add Hashicorp gpg signature
sudo apt update && sudo apt install gpg

#Download the signing key to a new keyring
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

#Verify the key's fingerprint
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

#Add the HashiCorp repo
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

#apt update!
sudo apt update

# Install Terraform
sudo apt install terraform

#versions
aws s3 ls
kubectl --help
sudo docker ps
terraform -v