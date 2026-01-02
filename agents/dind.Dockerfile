FROM jenkins/inbound-agent:latest

USER root

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    iptables \
    uidmap \
    docker.io && \
    rm -rf /var/lib/apt/lists/*

# Disable TLS (optional, recommended for CI)
ENV DOCKER_TLS_CERTDIR=""

# install kubectl (latest stable)
RUN curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/kubectl

# Docker daemon ports
EXPOSE 2375

# Start dockerd + Jenkins agent
ENTRYPOINT ["/bin/sh", "-c", "dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock & /usr/local/bin/jenkins-agent"]
