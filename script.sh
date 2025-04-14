#!/bin/bash

title="StickyNote"
note_file="$HOME/.scratchpad.md"
editor="nvim -n"  # Disables swap file creation

touch "$note_file"

if ! hyprctl clients | grep -q "$title"; then
    alacritty --title "$title" -e $editor "$note_file" &
    exit
fi

win_address=$(hyprctl clients | awk -v title="$title" '
    $0 ~ "window" { win = $2 }
    $0 ~ "title: "title { print win }
')

if [ -n "$win_address" ]; then
    hyprctl dispatch focuswindow address:$win_address
    hyprctl dispatch togglefloating address:$win_address
fi