#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=~/.Xauthority

xset s activate  # Force screen blank
xset s 1

unclutter -idle 0.5 -root &

sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences

/usr/bin/chromium-browser --noerrdialogs --disable-infobars --allow-file-access-from-files --autoplay-policy=no-user-gesture-required --kiosk file:///home/pi/pi_kiosk/player/player.html &

sleep 10
xset s reset && xset dpms force on
xset s noblank
xset s off
xset -dpms

