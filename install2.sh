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

# Install Node.js v18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install npm
sudo apt install npm

# Install build tools
sudo apt install build-essential

# Update npm
sudo npm install npm@latest -g

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

# Edit PHP config
sudo mv /etc/php/8.1/apache2/php.ini /etc/php/8.1/apache2/php.ini.bk   
sudo mv /home/ubuntu/installopenemr/php.ini /etc/php/8.1/apache2/php.ini

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

# Install Node.js dependencies and build assets
cd /var/www/html/openemr 
npm install
npm run build
npm run clean

# Restart Apache again
sudo systemctl restart apache2

# Download OpenEMR
wget https://sourceforge.net/projects/openemr/files/latest/download -O openemr.zip

# Unzip OpenEMR
unzip openemr.zip

# Move to Apache document root
sudo mv openemr /var/www/html/

# Import SQL schema
mysql -u $dbuser -p $dbname < /var/www/html/openemr/sql_upgrade.sql

# Open in web browser and complete setup
echo "OpenEMR installed! Access at http://$hostname/openemr" 
echo "Complete the setup wizard. Then login with admin username '$admin_user' and password '$admin_pass'"

