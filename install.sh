#!/bin/bash

# Install Apache, MariaDB, PHP 8.1, and unzip  
sudo apt install apache2 mariadb-server php8.1 unzip php8.1-mbstring

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

# Prompt for admin username and password
read -p "Enter OpenEMR admin username: " admin_user   
read -p "Enter OpenEMR admin password: " admin_pass

# Prompt for hostname
read -p "Enter your server's hostname: " hostname   

# Install PHP extensions
sudo apt install php8.1-mysql php8.1-gd php8.1-xml php8.1-curl php8.1-zip   

# Activate extensions
sudo phpenmod mysql gd xml curl zip mbstring

# Edit PHP config
sudo nano /etc/php/8.1/apache2/php.ini   

# Set values  
short_open_tag = Off   
display_errors = Off
register_globals = Off
max_input_vars = 3000
max_execution_time = 60
max_input_time = -1
post_max_size = 30M
memory_limit = 256M
mysqli.allow_local_infile = On

# Save and exit 
ctrl + o
ctrl + x

# Download OpenEMR
wget https://sourceforge.net/projects/openemr/files/latest/download -O openemr.zip

# Unzip OpenEMR
unzip openemr.zip

# Move to Apache document root
sudo mv openemr /var/www/html/

# Import SQL schema
mysql -u $dbuser -p $dbname < /var/www/html/openemr/sql_upgrade.sql

# Edit Apache config
sudo nano /etc/apache2/apache2.conf

# Add lines
<Directory "/var/www/html/openemr">
                AllowOverride FileInfo=All
                Require all granted
</Directory>  

<Directory "/var/www/html/openemr/sites">
                AllowOverride None
</Directory>

<Directory "/var/www/html/openemr/sites/*/documents">
                Require all denied
</Directory>

# Save and exit
ctrl + o  
ctrl + x   

# Restart Apache
sudo systemctl restart apache2



# Open in web browser and complete setup
echo "OpenEMR installed! Access at http://$hostname/openemr"
echo "Complete the setup wizard. Then login with admin username '$admin_user' and password '$admin_pass'"

# Configure OpenEMR after setup
sudo nano /var/www/html/openemr/sites/default/config.php
# Set values for $host, $port, $login, $pass, $dbase

