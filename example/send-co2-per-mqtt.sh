#!/bin/sh

# (c) 2020 Thomas Wenzlaff
# send-co2-per-mqtt.sh

# Sendet jede Minuten die co2 Werte vom Sensor per MQTT an NODERED

while (true) do

   zeit=$(date +"%d.%m.%Y %H:%M")
   wert=$(sudo python -m mh_z19 --all 2&gt;%1)
   
   echo "Sende CO2 Messung: $wert um $zeit"
   # erstellen ein JSON Objekt
   
   sende="{ \"messung\":{\"satz\": [{\"zeitpunkt\":\"$zeit\" },$wert ]}}"

   mosquitto_pub -d -t co2 -m "$sende"

   sleep 60;
done;
