# vagrant-oracle-xe-dev

This vagrant configuration provides a CentOS 7 system with the following components:

* CentOS 7 without a desktop
* Flyway
* Oracle XE Database 18c
* [Oracle Sample Schemas loaded into XE database](https://github.com/oracle/db-sample-schemas)

Please use the user vagrant/vagrant to login into the virtual machine. welcome1 is used as
password for all Oracle components, like Database and all sample schemas.

Port 1521 (Oracle XE) and 5500 (Enterprise Manager) are automatically exposed by the VM.

## Installation and Configuration Steps

1. Ensure Oracle Virtual Box is installed and configured on your development machine.
   ([http://www.oracle.com/technetwork/server-storage/virtualbox/downloads/index.html](http://www.oracle.com/technetwork/server-storage/virtualbox/downloads/index.html))

2. Ensure Vagrant is installed and configured on your development machine.
   ([https://www.vagrantup.com/downloads.html](https://www.vagrantup.com/downloads.html))

3. Clone the project from git. The target folder is named PROJECT_HOME afterwards.

   ```
   $ git clone
   ```
4. Download Oracle Database Express Edition 18c to $PROJECT_HOME/provision/OracleXE/oracle-database-xe-18c-1.0-1.x86_64.rpm
   ([http://download.oracle.com/otn/linux/oracle18c/xe/oracle-database-xe-18c-1.0-1.x86_64.rpm](http://download.oracle.com/otn/linux/oracle18c/xe/oracle-database-xe-18c-1.0-1.x86_64.rpm))

5. You can fine tune the configuration by open the vagrant file. The following settings can be modified when the default is not suitable:

   ```
    s.env = {
             ORACLE_SID: "XE",
             ORACLE_PASSWORD: "weblogic1", => Password for Oracle XE database.
             ORACLE_CHARACTERSET: "AL32UTF8",
             ORACLE_BASE: "/opt/oracle", => Base directory where all Oracle software will be installed.
             ORACLE_HOME: "/opt/oracle/product/18c/dbhomeXE"
            }
   ```

6. Open a shell on your development machine and navigate to the folder vagrant-oracle-fmw12213-dev. Startup the VM:

   ```
   $ vagrant up
   ```

## Usage

### Start Virtual Machine

1. Open a shell on your development machine and navigate to the folder vagrant-oracle-xe-dev

2. Execute start command

   ```
   $vagrant up
   ```

### Stop Virtual Machine

1. Open a shell on your development machine and navigate to the folder vagrant-oracle-xe-dev

2. Execute stop command

   ```
   $ vagrant halt
   ```

### Login to Virtual machine

1. Open a shell on your development machine and navigate to the folder vagrant-oracle-xe-dev

2. Execute stop command

   ```
   $ vagrant ssh
   ```

**Note:** You can sudo su - oracle to switch to the oracle user. The oracle user owns the db installation.

### Update Virtual Machine

1. Open a shell on your development machine and navigate to the folder vagrant-oracle-xe-dev

2. Pull the latest changes from the git repository

3. Execute the following command. The virtual machine must be started!

   ```
   $ vagrant rsync
   $ vagrant provision
   ```

### Connecting to Oracle Database

- Hostname: localhost
- Port: 1521
- SID: XE
- PDB: XEPDB1
- EM Express port: 5500
- All passwords are auto-generated and printed on install

### Resetting password
You can reset the password of the Oracle database accounts (SYS, SYSTEM and PDBADMIN only) by switching to the oracle user (sudo su - oracle), then executing /home/oracle/setPassword.sh <Your new password>.

### Start/Stopp Oracle Database

1. Open a shell on your development machine and navigate to the folder vagrant-oracle-xe-dev

2. stop command

   ```
   $ vagrant ssh
   $ sudo -s
   $ /etc/init.d/oracle-xe-18c stop
   ```

3. start command

   ```
   $ vagrant ssh
   $ sudo -s
   $ /etc/init.d/oracle-xe-18c start
   ```

### Post Installation Steps

### Issues
