#!/bin/bash

xset -dpms       # Turn off dpms blanking until next boot
xset s activate  # Force screen blank
xset s 1

unclutter -idle 0.5 -root &

sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences

/usr/bin/chromium-browser --noerrdialogs --disable-infobars --allow-file-access-from-files --autoplay-policy=no-user-gesture-required --kiosk file:///home/pi/pi_kiosk/player/player.html &

sleep 10         # Allow time for booting and starting browser. Adjust as necessary
xset s reset     # Force screen on
xset s 0         # Disable blanking until next boot
