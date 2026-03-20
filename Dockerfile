# Access me like this
# ssh -i /path/to/private/key -p PORT USER_NAME@SERVERIP

FROM lscr.io/linuxserver/openssh-server:latest
RUN apt-get update -y

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

