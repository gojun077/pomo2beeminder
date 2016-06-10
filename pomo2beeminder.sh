#!/bin/bash
#===========================================
# pomo2beeminder.sh created 2015.01.25
# https://github.com/gojun077/pomo2beeminder
# Jun Go gojun077@gmail.com
#===========================================
# This script is designed to be launched by xfce4-timer-plugin
# or pystopwatch after a 25-minute pomodoro timer completes.
# The user will be asked whether or not the pomodoro was completed
# successfully (without distractions). If the answer is 'y', the
# script will launch 'smtp-cli' which will send an email to the
# Beeminder bot to increment a Beeminder graph for a 'do more'
# goal named 'pomodoro'
#
# This script has been tested with smtp-cli 3.6 and 3.7
# https://github.com/mludvig/smtp-cli (3.7)
# http://www.logix.cz/michal/devel/smtp-cli/ (3.6)

# USAGE:
#./pomo2beeminder.sh <num_of_pomodoros>
# For example, if you completed two 25-minute pomodoros,
# ./pomo2beeminder.sh 2

POMPATH=$HOME/Documents/pomo2beeminder
HOST=smtp.gmail.com
USER=gojun077@gmail.com
PW=$(<$POMPATH/pass.txt)
FROM=gojun077@gmail.com
TO=bot@beeminder.com
SUBJ="gojun077/pomodoro"

ans=z  #initialize variable 'ans'

while [[ "$ans" != "y" || "$ans" != "n" ]]; do
  echo "Did you successfully complete your pomodoro?(y/n)"
  read -r ans

  case $ans in
    "y")
         if [ -f "/usr/bin/smtp-cli" ]; then
           smtp-cli --verbose --host=$HOST --enable-auth --user=$USER \
                    --pass="$PW" --from=$FROM --to=$TO --subject=$SUBJ \
                    --body-plain="^ $1 \"sent by pomo2beeminder.sh\"" \
                    --charset=UTF-8
           exit 0
         else
           echo -e "Please install 'smtp-cli' package! Aborting.\n" 1>&2
           exit 1
         fi
         ;;
    "n")
         echo "Concentrate harder next time!"
         exit 0
         ;;
    *)
         echo "Please answer y or n"
         ;;
  esac
done
