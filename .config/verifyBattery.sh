 #!/bin/bash

export notification_sent_20=20
export notification_sent_10=10

while true; do
  
  battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
  battery_status=$(cat /sys/class/power_supply/BAT0/status)

    if [[ $battery_status == "Charging" ]]; then
      if [ $notification_sent_10 == 10]; then
        export notification_sent_10=9
      fi
      if [ $notification_sent_20 == 20]; then
        export notification_sent_20=19
      fi
    else
      if [[ $battery_level -le 5 ]]; then
        dunstify "Battery Warning" "Battery level is $battery_level%. Battery charge is very low. System will suspend to prevent data loss." -u critical
        sleep 20
        systemctl suspend
        break
      fi

      if [[ $battery_level -le 10 && $battery_level -gt 5 && ! $notification_sent_10  != 10 ]]; then
        dunstify "Battery Warning" "Battery level is $battery_level%. Battery charge is critical. Save your work and connect to a power source." -u normal
        export notification_sent_10=10
      fi 

      if [[ $battery_level -le 20 && $battery_level -gt 11 && $notification_sent_20 != 20 ]]; then
        dunstify "Battery Warning" "Battery level is $battery_level%. Connect to a power source immediately." -u low
        export notification_sent_20=20
      fi
    fi
    sleep 60  # Wait for 1 minute before checking the battery status again
done
