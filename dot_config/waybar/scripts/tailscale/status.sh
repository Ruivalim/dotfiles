#!/bin/bash

if tailscale status >/dev/null 2>&1 && tailscale status | grep -q "100\."; then
    echo "#94e2d5"
else
    echo "#7f8c8d"
fi
