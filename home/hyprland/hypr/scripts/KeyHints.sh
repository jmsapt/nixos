#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Keyhints. Idea got from Garuda Hyprland

# Detect monitor resolution and scale
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

# Calculate width and height based on percentages and monitor resolution
width=$((x_mon * hypr_scale / 100))
height=$((y_mon * hypr_scale / 100))

# Set maximum width and height
max_width=1200
max_height=1000

# Set percentage of screen size for dynamic adjustment
percentage_width=70
percentage_height=70

# Calculate dynamic width and height
dynamic_width=$((width * percentage_width / 100))
dynamic_height=$((height * percentage_height / 100))

# Limit width and height to maximum values
dynamic_width=$(($dynamic_width > $max_width ? $max_width : $dynamic_width))
dynamic_height=$(($dynamic_height > $max_height ? $max_height : $dynamic_height))

# Launch yad with calculated width and height
yad --width=$dynamic_width --height=$dynamic_height \
    --center \
    --title="Keybindings" \
    --no-buttons \
    --list \
    --column=Key: \
    --column=Description: \
    --column=Command: \
    --timeout-indicator=bottom \
"Programs" "" "" \
"  SPACE" "App Launcher" "wofi" \
"  ENTER" "Open Terminal (HOME)" "kitty" \
"  ENTER" "Open Terminal (CWD)" "kitty" \
"  E" "Open File Manager" "thunar" \
"  J" "Open Browser" "firefox" \
"  SHIFT J" "Open Private Browser" "firefox" \
"" "" "" \
"Window Management" "" "" \
"  Q" "Close Active Window" "" \
"  [0-9]" "Change Focused Workspace" "" \
"  SHIFT [0-9]" "Move Active Window to Workspace" "" \
"  [     ]" "Change Focused Window Directionally" "" \
"  SHIFT [     ]" "Resize Window" "" \
"  TAB" "Cycle Workspaces" "" \
"  X" "Toggle Pseudo Tiling" "" \
"  C" "Toggle Split" "" \
"  V" "Toggle Floating" "" \
"" "" "" \
"Miscellaneous" "" "" \
"  SHIFT S" "Screen Shot (Region)" "" \
"" "" "" \
"CNTRL ALT DELETE" "Quit Hyprland Session" "" \
