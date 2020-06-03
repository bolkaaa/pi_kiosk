#!/bin/bash

xset s noblank
xset s off
xset -dpms

unclutter -idle 0.5 -root &

sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences

/usr/bin/chromium-browser --kiosk --enable-kiosk-mode --enabled --touch-events --touch-events-ui --disable-ipv6 --disable-java --disable-restore-session-state --disable-sync --disable-translate --disk-cache-size=1 --media-cache-size=1 --noerrdialogs --disable-infobars --allow-file-access-from-files --autoplay-policy=no-user-gesture-required --incognito file:///home/pi/pi_kiosk/player/player.html
