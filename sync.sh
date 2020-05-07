#!/bin/bash

if [ -e .uri ]; then
  REMOTE_URI=$(cat .uri)
  HOME_FOLDER="/home/pi/pi_kiosk"
  ACCOUNT_PATH=$(echo $REMOTE_URI | awk -F ":" '{print $2}')
  ACCOUNT_ID=$(echo $ACCOUNT_PATH | awk -F "media/" '{print $2}')
  LOG_FILE=$(echo $ACCOUNT_PATH | awk -F "/static" '{print $1}')/logs/${ACCOUNT_ID}.log
  SSH_ARGS="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
  # check for reboot request
  rsync --remove-source-files -avz -e "${SSH_ARGS}" ${REMOTE_URI}/tmp/.reboot ${HOME_FOLDER}/.reboot
  if [ -e ${HOME_FOLDER}/.reboot ]; then
    rm ${HOME_FOLDER}/.reboot
    sudo reboot
  fi
  # fetch all
  rsync -avz -L -e "${SSH_ARGS}" ${REMOTE_URI}/uploads/ ${HOME_FOLDER}/media/
  if rsync --stats -avz -e "${SSH_ARGS}" --rsync-path="rm -f ${LOG_FILE} && rsync --log-file=${LOG_FILE}" ${REMOTE_URI}/playlist ${HOME_FOLDER}/playlist | grep -q "Number of regular files transferred: 1"; then
    echo "NEW PLAYLIST!!!"
    export DISPLAY=:0
    export XAUTHORITY=~/.Xauthority
    WID=$(xdotool search --onlyvisible --class chromium|head -1)
    xdotool windowactivate ${WID}
    xdotool key ctrl+F5
  fi  
fi
