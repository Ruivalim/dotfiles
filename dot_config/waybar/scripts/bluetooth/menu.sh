#!/bin/bash

menu="Enable Bluetooth
Disable Bluetooth
Scan for Devices
Open Settings
Pair Device
Show Connected"

selection=$(echo "$menu" | wofi --dmenu --prompt "Bluetooth Options")

case "$selection" in
    "Enable Bluetooth")
        systemctl start bluetooth && bluetoothctl power on
        ;;
    "Disable Bluetooth")
        bluetoothctl power off && systemctl stop bluetooth
        ;;
    "Scan for Devices")
        bluetoothctl scan on
        ;;
    "Open Settings")
        blueman-manager
        ;;
    "Pair Device")
        blueman-assistant
        ;;
    "Show Connected")
        bluetoothctl devices Connected | wofi -dmenu -p "Connected"
        ;;
esac
