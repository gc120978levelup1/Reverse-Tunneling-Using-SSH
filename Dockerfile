#FROM debian:latest
#RUN apt update
#COPY sshd_config /etc/ssh/
#RUN apt -y install sudo net-tools ufw openssh-server
#RUN netstat -tulpn
#RUN adduser garry
#RUN usermod -aG sudo garry
#RUN systemctl enable ssh

# ssh -p 2222 garry@localhost
# Expose ports for Web (80) and SSH (22)
# EXPOSE 80 22 2222 3306 5432 1433 20000 502
# EXPOSE 80

# Use a Debian-based image
FROM debian:stable

# Install OpenSSH server and create the necessary directory
RUN apt-get update 
RUN apt-get install -y openssh-server sudo net-tools iproute2 iputils-ping

# Set the root password (replace 'your_password' with your desired password)
RUN echo 'root:12345' | chpasswd
RUN adduser garry
RUN echo 'garry:12345' | chpasswd
RUN usermod -aG sudo garry
RUN adduser nestor
RUN echo 'nestor:12345' | chpasswd
RUN usermod -aG sudo nestor

# Allow root login via SSH (necessary for password-based login in a container environment)
COPY sshd_config /etc/ssh/
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\\s*required\\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Enable open-ssh server
RUN systemctl enable ssh

# Expose ports
EXPOSE 2222 20000-30000

# Start the SSH server when the container launches
CMD ["/usr/sbin/sshd", "-D"]



