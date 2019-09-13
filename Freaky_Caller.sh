#!/system/xbin/bash

clear

RED="\033[01;31m"
GREEN="\033[01;32m"
YELLOW="\033[01;33m"
BLUE="\033[01;34m"
BOLD="\033[01;01m"
RESET="\033[00m"

banner()
{
echo -e """
${BLUE}===============================
       FREAKY CALLER 1.0
===============================${RESET}
Written by Shubham Vishwakarma
GIT: https://github.com/Shubhamvis98
"
}
banner

check_root()
{
	if [ ${UID} != 0 ]
	then
		echo -e "${RED}[!] TRY AS ROOT ${RESET}"
		sleep 2
		clear
		exit
	fi
}

# Check config file
if [ ! -f config ]
then
	echo -e "${RED}[!] Config file not found!${RESET}"
	echo
	sleep 1
	echo -e "${BLUE}[!] Creating config file...${RESET}"
	echo
	sleep 1
	echo """# Default config file
#
#       Freaky Caller 1.0
# Written by Shubham Vishwakarma
#
# Call Bomber that make multiple calls
# to a number
#
# https://github.com/shubhamvis98
#
# Works on rooted android devices

PH_NO='Put phone number here'
C_INT='Time interval between calls in seconds'
""">config
	echo
	echo -e """${BLUE}[!] Config file created${RESET}
Now put the phone number in config file using any text editor then re-execute this file """
	echo -e ${RED}
	sleep 0.5
	read -p "Press Enter to exit..."
	echo -e ${RESET}
	sleep 1
	clear
	exit
fi
#Config created

echo
check_root

source config

#Check Mobile Number
if [ ${#PH_NO} != 10 ]
then
	echo -e "${RED}ERROR: ${RESET}INCORRECT MOBILE NUMBER"
	sleep 2
	clear
	exit
fi

echo -e "${GREEN}Number to call:${RESET} ${PH_NO}"
echo 
echo -ne "${BLUE}[?] ENTER NUMBER OF CALLS:${RESET} "
read NOC
echo
echo -e "${BLUE}[?] ENTER HOURS AND MINUTES: "
echo
echo -ne "[?] HOURS:${RESET} "
read HOURS
HOUR=$HOURS
HOURS=$(( HOURS * 3600 ))
echo

echo -ne "${BLUE}[?] MINS:${RESET} "
read MINS
MINUTES=$MINS
MINS=$(( MINS * 60 ))

TIME=$(( HOURS + MINS ))
echo AFTER $HOUR HOURS AND $MINUTES MINUTES...
echo or
echo AFTER $TIME SECONDS...
echo
sleep $TIME

#LOOP START
x=1
while [ $x -le $NOC ]
do
echo "CALLING: $x"
echo
sleep 2
am start -a android.intent.action.CALL -d tel:${PH_NO}
echo
sleep 1
x=$(( $x + 1 ))
sleep ${C_INT}
done
#LOOP END

echo
echo "DONE!!!"
echo
