#!/bin/bash

#update ubuntu
sudo apt update -y
sudo apt upgrade -y

# Install Apache, MariaDB, PHP 8.1, and unzip  
sudo apt install apache2 mariadb-server php8.1 unzip php8.1-mbstring php8.1-mysql php8.1-gd php8.1-xml php8.1-curl php8.1-zip -y

# Enable Apache rewrite module  
sudo a2enmod rewrite  

# Start Apache and MariaDB
sudo systemctl start apache2  
sudo systemctl start mariadb  

# Run MariaDB secure installation
sudo mysql_secure_installation  

# Prompt for OpenEMR database name, username, and password
read -p "Enter OpenEMR database name: " dbname   
read -p "Enter OpenEMR database username: " dbuser
read -p "Enter OpenEMR database password: " dbpass

# Create OpenEMR database and user
mysql -u root -p -e "CREATE DATABASE $dbname; CREATE USER '$dbuser' IDENTIFIED BY '$dbpass'; GRANT ALL ON $dbname.* TO '$dbuser';"

# Prompt for hostname
read -p "Enter your server's hostname: " hostname   

# Activate extensions
sudo phpenmod mysql gd xml curl zip mbstring

# Edit PHP config
sudo mv /etc/php/8.1/apache2/php.ini /etc/php/8.1/apache2/php.ini.bk   
sudo mv ~/installopenemr/php.ini /etc/php/8.1/apache2/php.ini

# Download OpenEMR
sudo wget https://sourceforge.net/projects/openemr/files/latest/download -O openemr.zip

# Unzip OpenEMR
sudo unzip openemr.zip
sudo mv openemr-7.0.1 openemr

# Move to Apache document root
sudo mv openemr /var/www/html/

# Import SQL schema
#mysql -u $dbuser -p $dbname < /var/www/html/openemr/sql_upgrade.sql

# Edit Apache config
sudo mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bk
sudo mv /home/ubuntu/installopenemr/apache2.conf /etc/apache2/apache2.conf

# Restart Apache
sudo systemctl restart apache2



# Open in web browser and complete setup
echo "OpenEMR installed! Access at http://$hostname/openemr"
echo "Complete the setup wizard. Then login with admin username '$admin_user' and password '$admin_pass'"

# Configure OpenEMR after setup
sudo nano /var/www/html/openemr/sites/default/config.php
# Set values for $host, $port, $login, $pass, $dbase

