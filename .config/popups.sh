#!/bin/bash

# Monitorea las ventanas en tiempo real
xwininfo -root -tree |
while read -r line; do
  # Verifica si la línea contiene el título de la ventana
  if [[ $line == *"meet.jit.si is sharing your screen."* ]]; then
    # Extrae el identificador de ventana de la línea
    window_id=$(echo "$line" | awk '{print $1}')

    # Envía la ventana emergente al fondo
    xdotool windowunmap "$window_id"
  elif [[ $line == *"meet.jit.si is sharing a window."* ]]; then
    #Extrae el identificador de ventana de la línea
    window_id=$(echo "$line" | awk '{print $1}')

    # Envía la ventana emergente al fondo
    xdotool windowunmap "$window_id"
  fi
done

