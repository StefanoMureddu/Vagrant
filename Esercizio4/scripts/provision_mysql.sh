#!/bin/bash
echo "MySql provisioning - begin"
#installare mysql-server
sudo apt-get install mysql-server -y
#impostare la pw di root
sudo /etc/init.d/mysql stop
sudo mysqld_safe --skip-grant-tables &
mysql -uroot
use mysql;
update user set authentication_string=PASSWORD("Password&1") where User='root';
flush privileges;
quit
#abilitare le connessioni da altri server
echo "Updating bind address"
sudo sed -i "s/.*bind-address.*/bind-address = 10.0.2.2/" /etc/mysql/my.cnf
#riavviare mysql in modo da applicare le modifiche
echo "Restarting mysql service"
sudo service mysql restart
echo "MySql provisioning - end"

