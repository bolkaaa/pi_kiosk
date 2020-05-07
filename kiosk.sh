#!/bin/bash

xset -display :0 dpms force off

unclutter -idle 0.5 -root &

sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences

/usr/bin/chromium-browser --noerrdialogs --disable-infobars --allow-file-access-from-files --autoplay-policy=no-user-gesture-required --kiosk file:///home/pi/pi_kiosk/player/player.html &

sleep 10

xset -display :0 dpms force on

xset s noblank
xset s off
xset -dpms
