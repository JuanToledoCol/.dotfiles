#!/bin/bash

while true; do
    battery_status=$(acpi -b | awk '{print $3}' | tr -d ',' | sed 's/,//g')
    battery_level=$(acpi -b | awk '{print $4}' | tr -d '%' | sed 's/,//g')
    if [ "$battery_status" == "Charging" ]; then
        if [ "$battery_level" == 100 ]; then
            dunstify "Battery charging complete" "Disconnected the charger." -u normal
        fi
    elif [ "$battery_status" == "Discharging" ]; then
        if [ "$battery_level" -le 20 ]; then
            dunstify "Baterry low $battery_level%" "Connect the charger." -u critical
        elif [ "$battery_level" -le 10 ]; then
            dunstify "Baterry very low $battery_level%" "Connect the charger now." -u critical
        elif [ "$battery_level" -le 5 ]; then
            dunstify "Battery very low $battery_level%" "The pc entry in mode 'Suspend'" -u critical
            sleep 30
            systemctl suspend
        fi
    fi
    sleep 10
done

