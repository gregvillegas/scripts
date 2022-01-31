#!/bin/bash
#
# Author: Greg Villegas
# Date: January 31, 2022
# Script: Install prerequisite/dependecies needed to install Zimbra Collaboration Tools
# OS: Ubuntu 20.04
# Zimbra Version: 8.8.15 Community Edition
#

### Enter domain
echo -n "Please enter your Domain name. Example microimageph.com : "
read DOMAIN

### Enter HOSTNAME
echo -n "Please enter your Hostname. Example mail : "
read HOSTNAME

### Enter IP Address
echo -n "Please enter your Public IP Address of the server: "
read IPADDRESS
echo "Allow your IP Address to the firewall"
echo "You can use https://www.whatismyip.com/ to check your Public IP Address"
echo -n "Please enter the Public IP Address that will access this server: "
read IPADDRESS2

echo "$HOSTNAME$DOMAIN"

## Install Firewall
echo "Install UFW firewall..."
apt -y install ufw

echo "Allow OpenSSH in the firewall..."
ufw allow OpenSSH
ufw allow from IPADDRESS2
### Enable firewall
ufw --force enable

touch /etc/fail2ban/jail.d/zimbra.local
echo "[zimbra-submission]" >> /etc/fail2ban/jail.d/zimbra.local
echo "enabled = true" >> /etc/fail2ban/jail.d/zimbra.local
echo "filter = zimbra-submission" >> /etc/fail2ban/jail.d/zimbra.local
echo "logpath = /var/log/zimbra.log" >> /etc/fail2ban/jail.d/zimbra.local
echo "maxretry = 3" >> /etc/fail2ban/jail.d/zimbra.local
echo "findtime = 3600" >> /etc/fail2ban/jail.d/zimbra.local
echo "bantime = 36000" >> /etc/fail2ban/jail.d/zimbra.local
echo "action = iptables-multiport[name=zimbra-submission, port="25,465,587", protocol=tcp]" >> /etc/fail2ban/jail.d/zimbra.local
echo " " >> /etc/fail2ban/jail.d/zimbra.local
echo "[zimbra-webmail]" >> /etc/fail2ban/jail.d/zimbra.local
echo "enabled = true" >> /etc/fail2ban/jail.d/zimbra.local
echo "filter = zimbra-webmail" >> /etc/fail2ban/jail.d/zimbra.local
echo "logpath = /opt/zimbra/log/mailbox.log" >> /etc/fail2ban/jail.d/zimbra.local
echo "maxretry = 3" >> /etc/fail2ban/jail.d/zimbra.local
echo "findtime = 3600" >> /etc/fail2ban/jail.d/zimbra.local
echo "bantime = 36000" >> /etc/fail2ban/jail.d/zimbra.local
echo "action = iptables-multiport[name=zimbra-webmail, port="80,443", protocol=tcp]" >> /etc/fail2ban/jail.d/zimbra.local
echo " " >> /etc/fail2ban/jail.d/zimbra.local
echo "[zimbra-admin]" >> /etc/fail2ban/jail.d/zimbra.local
echo "enabled = true" >> /etc/fail2ban/jail.d/zimbra.local
echo "filter = zimbra-admin" >> /etc/fail2ban/jail.d/zimbra.local
echo "logpath = /opt/zimbra/log/mailbox.log" >> /etc/fail2ban/jail.d/zimbra.local
echo "maxretry = 3" >> /etc/fail2ban/jail.d/zimbra.local
echo "findtime = 3600" >> /etc/fail2ban/jail.d/zimbra.local
echo "bantime = 36000" >> /etc/fail2ban/jail.d/zimbra.local
echo "action = iptables-multiport[name=zimbra-admin, port="7071", protocol=tcp]" >> /etc/fail2ban/jail.d/zimbra.local
echo " " >> /etc/fail2ban/jail.d/zimbra.local
echo "[zimbra-audit]" >> /etc/fail2ban/jail.d/zimbra.local
echo "enabled = true" >> /etc/fail2ban/jail.d/zimbra.local
echo "filter = zimbra" >> /etc/fail2ban/jail.d/zimbra.local
echo "logpath = /opt/zimbra/log/audit.log" >> /etc/fail2ban/jail.d/zimbra.local
echo "bantime = 600" >> /etc/fail2ban/jail.d/zimbra.local
echo "maxretry = 5"" >> /etc/fail2ban/jail.d/zimbra.local




## Install Fail2ban
echo "Install Fail2ban..."
apt -y install fail2ban





apt -y install dnsutils
apt -y install dirmngr --install-recommends


### create backup of /opt/zimbra/libexec/zmdkimkeyutil
ORIGINAL="/opt/zimbra/libexec/zmdkimkeyutil"
BACKUP="/opt/zimbra/backup/zmdkimkeyutil"

cp $ORIGINAL $BACKUP

sed -i 's/2048/1024/g' $ORIGINAL

### Zimbra Filname
FILE="https://files.zimbra.com/downloads/8.8.15_GA/zcs-8.8.15_GA_3869.UBUNTU18_64.20190918004220.tgz"

### Download zimbra
wget -C $FILE
 
 
 