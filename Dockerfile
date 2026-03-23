FROM lscr.io/linuxserver/openssh-server:latest

COPY sshd_config /etc/ssh/

RUN apk add net-tools

RUN netstat -tulpn
# Expose ports for Web (80) and SSH (22)
# EXPOSE 80 22 2222 3306 5432 1433 20000 502
EXPOSE 80



