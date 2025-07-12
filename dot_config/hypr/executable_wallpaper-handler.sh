#!/bin/bash
WALLPAPER_DIR="$HOME/wallpapers"
MIN_INTERVAL=180
MAX_INTERVAL=900

while true; do
    INTERVAL=$(shuf -i $MIN_INTERVAL-$MAX_INTERVAL -n 1)
    
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)
    
    if [ -n "$WALLPAPER" ]; then
        TRANSITIONS=("fade" "wipe" "grow" "outer" "random")
        TRANSITION=${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}
        
        swww img "$WALLPAPER" --transition-type $TRANSITION --transition-duration $(shuf -i 1-3 -n 1)
        echo "Changed wallpaper to: $(basename "$WALLPAPER") with $TRANSITION transition"
    fi
    
    sleep $INTERVAL
done
