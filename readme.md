Download the shell Script by running
  wget https://github.com/shanesipe/installopenemr/blob/main/install.sh
   
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

    After installation completes, the script will prompt you to complete the OpenEMR setup wizard. Open your web browser and go to http://your-hostname/openemr.

    Follow the steps in the OpenEMR setup wizard. Use the admin username and password you entered in the script.

    After the setup wizard completes, OpenEMR will be installed and ready to use! You can log in with the admin account you created.

    (Optional) The script will also configure config.php with your database settings. You can review and modify this file as needed.
