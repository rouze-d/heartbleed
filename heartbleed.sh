#!/bin/bash
# github.com/rouze-d

YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
STAND=$(tput sgr 0)
BOLD=$(tput bold)

sub1="$1"
sub3="$3"

echo "
  ╻ ╻   ┏━╸   ┏━┓   ┏━┓   ╺┳╸   ┏┓    ╻     ┏━╸   ┏━╸   ╺┳┓
  ┣━┫   ┣╸    ┣━┫   ┣┳┛    ┃    ┣┻┓   ┃     ┣╸    ┣╸     ┃┃
  ╹ ╹   ┗━╸   ╹ ╹   ╹┗╸    ╹    ┗━┛   ┗━╸   ┗━╸   ┗━╸   ╺┻┛" | lolcat -p 0.7
echo -e ""
echo -e "$BLUE SSL heartbeat vulnerability (CVE-2014-0160)$STAND"
echo -e " Hope you found something. Have a nice day."

if [ -z $sub1 ]; then
    echo ""
    echo -e "Usage:"
    echo -e "$0  IP/sub.target.com -p <port>"
    exit
fi

if [ -z $sub3 ]; then
    echo ""
    echo -e "Usage:"
    echo -e "$0  IP/sub.target.com -p <port>"
    exit
fi

echo ""
timeout 6 nmap $sub1 -p $sub3 -Pn | grep open >> /dev/null
if [ "$?" != 0 ];then
    echo "$RED$BOLD $sub1 Down or Port $sub3 is Closed$STAND"
    exit
fi


echo  ""
echo -e "$GREEN ++++++$STAND SSL HEARTBEED$GREEN ++++++$STAND"
echo -e " target:$YELLOW$BOLD $sub1$STAND port:$YELLOW$BOLD $sub3$STAND"
echo  ""
timeout 5 java -jar modules/SSLServer.jar $sub1 $sub3
echo -e ""
timeout 5 python modules/HeartBleed.py $sub1 -p $sub3
echo -e "$GREEN +++++++++++++++++++++++++++$STAND"
echo ""
