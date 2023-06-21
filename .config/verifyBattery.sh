#!/bin/bash

# Comprueba si el adaptador de corriente está conectado
check_power_status() {
  acpi -a | grep -q "on-line"
  return $?
}

# Comprueba el nivel actual de la batería
check_battery_level() {
  acpi -b | grep -Po '[0-9]+(?=%)'
}

# Notificación utilizando dunst
send_notification() {
  local message=$1
  dunstify -u normal "Gestión de batería" "$message"
}

# Suspender el sistema
suspend_system() {
  send_notification "¡La batería ha alcanzado el nivel crítico! El sistema se suspenderá en 10 segundos."
  sleep 10
  systemctl suspend
}

# Verifica el nivel de la batería y toma las acciones necesarias
check_battery() {
  local battery_level=$(check_battery_level)
  
  if [ $battery_level -le 5 ]; then
    suspend_system
  elif [ $battery_level -le 10 ]; then
    send_notification "Nivel de batería bajo: $battery_level%. Conéctate al cargador."
  elif [ $battery_level -le 20 ]; then
    send_notification "Nivel de batería moderado: $battery_level%. Conéctate al cargador."
  fi
}

# Verifica si el adaptador de corriente está conectado
if check_power_status; then
  send_notification "El cargador está conectado."
else
  send_notification "El cargador no está conectado."
fi

# Comprueba la batería cada 60 segundos
while true; do
  check_battery
  sleep 60
done

