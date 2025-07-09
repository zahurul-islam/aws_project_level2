#!/bin/bash
yum update -y

# Install required packages
yum install -y httpd php php-mysql mysql-server

# Start and enable services
systemctl start httpd
systemctl enable httpd
systemctl start mysqld
systemctl enable mysqld

# Configure MySQL
mysql -e "CREATE DATABASE ${db_name};"
mysql -e "CREATE USER '${db_username}'@'localhost' IDENTIFIED BY '${db_password}';"
mysql -e "GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_username}'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# Download and install WordPress
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* .
rm -rf wordpress latest.tar.gz

# Configure WordPress
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/${db_name}/" wp-config.php
sed -i "s/username_here/${db_username}/" wp-config.php
sed -i "s/password_here/${db_password}/" wp-config.php

# Set proper permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Configure Apache
cat > /etc/httpd/conf.d/wordpress.conf << 'EOF'
<VirtualHost *:80>
    DocumentRoot /var/www/html
    ServerName localhost
    
    <Directory /var/www/html>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

# Restart Apache
systemctl restart httpd

# Install CloudWatch agent for monitoring
yum install -y amazon-cloudwatch-agent

echo "WordPress installation completed!"
