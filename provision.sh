#!/bin/bash

#
# provision.sh
# Prepares the Linux OS and controls the VM provision process.
#
# History
#   2020/06/22  mlohn     Created.
#
# Usage
#
#    provision.sh
#

if ! [ $(id -u) = 0 ]; then
   echo "This script must be run as root."
   exit 1
fi

echo "Installing which..."
sudo yum -y -t install which > /dev/null
echo "Installing wget..."
sudo yum -y -t install wget > /dev/null
echo "Installing curl..."
sudo yum -y -t install curl > /dev/null
echo "Installing openssl..."
sudo yum -y -t install openssl > /dev/null

sudo echo "$(hostname -I | awk '{print $1}')  $(hostname)" | sudo tee /etc/hosts
sudo echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4" | sudo tee -a /etc/hosts
sudo echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" | sudo tee -a /etc/hosts

cd /vagrant/provision/flyway && source ./install-flyway.sh
cd /vagrant/provision/OracleXE && source ./install-oracle-xe.sh

if [ `id -u oracle 2>/dev/null || echo -1` -ge 0 ];
   then
      ORACLE_GROUP=oinstall
      ORACLE_USER=oracle
   else
      ORACLE_GROUP=vagrant
      ORACLE_USER=vagrant
fi
echo $ORACLE_USER
cd /vagrant/provision/db-sample-schemas-18c && su $ORACLE_USER -c 'source ./install-sample-schemas.sh'
