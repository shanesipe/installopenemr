Download the shell Script by running
  
  sudo git clone https://github.com/shanesipe/installopenemr
   
   cd installopenemr

    Make the script executable by running:

sudo chmod 700 install.sh

    Run the script with sudo:

sudo ./install.sh

    The script will prompt you to enter:

    OpenEMR database name
    OpenEMR database username
    OpenEMR database password
    OpenEMR admin username
    OpenEMR admin password
    Your server's hostname

Enter the requested information.

    The script will install Apache, MariaDB, PHP, and all required extensions. It will also download and install the OpenEMR software.
    php.ini files
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

    After installation completes, the script will prompt you to complete the OpenEMR setup wizard. Open your web browser and go to http://your-hostname/openemr.

    Follow the steps in the OpenEMR setup wizard. Use the admin username and password you entered in the script.

    After the setup wizard completes, OpenEMR will be installed and ready to use! You can log in with the admin account you created.

    (Optional) The script will also configure config.php with your database settings. You can review and modify this file as needed.
