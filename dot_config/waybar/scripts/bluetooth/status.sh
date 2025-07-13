#!/bin/bash

if ! systemctl is-active --quiet bluetooth; then
    echo "#7f8c8d"
    exit 0
fi

if bluetoothctl show | grep -q "Powered: yes"; then
    echo "#3498db"
else
    echo "#7f8c8d"
fi
