#!/usr/bin/env bash

# First:
# sudo ln -s $HOME/Documents/Configurations/OS-User/Scripts/20-natural-scrolling.conf /usr/share/X11/xorg.conf.d/20-natural-scrolling.conf
# sudo chmod 777 /usr/share/X11/xorg.conf.d/20-natural-scrolling.conf
# ln -s $HOME/Documents/Configurations/OS-User/Scripts/change_mouse_scrolling.sh $HOME/bin/change_mouse_scrolling.sh

MOUSE_CONF_DIR="/usr/share/X11/xorg.conf.d"

# NATURAL SCROLLING

# This section does not work with Logitech G602 because there are two lines returned by xinput list
# refering to the same device, but with different id

#device_id=$(xinput list | awk '{if ($0 ~ /Optical Mouse/ || $0 ~ /Logitech M705/ || $0 ~ /Logitech USB Receiver/)
#{
#search=" ";
#n=split($0,array,search);
#for(i=1;i<=n;i++)
#{
#if(array[i] ~ /id=/)
#{
#printf("%s\n\n", substr(array[i],4,length(array[i])-3));
#}
#}
#}
#}'
#)
# ==================================================================
# Usage: change_mouse_scrolling.sh $1 $2
# where $1 can have the values: the string 'customized' (no quotes) or any other string.
#       $2 can have the values: the string 'interactive' (no quotes) or a number identifying the mouse's id.

if test "$2" = "interactive";then
    device_id=$(whiptail --title "Mouse device id" --inputbox "Enter the device id for the mouse:" 10 30 3>&1 1>&2 2>&3)
else
    device_id=$2
fi

if test -z $device_id;then
    echo "ERROR! - No device number found"
    exit
fi

echo "Device id:" $device_id

if test ! -z $device_id;then
    string=$(xinput list-props $device_id | grep "Scrolling Distance")
    echo $string
    property_number=$(echo $string | awk '{
    search=" ";
    n=split($0,array,search);
    for(i=1;i<=n;i++)
        {
            if(array[i] ~ /\(/)
                {
                    printf("%s\n\n", substr(array[i],2,length(array[i])-3));
                }
            }
        }')
        number=$(xinput list-props $device_id | grep "Scrolling Distance" | cut -d',' -f3)
    fi

    if test -z $property_number;then
        echo "ERROR! - No property number found"
        exit
    fi

    echo "Property number: " $property_number
    echo "Number: " $number
    echo $(grep VertScrollDelta $MOUSE_CONF_DIR/20-natural-scrolling.conf)
    echo $(grep HorizScrollDelta $MOUSE_CONF_DIR/20-natural-scrolling.conf)
    echo $(grep DialDelta $MOUSE_CONF_DIR/20-natural-scrolling.conf)
    echo -e "\n"

    case $1 in
        customized)
            if test ! -z $device_id;then
                xinput --set-prop $device_id $property_number -1 -1 -1
                num=$(grep VertScrollDelta $MOUSE_CONF_DIR/20-natural-scrolling.conf | cut -d '"' -f 4)
                if test $num -eq 1;then
                    # if number is -1 and it is changed 1 with -1 I end up having --1
                    sed -i 's/1/-1/g' $MOUSE_CONF_DIR/20-natural-scrolling.conf
                fi
            fi
            ;;
        *) # By default the normal keyboard layout is restored
            if test ! -z $device_id;then
                xinput --set-prop $device_id $property_number 1 1 1
                sed -i 's/-1/1/g' $MOUSE_CONF_DIR/20-natural-scrolling.conf
            fi
            ;;
    esac

    echo $(xinput list-props $device_id | grep "Scrolling Distance")
    echo $(grep VertScrollDelta $MOUSE_CONF_DIR/20-natural-scrolling.conf)
    echo $(grep HorizScrollDelta $MOUSE_CONF_DIR/20-natural-scrolling.conf)
    echo $(grep DialDelta $MOUSE_CONF_DIR/20-natural-scrolling.conf)
