if systemctl is-active --quiet bluetooth; then
  blueman-manager
else
 systemctl start bluetooth
sleep 2

# Power on bluetooth controller
bluetoothctl power on

# Optional: Make discoverable
# bluetoothctl discoverable on

notify-send "Bluetooth" "Enabled" -t 2000
blueman-manager
fi
