# Reverse-Tunneling-Using-SSH
It enables a local database server to be accessed  from the internet

You can expose your MySQL server to the internet using a reverse SSH tunnel, which securely forwards traffic from a public remote server to your local machine (behind a firewall). This requires a public "jump host" that is accessible from the internet.

### Prerequisites
1. A local machine running the MySQL server and an SSH client. 
2. A remote, publicly accessible server with an SSH server (sshd) running and a user account you can access. This will act as the public endpoint.
3. The GatewayPorts option enabled in the SSH server's configuration file (/etc/ssh/sshd_config) on the remote server. 

### Step-by-Step Guide In the Remote (Exposed to Internet Machine)
  On your public remote server, you must allow it to bind to a publicly available port so that other clients can connect to it. 

1. Edit the SSH daemon configuration file using an editor like nano
```sh
sudo nano /etc/ssh/sshd_config
```

2. Add or modify the GatewayPorts line to yes
```sh
GatewayPorts yes
```

3. Restart the SSH service to apply the change
```sh
sudo systemctl restart sshd
```

### Step-by-Step Guide In the Local (Hidden Behind the Firewall)
  On your private local server, (behind the firewall), run the following command to establish the persistent reverse tunnel to the remote server: 
  
1. Run the command below as shown format in the local ssh client
```sh
ssh -R [remote-port]:localhost:[local-mysql-port] [user]@[remote-host-ip] -N
```

-R: Specifies a reverse port forwarding (remote to local).
[remote-port]: The port on the public remote server that clients will connect to (e.g., 33061).
localhost:[local-mysql-port]: The destination of the forwarded traffic, which is your local MySQL server (typically localhost:3306).
[user]@[remote-host-ip]: Your SSH username and the public IP address/hostname of the remote server.
-N: Prevents the execution of a remote command, ensuring only the tunnel is created. 
Leave this terminal window open; the tunnel remains active as long as the connection persists. 
 
2. example real world command from you client machine
```sh
ssh -R 33061:localhost:3306 gc120978@remote-ssh-server -N
```

3. note that the localhost part can be any ip address that can be reached by the ssh client locally.
   for example if the mySQL server has no ssh client software but locally another pc has ssh client then
   localhost part can be replaced by the ip address of the MySQL Server (ip addr: 192.168.1.25 at port 3306)
   and use the pc ssh client as the bridge.

place this command in the bridge local pc with ssh client:
```sh
ssh -R 33061:192.168.1.25:3306 gc120978@remote-ssh-server -N
```

or both port is the same value, which is a much better solution.
```sh
ssh -R 3306:192.168.1.25:3306 gc120978@remote-ssh-server -N
```

### Connect to MySQL from the Internet 

External users (or your own remote applications) can now connect to your local MySQL server by pointing their MySQL clients to the remote server's address and the specified remote port: 
Host: [remote-host-ip]
Port: [remote-port] (e.g., 33061)
MySQL Username & Password: Use the credentials for your local MySQL database. 

You can use a GUI tool like MySQL Workbench by selecting the "Standard TCP/IP over SSH" connection method and providing the necessary details for both the SSH connection and the MySQL database. 

Security Best Practices
Use SSH Keys: Always use public/private key pairs for authentication instead of passwords, and protect your private keys with passphrases.
Restrict User Permissions: Create a dedicated, restricted SSH user account for tunneling purposes only (you can use /sbin/nologin to prevent interactive shell access).
Limit MySQL Access: Configure your MySQL server to only accept connections from localhost (127.0.0.1) to ensure all traffic goes through the secure tunnel.
Monitor Logs: Regularly audit SSH connection logs to track who is accessing the tunnel. 

------------------------------------------------------------------

Copy a file from host to local
```sh
scp username@remote_host:/path/on/remote/server/file_to_copy /path/on/local/machine/
```

# Better use CLOUDFLARED TUNNEL! whole lot easier.


