Installation

To install OpenEMR, follow these steps:

Clone this repository:

    sudo git clone https://github.com/shanesipe/installopenemr 

Change to the repository directory:

    cd installopenemr

Make the install script executable:

    sudo chmod 700 install.sh

Run the install script with sudo:

    sudo ./install.sh

 The script will prompt you to enter:

 OpenEMR database name
 OpenEMR database username
 OpenEMR database password
 Your server's hostname

Enter the requested information.

    The script will install Apache, MariaDB, PHP, and required extensions. It will also download and install OpenEMR.

    After installation completes, the script will prompt you to complete the OpenEMR setup wizard. Go to http://your-hostname/openemr.

    Follow the steps in the OpenEMR setup wizard. Use the admin username and password you entered in the script.

    After the setup wizard completes, OpenEMR will be installed and ready to use! You can log in with the admin account you created.

(Optional) The script will also configure config.php with your database settings. You can review and modify php.ini files.
