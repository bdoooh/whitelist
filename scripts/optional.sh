#!/bin/bash
# This script will download and add domains from the rep to optional-list.txt file.
# Project homepage: https://github.com/anudeepND/optional-list
# Licence: https://github.com/anudeepND/optional-list/blob/master/LICENSE
# Created by Anudeep (Slight change by cminion)
#================================================================================
TICK="[\e[32m ✔ \e[0m]"


echo -e " \e[1m This script will download and add domains from the repo to optional-list.txt \e[0m"
sleep 0.1
echo -e "\n"

if [ "$(id -u)" != "0" ] ; then
	echo "This script requires root permissions. Please run this as root!"
	exit 2
fi

curl -sS https://raw.githubusercontent.com/anudeepND/optional-list/master/domains/optional-list.txt | sudo tee -a /etc/pihole/optional-list.txt >/dev/null
echo -e " ${TICK} \e[32m Adding to optional-list... \e[0m"
sleep 0.1
echo -e " ${TICK} \e[32m Removing duplicates... \e[0m"
mv /etc/pihole/optional-list.txt /etc/pihole/optional-list.txt.old && cat /etc/pihole/optional-list.txt.old | sort | uniq >> /etc/pihole/optional-list.txt

echo -e " [...] \e[32m Pi-hole gravity rebuilding lists. This may take a while... \e[0m"
pihole -g > /dev/null
 
echo -e " ${TICK} \e[32m Pi-hole's gravity updated \e[0m"
echo -e " ${TICK} \e[32m Done! \e[0m"


echo -e " \e[1m  Star me on GitHub, https://github.com/anudeepND/optional-list \e[0m"
echo -e " \e[1m  Happy AdBlocking :)\e[0m"
echo -e "\n\n"
