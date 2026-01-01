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
    uidmap && \
    rm -rf /var/lib/apt/lists/*

# Install Docker
RUN curl -fsSL https://get.docker.com | sh

# Disable TLS (optional, recommended for CI)
ENV DOCKER_TLS_CERTDIR=""

# Docker daemon ports
EXPOSE 2375

# Start dockerd + Jenkins agent
ENTRYPOINT ["/bin/sh", "-c", "dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock & /usr/local/bin/jenkins-agent"]
