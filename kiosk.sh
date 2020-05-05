#!/bin/bash

xset s noblank
xset s off
xset -dpms

/usr/bin/chromium-browser --noerrdialogs --disable-infobars --allow-file-access-from-files --autoplay-policy=no-user-gesture-required file:///home/pi/pi_kiosk/player/player.html
