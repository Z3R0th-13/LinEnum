#!/bin/bash

#Simple enumeration script for Linux Operating Systems. It looks for common misconfigurations and basic enumeration of the target.

# ******************************************************************
# ******************************************************************
# **                                                              **
# **                          LinEnum                             **
# **                    Written by: Z3R0th                        **
# **                                                              **
# **                                                              **
# ******************************************************************
# ******************************************************************



#Loading colors into BASH
red='\e[1;31m' #red text
yellow='\e[0;33m' #yellow text
RESET="\033[00m" #normal text
orange='\e[38;5;166m' #orange text

PWD="$(pwd)" #Save current working directory as variable in order to return
Version="$(uname -a)" #Grab the kernel version
Hostname="$(hostname)" #Grab the hostname
Who="$(whoami)" #Who you are currently running as
ID="$(id)" #Permissions ish.
IP="$(ifconfig eth0 | grep 'inet' | cut -d' ' -f 10 | grep -v 'fe')" #IP assigned to eth0
Arch="$(getconf LONG_BIT)" #Architecture. Whether or not you're in 32 or 64 bit
Route="$(route)" #print routing table
Users="$(cat /etc/passwd | cut -d':' -f 1| grep -v 'irc'| grep -v 'gnats' | grep -v postgres | grep -v daemon | grep -v bin | grep -v games | grep -v sys | grep -v sync | grep -v lp| grep -v mail| grep -v news | grep -v uucp | grep -v proxy | grep -v 'www-data' | grep -v backup | grep -v list| grep -v nobody | grep -v 'systemd-timesync' | grep -v 'systemd-network' | grep -v 'systemd-resolve' | grep -v man | grep -v '_apt' | grep -v messagebus | grep -v mysql | grep -v avahi | grep -v miredo | grep -v ntp | grep -v stunnel4 | grep -v uuidd | grep -v 'Debian-exim' | grep -v statd | grep -v arpwatch | grep -v colord | grep -v epmd | grep -v couchdb | grep -v dnsmasq | grep -v geoclue | grep -v pulse | grep -v 'speech-dispatcher' | grep -v sshd | grep -v iodine | grep -v 'king-phisher' | grep -v redsocks | grep -v rwhod | grep -v sslh | grep -v rtkit | grep -v saned | grep -v usbmux | grep -v 'Debian-gdm' | grep -v 'beef-xss' | grep -v dradis| grep -v clamav | grep -v redis| grep -v 'Debian-snmp')" #Users outside of normal groups
DNS="$(cat /etc/resolv.conf | grep nameserver | cut -d ' ' -f 2)" #Default nameserver IP
GCC="$(gcc --version | grep gcc)" #GCC Version
SQL="$(mysql --version)" #SQL Version
Perl="$(perl --version | grep perl | grep subversion)" #Perl Version
Ruby="$(ruby --version)" #Ruby Version
Python="$(python -c 'import sys; print(".".join(map(str, sys.version_info[:3])))')" #Python Version. Not sure why but this prints at top of script?
PrintPath="$(echo $PATH)" #Current environment variables

#Chart to be printed. Shows variables that were grabbed for enumeration
echo " _______________________________________________________________________________________________________________________________________________________________________________________________________"
echo "|                                                                       "
echo "|   Name         | Description          |         Target Info           "
echo "|_______________________________________________________________________________________________________________________________________________________________________________________________________"
echo "|                                                                       "
echo "|   Version      | Kernel Running       | $Version"
echo "|   Hostname     | Hostname for system  | $Hostname"
echo "|   User         | Current User         | $Who"
echo "|   Permissions  | Current Permissions  | $ID"
echo "|   IP           | Current IP           | $IP"
echo "|   Architecture | CPU Architecture     | $Arch-bit"
echo "|   DNS          | Default Nameserver   | $DNS"
echo "|   GCC          | GCC Version          | $GCC"
echo "|   SQL          | SQL Version          | $SQL"
echo "|   Perl         | Perl Version         | $Perl"
echo "|   Ruby         | Ruby Version         | $Ruby"
echo "|   Python       | Python Version       | $Python"
echo "|   Path         | Path Variables       | $PrintPath"
echo "|_______________________________________________________________________________________________________________________________________________________________________________________________________"
echo " "

echo -e $yellow"========================================================================================================================================================================================================"$RESET
#Check to see if root. If you are root then dump hashes. 
CheckIfRoot="id -u"
Shadow="cat /etc/shadow | cut -d ':' -f1-2 | grep -v '*' | grep -v '!'"
if [[ "$CheckIfRoot" -eq 0 ]]; 
then echo -e $orange"Here are the hashes I was able to dump!\n" $RESET; eval $Shadow
else 
echo -e $red"Please escalate to Root to get hashes\n" $RESET
fi

echo -e $yellow"========================================================================================================================================================================================================"$RESET
#Dumps all iptables in place
IPTables="iptables -L -n -v"
echo -e $orange"Checking for firewall rules!\n" $RESET; $IPTables

echo -e $yellow"========================================================================================================================================================================================================"$RESET
#Dump all of the home directory folders
echo -e $orange"Here are all of the directories inside of /home"$RESET
Home="ls -alh"
cd /home; $Home
cd $PWD

echo -e $yellow"========================================================================================================================================================================================================"$RESET
#Check for SUID bit files. These can be used to escalate to root sometimes.
SUID="find / -perm -4000 2>/dev/null"
echo  -e $orange"Looking for SUID files! (***This could take a while***)\n" $RESET; eval $SUID

echo -e $yellow"========================================================================================================================================================================================================"$RESET
#Check to see if you're current user is allowed to sudo
Sudo="sudo -l"
echo -e $orange"There might be programs that can be 'sudoed' as the current user...\n" $RESET; $Sudo

echo -e $yellow"========================================================================================================================================================================================================"$RESET
#Dump crontab to see list of current cronjobs
Cron="cat /etc/crontab"
echo -e $orange"These are the current contents of crontab!\n" $RESET; $Cron

echo -e $yellow"========================================================================================================================================================================================================"$RESET
#Dump currently logged in users
LoggedIn="w"
echo -e $orange"The following users are logged in currently!\n" $RESET; $LoggedIn

echo -e $yellow"========================================================================================================================================================================================================"$RESET
#Check arp tables
Arp="arp -e"
echo -e $orange"Let's take a quick look at arp!\n" $RESET; eval $Arp

echo -e $yellow"========================================================================================================================================================================================================"$RESET
#Show possible areas to mount
PossibleMount="cat /etc/fstab"
echo -e $orange"Here is all of the static information for the filesystem\n" $RESET; $PossibleMount

echo -e $yellow"========================================================================================================================================================================================================"$RESET
#Show current conntections and open ports
Connections="netstat -anop | grep -v STREAM | grep -v DGRAM | grep -v unix | grep -v RefCnt | grep -v UNIX"
echo -e $orange"Here are the current connections and open ports!\n" $RESET; eval $Connections

echo -e $yellow"========================================================================================================================================================================================================"$RESET
#List current services on the machine. (+) means that it's running. (-) means that it is not running
Service="service --status-all | column"
echo -e $orange"Here is a list of the services available!\n" $RESET; eval $Service
echo " "
