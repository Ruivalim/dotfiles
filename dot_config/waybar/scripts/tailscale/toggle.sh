#!/bin/bash
# ~/.local/bin/tailscale-toggle

# Check if connected
if tailscale status >/dev/null 2>&1 && tailscale status | grep -q "100\."; then
    # Already connected, do nothing or show status
    notify-send "Tailscale" "Already connected" -t 2000
else
    # Not connected, try to connect
    tailscale up
    if [ $? -eq 0 ]; then
        notify-send "Tailscale" "Connected" -t 2000
    else
        notify-send "Tailscale" "Failed to connect" -t 2000
    fi
fi
