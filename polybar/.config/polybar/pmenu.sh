#!/bin/bash

## Adapted from pmenu by Aditya Shakya

MENU="$(rofi -sep "|" -dmenu -i -p 'System' -location 3 -yoffset 40 -xoffset -10 -width 10 -hide-scrollbar -line-padding 4 -padding 10 -lines 5 -font "Fantasque Sans Mono 10" -theme lb <<< "Lock|Logout|Sleep|Reboot|Poweroff")"
            case "$MENU" in
                *Lock) i3lock ;;
                *Logout) i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit' ;;
                *Sleep) sudo zzz ;;
                *Reboot) sudo reboot ;;
                *Poweroff) sudo poweroff
            esac
