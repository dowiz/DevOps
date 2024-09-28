#! /bin/bash

### Update repos
apt update -y

### Install tools for docker
apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

### Added GPG Key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

### Add docker repo
add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

### Update repos 
apt update -y

### Install Docker
apt install -y docker-ce docker-ce-cli containerd.io

### Run Docker server
systemctl start docker

### Added docker to autostart
systemctl enable docker
