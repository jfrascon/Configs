#!/usr/bin/env bash

# Make the followint link:
#ln -s $USER_CONFIG_PATH/Scripts/change_keyboard_layout_and_mouse_scrolling.sh $HOME/bin/change_keyboard_layout_and_mouse_scrolling.sh

#$1 is either the string 'customized'  (no quotes) or any other string, whatever, e.g., 'default'.
#$2 is either the string 'interactive' (no quotes) or the mouse's id (integral number)
bash $HOME/bin/change_keyboard_layout.sh $1
#bash $HOME/bin/change_mouse_scrolling.sh $1 $2


