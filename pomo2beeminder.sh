#!/bin/bash
#===========================================
# pomo2beeminder.sh created 2015.01.25
# Jun Go gojun077@gmail.com
#===========================================
# This script is designed to be launched by xfce4-timer-plugin
# after a 25-minute pomodoro timer completes. The user will be
# asked whether or not the pomodoro was completed without
# distractions. If the answer is 'y', the script will launch
# 'smtp-cli' which will send an email to the Beeminder bot
# to increment a pomodoro graph for a goal named 'pomodoro'
#
# This script has been tested with smtp-cli 3.6 and 3.7
# https://github.com/mludvig/smtp-cli (3.7)
# http://www.logix.cz/michal/devel/smtp-cli/ (3.6)

HOST=smtp.gmail.com
USER=gojun077@gmail.com
PW=$(<pass.txt)
FROM=gojun077@gmail.com
TO=bot@beeminder.com
SUBJ="gojun077/pomodoro"

echo -n "Did you successfully complete your pomodoro?(y/n)"
select ans in ("y" "n"); do
  case $ans in
    "y")
        if [ -f "/usr/bin/smtp-cli" ]; then
          smtp-cli --verbose --host=$HOST --enable-auth --user=$USER \
                   --pass=$PW --from=$FROM --to=$TO --subject=$SUBJ \
                   --body-plain='^ 1 "sent by pomo2beeminder.sh"' \
                   --charset=UTF-8
        else
          echo -e "Please install 'smtp-cli' package! Aborting.\n" 1>&2
          exit 1
        fi
        ;;
    "n")
        echo "Concentrate harder next time!"
        break
        ;;
    *)
        error "Unexpected input '$ans'"
        ;;
  esac
