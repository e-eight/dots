#!/bin/bash

MENU="$(rofi -sep "|" -dmenu -i -p 'Layout' -location 3 -yoffset 40 -xoffset -10 -width 8 -hide-scrollbar -line-padding 4 -padding 10 -lines 2 -font "Fantasque Sans Mono 10" -theme lb <<< "Colemak|US")"
            case "$MENU" in
                *Colemak) setxkbmap -layout us -variant colemak ;;
                *US) setxkbmap -layout us ;;
            esac
