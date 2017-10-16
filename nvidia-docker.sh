#!/usr/bin/env bash


# Add nvidia-docker repo
curl -L https://nvidia.github.io/nvidia-docker/gpgkey | \
apt-key add -
tee /etc/apt/sources.list.d/nvidia-docker.list <<< \
"deb https://nvidia.github.io/libnvidia-container/ubuntu16.04/amd64 /
deb https://nvidia.github.io/nvidia-container-runtime/ubuntu16.04/amd64 /
deb https://nvidia.github.io/nvidia-docker/ubuntu16.04/amd64 /"
apt-get update


# Install nvidia-docker2
apt-get install -y nvidia-docker2

# Set nvidia as default runtime to be used by eclipse che
cat << EOF > /etc/docker/daemon.json
{
    "default-runtime": "nvidia",
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
EOF

# Restart docker daemon
systemctl restart docker.service