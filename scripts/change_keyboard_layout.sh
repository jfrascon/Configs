#!/usr/bin/env bash

# Make the followint link:
# ln -s $USER_CONFIG_PATH/Scripts/change_keyboard_layout.sh $HOME/bin/change_keyboard_layout.sh

case $1 in
    customized)
        #xmodmap -e "remove lock = Caps_Lock"
        #xmodmap -e "remove control = Control_L"
        #xmodmap -e "keycode 66  = Control_L"
        #xmodmap -e "keycode 37 = Caps_Lock"
        #xmodmap -e "add lock = Caps_Lock"
        #xmodmap -e "add control = Control_L"

        xmodmap -e "keycode 52 = z Z z Z less guillemotleft guillemotleft less z Z"
        xmodmap -e "keycode 53 = x X x X greater guillemotright guillemotright greater x X"
        ;;
    *) # By default the normal keyboard layout is restored
        #xmodmap -e "remove lock = Caps_Lock"
        #xmodmap -e "remove control = Control_L"
        #xmodmap -e "keycode 66 = Caps_Lock"
        #xmodmap -e "keycode 37 = Control_L"
        #xmodmap -e "add lock = Caps_Lock"
        #xmodmap -e "add control = Control_L"

        xmodmap -e "keycode 52 = z Z z Z guillemotleft less guillemotleft less z Z"
        xmodmap -e "keycode 53 = x X x X guillemotright greater guillemotright greater x X"
        ;;
esac
