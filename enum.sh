#!/bin/bash

echo "******************************************************************"
echo "******************************************************************"
echo "**                                                              **"
echo "**                           Enum                               **"
echo "**                    Written by: Z3R0th                        **"
echo "**                                                              **"
echo "**                                                              **"
echo "******************************************************************"
echo "******************************************************************"

printf "If you're running in a limited shell try running the following command: python -c \'import pty;pty.spawn(\"/bin/bash\")'\n"

echo "*********************************************************************************************"
echo "*********************************************************************************************"

Version="uname -a"
printf "The current kernel running is: "; $Version

echo "*********************************************************************************************"
echo "*********************************************************************************************"

printf "The hostname for this machine is: "; hostname

echo "*********************************************************************************************"
echo "*********************************************************************************************"

Who=whoami
printf "You are currently running as: "; $Who

echo "*********************************************************************************************"
echo "*********************************************************************************************"

ID=id
printf "You currently have the following permissions: "; $ID

echo "*********************************************************************************************"
echo "*********************************************************************************************"

IP="ifconfig eth0 | grep 'inet' | cut -d' ' -f 10 | grep -v 'fe'"
printf "Your current local IP is: "; eval $IP

echo "*********************************************************************************************"
echo "*********************************************************************************************"

Arch="getconf LONG_BIT"
printf "You are currently in a ";$Arch | tr -d "\n"; printf ' bit machine\n'

echo "*********************************************************************************************"
echo "*********************************************************************************************"

Route=route
printf "The routing table is as follows:\n"; $Route

echo "*********************************************************************************************"
echo "*********************************************************************************************"

Users="cat /etc/passwd | cut -d':' -f 1| grep -v 'irc'| grep -v 'gnats' | grep -v postgres | grep -v daemon | grep -v bin | grep -v games | grep -v sys | grep -v sync | grep -v lp| grep -v mail| grep -v news | grep -v uucp | grep -v proxy | grep -v 'www-data' | grep -v backup | grep -v list| grep -v nobody | grep -v 'systemd-timesync' | grep -v 'systemd-network' | grep -v 'systemd-resolve' | grep -v man | grep -v '_apt' | grep -v messagebus | grep -v mysql | grep -v avahi | grep -v miredo | grep -v ntp | grep -v stunnel4 | grep -v uuidd | grep -v 'Debian-exim' | grep -v statd | grep -v arpwatch | grep -v colord | grep -v epmd | grep -v couchdb | grep -v dnsmasq | grep -v geoclue | grep -v pulse | grep -v 'speech-dispatcher' | grep -v sshd | grep -v iodine | grep -v 'king-phisher' | grep -v redsocks | grep -v rwhod | grep -v sslh | grep -v rtkit | grep -v saned | grep -v usbmux | grep -v 'Debian-gdm' | grep -v 'beef-xss' | grep -v dradis| grep -v clamav | grep -v redis| grep -v 'Debian-snmp'"
printf "The following are users exist on this machine:\n"; eval $Users

echo "*********************************************************************************************"
echo "*********************************************************************************************"

CheckIfRoot="id -u"
Shadow="cat /etc/shadow | cut -d ':' -f1-2 | grep -v '*' | grep -v '!'"
if [[ "$CheckIfRoot" -eq 0 ]]; 
then printf "Here are the hashes I was able to dump!\n"; eval $Shadow
else 
printf "Please escalate to Root to get hashes\n"
fi

echo "*********************************************************************************************"
echo "*********************************************************************************************"

IPTables="iptables -L -n -v"
printf "Checking for firewall rules!\n"; $IPTables

echo "*********************************************************************************************"
echo "*********************************************************************************************"

Home="ls -alh /home/*/"
printf "Let's look at some home directories!\n"; $Home

echo "*********************************************************************************************"
echo "*********************************************************************************************"

SUID="find / -perm -4000 2>/dev/null"
printf "Looking for SUID files! (***This could take a while***)\n"; eval $SUID

echo "*********************************************************************************************"
echo "*********************************************************************************************"

Sudo="sudo -l"
printf "There might be programs that can be 'sudoed' as the current user...\n"; $Sudo

echo "*********************************************************************************************"
echo "*********************************************************************************************"

Cron="cat /etc/crontab"
printf "These are the current contents of crontab!\n"; $Cron

echo "*********************************************************************************************"
echo "*********************************************************************************************"

SSH="ls /home/*/.ssh"
printf "Checking for any files for SSH...results may vary...\n"; $SSH

echo "*********************************************************************************************"
echo "*********************************************************************************************"

DNS="cat /etc/resolv.conf"
printf "Looking for default name servers!\n"; $DNS

echo "*********************************************************************************************"
echo "*********************************************************************************************"

LoggedIn="w"
printf "The following users are logged in currently!\n"; $LoggedIn

echo "*********************************************************************************************"
echo "*********************************************************************************************"

GCC="gcc --version | grep gcc"
printf "Checking to see if GCC is installed and which version it is!\n"; eval $GCC

echo "*********************************************************************************************"
echo "*********************************************************************************************"

SQL="mysql --version"
printf "Checking to see if MySQL is installed and which version it is!\n"; $SQL

echo "*********************************************************************************************"
echo "*********************************************************************************************"

Perl="perl --version | grep perl"
printf "Checking to see if Perl is installed and which version it is!\n"; eval $Perl

echo "*********************************************************************************************"
echo "*********************************************************************************************"

Ruby="ruby --version"
printf "Checking to see if Ruby is installed and which version it is!\n"; $Ruby

echo "*********************************************************************************************"
echo "*********************************************************************************************"

Python="python --version"
printf "Checking to see if Python is installed and which version it is!\n"; $Python

echo "*********************************************************************************************"
echo "*********************************************************************************************"

printf "The current environmental variables are: "; echo $PATH

echo "*********************************************************************************************"
echo "*********************************************************************************************"

Arp="arp -e"
printf "Let's take a quick look at arp!\n"; eval $Arp

echo "*********************************************************************************************"
echo "*********************************************************************************************"

PossibleMount="cat /etc/fstab"
printf "Here is all of the static information for the filesystem\n"; $PossibleMount

echo "*********************************************************************************************"
echo "*********************************************************************************************"

Connections="netstat -anop | grep -v STREAM | grep -v DGRAM | grep -v unix | grep -v RefCnt | grep -v UNIX"
printf "Here are the current connections and open ports!\n"; eval $Connections

echo "*********************************************************************************************"
echo "*********************************************************************************************"

Service="service --status-all | column"
printf "Here is a list of the services available!\n"; eval $Service

echo "*********************************************************************************************"
echo "*********************************************************************************************"
