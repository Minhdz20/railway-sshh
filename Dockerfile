FROM ubuntu:22.04

# -----------------------------
# Install required packages
# -----------------------------
RUN apt update && apt install -y \
    openssh-server \
    curl \
    wget \
    unzip \
    sudo \
    python3 \
    && mkdir /var/run/sshd

# -----------------------------
# Create user 'root' with password
# -----------------------------
RUN echo "root:123456" | chpasswd

# -----------------------------
# Configure SSH
# -----------------------------
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'ClientAliveInterval 60' >> /etc/ssh/sshd_config && \
    echo 'ClientAliveCountMax 3' >> /etc/ssh/sshd_config

# -----------------------------
# Expose ports
# -----------------------------
EXPOSE 22

# -----------------------------
# Start SSH server directly
# -----------------------------
CMD ["/usr/sbin/sshd", "-D"]
