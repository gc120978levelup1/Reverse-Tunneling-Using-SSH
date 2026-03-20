FROM ubuntu:latest

# Install Apache and OpenSSH Server
RUN apt-get update && apt-get install -y \
    apache2 \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Configure SSH
RUN mkdir /var/run/sshd
# Replace 'password' with a secure password
RUN echo 'root:password' | chpasswd
# Allow root login via SSH (use with caution)
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Copy the startup script
COPY start.sh /start.sh

# Expose ports for Web (80) and SSH (22)
EXPOSE 80 22 3306 5432 1433 20000 502

# Start both services using the script
CMD ["/start.sh"]

