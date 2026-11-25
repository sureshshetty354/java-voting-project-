
#!/bin/bash

set -euxo pipefail

exec > /var/log/voting-deployment.log 2>&1

echo "Starting Java Voting Application deployment"

# Update Linux
dnf update -y

# Install Java 17, Docker and Git on EC2
dnf install -y java-17-amazon-corretto-headless docker git

# Verify Java
java -version

# Start Docker
systemctl enable --now docker

# Download Java application from GitHub
cd /opt

git clone --depth 1 --branch main "${github_repo_url}" voting-app

cd /opt/voting-app

# Build Docker image
docker build -t java-voting-app:latest .

# Start Java application
docker run -d \
  --restart unless-stopped \
  --name voting-app \
  -p 80:8080 \
  java-voting-app:latest

echo "Java Voting Application deployment completed"

