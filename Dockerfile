FROM php:8.4-apache
RUN apt update
RUN apt-get update -y

RUN apt-get install -y nodejs npm

# Install Additional System Dependencies
RUN apt install git zip libzip-dev zlib1g-dev libpq-dev -y

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql pdo_pgsql zip

# Copy the application code
COPY . /var/www/html

# Set the working directory
WORKDIR /var/www/html

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
COPY 000-default.conf /etc/apache2/sites-enabled/
# Enable Apache modules
RUN a2enmod rewrite
RUN apachectl restart
# RUN chown -R root:root /var/www/html
# RUN chmod -R 777 /var/www/html

# uncomment during production
RUN echo "Listen 0.0.0.0:80" >> /etc/apache2/apache2.conf
EXPOSE 80

# Install Apache and OpenSSH Server
RUN apt-get update && apt-get install -y \
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


