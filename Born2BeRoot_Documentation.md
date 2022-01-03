```
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Born2BeRoot_Documentation.md                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sel-kham <sel-kham@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/12/21 03:08:45 by sel-kham          #+#    #+#              #
#    Updated: 2021/12/21 20:49:07 by sel-kham         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
```
# Born2BeRoot
> This section is for **42Network** cursus, if you are not a **42Network** student you don't have to follow these instructions, and you can set your prefered configuration.
## Installation:
* You can follow this [video](https://www.youtube.com/watch?v=2w-2MX5QrQw) for the whole installation proccess.
## Basic configuration:
### SUDO
1. Switch to root user: ```su -``` Or ```su root```.
2. Install **sudo**:
```
$ sudo apt install sudo -y
```
* **apt**: Advanced Package Tool, or APT, is a free-software user interface that works with core libraries to handle the installation and removal of software on Debian, and Debian-based Linux distributions. [Wikipedia](https://en.wikipedia.org/wiki/APT_(software)).
* **sudo**: Or "**s**ubstitute **u**ser, **do**", is a program for Unix-like computer operating systems that enables users to run programs with the security privileges of another user, by default the superuser. [Wikipedia](https://en.wikipedia.org/wiki/Sudo).
2. Install **usermod**:
```
$ sudo apt install usermod -y
```
* **usermod**: The usermod command modifies the system account files to reflect the changes that are specified on the command line. [man page](https://linux.die.net/man/8/usermod).
3. Add your user to sudo group:
```
$ sudo usermod -aG sudo <username>
```
* **-aG**: The flags for *usermod* command, [RTFM](https://linux.die.net/man/8/usermod) for more information.
* **sudo**: The group that you need to add the user to (sudo in our example).
* **username**: The user which will be added to the specified group.
4. Add the user to sudoers file:
```
$ sudo touch /etc/sudoers.d/sudoers_config && sudo echo "[user_name]	ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/sudoers_config
```
5. Protect sudo and root privileges:
```
$ sudo echo "Default rootpw" >> /etc/sudoers.d/sudoers_config
```
6. Add a new group:
```
$ sudo addgroup user42
$ sudo adduser [user_name] user42
```
	- Check if the commands work:p
```
$ getent group user42
```
* By default, when you type *sudo + some_cmd* as a normal user, you are required to enter your own password. This command is for protecting sudo access by requesting root password.
* **This step is not required in Born2beroot subject**!
### SSH
* **Secure Shell (SSH)**, refers to the protocol by which network communications can take place safely and remotely via an unsecured network... [More](https://www.n-able.com/blog/ssh-network-protocol-overview)
1. Install **OpenSSH**:
```
$ sudo apt install openssh-server -y
```
2. Check SSH status:
```
$ sudo systemctl status ssh | grep "Active"
```
* The results: *Active: active (running)*.
3. Change the default SSH port from 22 to 4242:
```
$ sudo sed -i 's/#Port 22/Port 4242/g' /etc/ssh/sshd_config && sudo systemctl restart ssh && sudo systemctl reload ssh
```
* A port is A port is a virtual point where network connections start and end. Ports are software-based and managed by a computer's operating system. [More](https://www.cloudflare.com/learning/network-layer/what-is-a-computer-port/).
* This command is made from three parts:
	- **sed**: reads the specified files, modifying the input as specified by a list of commands. [RTFM](https://linux.die.net/man/1/sed) for more.
	- **&&**: Executes the command that follows the ```&&``` only if the first command is successful.
	- **systemctl**: is an init system and system manager, used here to ```restart``` and ```reload``` *SSH* service.
4. Disable SSH login for the root user:
```
$ sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config && sudo systemctl restart ssh && sudo systemctl reload ssh
```
* **sshd_config**: is an ASCII text based file where the different configuration options of the SSH server are indicated and configured with keyword/argument pairs.
* **PermitRootLogin**: Specifies whether root can log in using ssh.
### UFW
* **Uncomplicated Firewall (UFW)** provides a framework for managing netfilter, as well as a command-line interface for manipulating the firewall. [More](https://wiki.debian.org/Uncomplicated%20Firewall%20%28ufw%29).
1. Install UFW:
```
$ sudo apt install ufw -y
```
2. Setting up the default policies:
```
$ sudo ufw default deny incoming && sudo ufw default allow outgoing
```
* Block all the incoming traffic and allow all the outgoing traffic
3. Allowing specific connections:
```
$ sudo ufw allow 4242
```
* **4242**: The target port to allow incoming traffic from *4242* in our case.
4. Enable UFW:
```
$ sudo ufw enable
```
### Manage Hostname
* The **hostname** is what a device is called on a network, it's used to distinguish devices within a local network. In addition, computers can be found by others through the hostname, which enables data exchange within a network.
1. Update your machine hostname:
```
$ hostnamectl set-hostname *new_hostname*
```
### Strong Password Polcies
* For the sake of this section we will be using *libpam-pwquality* package, it's a set of tools that allow you to configure the refusal of weak passwords for root and user sessions. [More](https://debian-facile.org/doc:securite:passwd:libpam-pwquality).
* */etc/security/pwquality.conf* is where the configuration file for libpam-pwquality is located.
* */etc/login.defs* file provides default configuration information for several user account parameters.
1. Install libpam-pwquaality:
```
$ sudo apt install libpam-pwquality -y
```
2. Setting up password to expire every 30 days:
```
$ sudo sed -i 's/PASS_MAX_DAYS\t99999/PASS_MAX_DAYS\t30/g' /etc/login.defs
```
* **PASS_MAX_DAYS**	Maximum number of days a password may be used.
3. Days allowed before the modification of a password:
```
$ sudo sed -i 's/PASS_MIN_DAYS\t0/PASS_MIN_DAYS\t2/g' /etc/login.defs
```
* **PASS_MIN_DAYS**	Minimum number of days allowed between password changes.
4. Setting up a warning message 7 days before password expires:
```
$ sudo sed -i 's/PASS_WARN_AGE\t7/PASS_WARN_AGE\t7/g' /etc/login.defs
```
* **PASS_WARN_AGE**	Number of days warning given before a password expires.
5. The password must be at least 10 characters long:
```
$ sudo sed -i 's/# minlen = 8/minlen = 10/g' /etc/security/pwquality.conf
```
* **minlen**: Minimum size of the new password.
6. The password must contain at least one uppercase:
```
$ sudo sed -i 's/# ucredit = 0/ucredit = -1/g' /etc/security/pwquality.conf
```
* **ucredit**: Maximum number of uppercase charachters, if *ucredit < 0* it means at least *ucredit* uppercase charachters in the string. *i.e: ucredit = -1, means the password must contains at least one uppercase*.
7. The password must contain at least one digit:
```
$ sudo sed -i 's/# dcredit = 0/dcredit = -1/g' /etc/security/pwquality.conf
```
* **dcredit**: Maximum number of digit charachters, if *dcredit < 0* it means at least *dcredit* digit charachters in the string. *i.e: ucredit = -1, means the password must contains at least one digit*.
8. The password must not contain more than 3 consecutive identical charachters:
```
$ sudo sed -i 's/# maxclassrepeat = 0/maxclassrepeat = 3/g' /etc/security/pwquality.conf
```
* **dcredit**: Maximum nuber of consecutive identical characters in the password.
9. The password must not contain the name of the user:
```
$ sudo sed -i 's/# usercheck = 1/usercheck = 0/g' /etc/security/pwquality.conf
```
* **usercheck**: Checks whether the password contains the name of the user.
10.  The password must have at least 7 characters that are not part of the former password:
```
$ sudo sed -i 's/# difok = 1/difok = 7/g' /etc/security/pwquality.conf
```
* **difok**: Number of characters of the new password which are not present in the old one.
* This rules does not apply for root by default.
11.  Applying the previous policies to root:
```
$ sudo sed -i 's/# enforcing = 1/enforcing = 1/g' /etc/security/pwquality.conf
$ sudo sed -i 's/# enforce_for_root/enforce_for_root/g' /etc/security/pwquality.conf
```
* **enforce_for_root**: Specifies that even password of the root user must successfully pass the previous tests.
### Sudo authentication restriction
* Linux is more flixible than you thought. You can have a lot of freedom while using linux. Here are some exaples of what you can do:
1. Authentication using sudo has to be limited to 3 attempts in the event of an incorrect password:
```
$ sudo echo "Defaults	passwd_tries=3" >> /etc/sudoers.d/sudoers_config
```
2. Costume error message to be displayed in case of wrong password:
```
$ sudo echo "Defaults	badpass_message=\"*Your Costume message here/*\"" >> /etc/sudoers.d/sudoers_config
```
3. Logging **sudo** actions in the folder */var/log/sudo/*:
```
$ sudo mkdir -p /var/log/sudo/ && sudo touch /var/log/sudo/sudo.log
$ sudo echo "Defaults	logfile=/var/log/sudo/sudo.log" >> /etc/sudoers.d/sudoers_config
$ sudo echo "Defaults	log_input" >> /etc/sudoers.d/sudoers_config
$ sudo echo "Defaults	log_output" >> /etc/sudoers.d/sudoers_config
```
4. The **TTY** mode has to be enabled:
* **TTY** or **Teletype** is an abstract device in UNIX and Linux. Sometimes it refers to a physical input device such as a serial port, and sometimes it refers to a virtual TTY where it allows users to interact with the system, whenever you launch a terminal emulator or use any kind of shell in your system, it interacts with virtual TTYs that are known as pseudo-TTYs or PTY. [More details](https://www.linusakesson.net/programming/tty/index.php)
```
$ sudo echo "Defaults	requiretty" >> /etc/sudoers.d/sudoers_config
```
5. PATH configuration:
* PATH is an environmental variable in Linux and other Unix-like operating systems that tells the shell which directories to search for executable files in response to commands issued by a user.
```
$  sudo echo "Defaults	secure_path=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/snap/bin\"" >> /etc/sudoers.d/sudoers_config
```
### Monitoring shell file
1. This simple shelll script diisplays basic ystem information, will configuer cron to display it every 10 min on all users terminals. Before we can start with the script we need to install some services.
```
$ sudo apt install sysstat -y
$ sudo apt install net-tools -y
```
```
#!/bin/sh
OS_INFO=$(uname -a)
echo "# Architecture : $OS_INFO "
OS_INFO=$(cat /proc/cpuinfo | grep 'physical id' | wc -l)
echo "# Physical CPU : $OS_INFO"
OS_INFO=$(cat /proc/cpuinfo | grep 'processor' | wc -l)
echo "# vCPU : $OS_INFO"
TOTAL=$(free -m | grep 'Mem' | awk '{print $2}')
FREE=$(free -m | grep 'Mem' | awk '{print $4}')
PERCENT=$(free -m | grep 'Mem' | awk '{printf("%.2f", ($3*100/$2))}')
echo "# Memory Usage : $FREE/$TOTAL ($PERCENT%)"
TOTAL=$(df -Bg | grep 'LVMGroup' | awk '{SUM += $2} END {print SUM}')
FREE=$(df -Bm | grep 'LVMGroup' | awk '{SUM += $4} END {print SUM}')
PERCENT=$(df -Bg | grep 'LVMGroup' | awk '{SUM += $5} END {print SUM}')
echo "# Disk Usage : $FREE/$TOTAL""Gb ($PERCENT%)"
OS_INFO=$(mpstat | grep 'all' | awk '{print $6}')
echo "# CPU load : $OS_INFO%"
OS_INFO=$(who -b | awk '{print $3" "$4}')
echo "# Last boot : $OS_INFO"
OS_INFO=$(lsblk | grep 'lvm' | wc -l)
if [ $OS_INFO -eq 0 ]; then echo "# LVM use : no"
else echo "# LVM use : yes"
fi
OS_INFO=$(netstat -natp | grep 'tcp ' | grep 'LISTEN' | wc -l)
echo "# TCP Connections : $OS_INFO ESTABLISHED"
OS_INFO=$(users | wc -w)
echo "# User log : $OS_INFO"
OS_INFO=$(hostname -I)
MAC=$(ip a | grep 'link/ether' | awk '{print $2}')
echo "# Network : IP $OS_INFO($MAC)"
OS_INFO=$(cat /var/log/sudo/sudo.log | grep 'COMMAND=' | wc -l)
echo "# Sudo : $OS_INFO cmd"
```
2. schedule *monitoring.sh*  file to run every 10 mins:
	- The **cron** command-line utility, also known as cron job is a job scheduler on Unix-like operating systems. Users who set up and maintain software environments use cron to schedule jobs (commands or shell scripts) to run periodically at fixed times, dates, or intervals. [Wikipedia](https://en.wikipedia.org/wiki/Cron), [man](https://man7.org/linux/man-pages/man5/crontab.5.html).
```
$ sudo echo "*/10 * * * *    root    sh [directory to your monitoring file] | wall" >> /etc/crontab
$ sudo /etc/init.d/cron restart
$ sudo /etc/init.d/cron reload
```
## Bonus Part:
### Set up a WorPress website
* The purpose of this part is to be able to set up a WordPress site from scratch, WordPress is is an open-source CMS (Content Management System). It's is basically a tool that makes it easy to manage important aspects of your website. WordPress require basic services and hardwars to work properly:
	- Disk Space: 1GB+ 
	- Web Server: Apache or Nginx (We will be using Lighthttpd for the sake of this section).
	- Database: MySQL version 5.0.15 or greater or any version of MariaDB. (We will be using MariaDB as required in the subject)
	- RAM: 512MB+
	- PHP:  Version 7.3 or greater. (And it's modules).
	- Processor: 1.0GHz+
#### Install **Lighthttpd**
1. **HTTP Server**: The most popular web server on the Internet since April 1996. The Apache HTTP Server is a powerful and flexible HTTP/1.1 compliant web server. **lighttpd**: A secure, fast, compliant, and very flexible web-server that has been optimized for high-performance environments. **lighttpd** has a very low memory footprint compared to other webservers and takes care of cpu-load.
```
$ sudo apt update -y
$ sudo apt upgrade -y
$ sudo apt install lighttpd -y
$ sudo lighty-enable-mod fastcgi
$ sudo lighty-enable-mod fastcgi-php
```
2. Start & Enable Lighttpd Service: you have to start and enable the webserver service so that it can be started automatically even after rebooting the system or server.
```
$ sudo systemctl start lighttpd
$ sudo systemctl enable lighttpd
```
3. To check the status:
```
$ systemctl status lighttpd
```
4. Allow the default port: 80 on UFW
```
$ sudo ufw allow 80
```
5. To check if you Lighthttpd server working navigate to your IP address using a browser.
#### Install MariaDB
* **MariaDB** is an open source relational database management system, it was created as a software fork of MySQL by developers who played key roles in building the original database.
1. Install MariaDB:
```
$ sudo apt install mariadb-server -y
```
2. Remove insecure default settings:
```
$ sudo mysql_secure_installation
Enter current password for root (enter for none): # This is the password of root account of the mysql, don't confuse it with your root password. (Skip this if you would like to)
Switch to unix_socket authentication [Y/n]: n
Change the root password? [Y/n]: y # Update your password if you would like to.
Remove anonymous users? [Y/n]: y
Disallow root login remotely? [Y/n]: y
Remove test database and access to it? [Y/n]: y
Reload privilege tables now? [Y/n]: y
```
3. Create a new database:
```
$ sudo mariadb
> CREATE DATABASE [db_name];
```
4. Create an user and grant it all the privileges on the newlycreated database:
```
> GRANT ALL PRIVILEGES ON [database-name].* to '[username]' IDENTIFIED BY '[new-user-password]';
> exit
```
#### Install PHP
* PHP: (Hypertext Preprocessor) is a widely-used open source general-purpose scripting language that is especially suited for web development and can be embedded into HTML.
1. Install php and it's packages:
```
$ sudo apt install php-cgi php-mysql php7.4 -y
```
2. Here how to verify the installing:
```
$ php -v
```
#### Install WordPress
1. First we need to install **wget**:
```
$ sudo apt install wget -y
```
2. Then we will Download WordPress to */var/* directory:
```
$ sudo wget http://wordpress.org/latest.tar.gz -P /var/www/html
```
3. We need to extract the *tar* file:
```
$ sudo tar -xzvf /var/www/html/latest.tar.gz
$ sudo rm /var/www/html/latest.tar.gz
```
4. Copy WordPress files to the parent directory (*/var/www/html*):
```
$ sudo cp -r /var/www/html/wordpress/* /var/www/html
$ sudo rm -rf /var/www/html/wordpress
```
5. Basic WordPress configuration file:
```
$ sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
```
6. Insert your database and user information to WordPress config file:
```
$ sudo sed -i "s/define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', '[db_name]' );/g"  /var/www/html/wp-config.php
$ sudo sed -i "s/define( 'DB_USER', 'username_here' );/define( 'DB_USER', '[db_username]' );/g"  /var/www/html/wp-config.php
$ sudo sed -i "s/define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', '[user_pw]' );/g"  /var/www/html/wp-config.php
```
#### TCP Service
1. First we need to install **vsftpd**: the Very Secure File Transfer Protocol, and allow it default prot: 21.
Then, in the config file we need to enable any form of FTP write command. 
```
$ sudo apt install vsftpd -y
$ sudo ufw allow 21
$ sudo sed -i 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf
```

