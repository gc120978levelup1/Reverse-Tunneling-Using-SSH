# Access me like this
# ssh -i /path/to/private/key -p PORT USER_NAME@SERVERIP

RUN -d \
  --name=openssh-server \
  --hostname=openssh-server `#optional` \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e SUDO_ACCESS=false
  -e PASSWORD_ACCESS=false
  -e USER_NAME=userssh
  -p 2222:2222 \
  --restart unless-stopped \
  lscr.io/linuxserver/openssh-server:latest
  
# FROM linuxserver/openssh-server

RUN apt update -y
RUN apt-get update -y
RUN --rm -it --entrypoint /keygen.sh linuxserver/openssh-server

# mysql port
EXPOSE 3306

# mysql pgsql
EXPOSE 5432

# mssql port
EXPOSE 1433

# web server port
EXPOSE 80

# dnp3 port
EXPOSE 20000

# modbus port
EXPOSE 502

# ssh port
EXPOSE 22

