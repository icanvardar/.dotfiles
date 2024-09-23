#!/usr/bin/env bash

# ps -aux | grep workspace-saver | grep -v grep | awk '{ print $2 }' | xargs kill -9

dir_path="$HOME/.dotfiles/i3/.config/i3/workspaces"

if [ ! -d $dir_name ]; then
  mkdir -p $dir_path
fi

# OMG THIS LOOP BACKUPS MY LAYOUT, SWEEEEEEEET!
idx=9
while [ $idx -gt -1 ]; do
  path="$HOME/.dotfiles/i3/.config/i3/workspaces/workspace_$idx.json"

  current_layout=$(mktemp)
  i3-save-tree --workspace $idx >"$current_layout"

  if ! diff "$current_layout" "$path" >/dev/null 2>&1; then
    mv "$current_layout" "$path"
  else
    rm "$current_layout"
  fi

  idx=$((idx - 1))
done

python3 ~/.dotfiles/bin/.local/bin/workspace_formatter.py

notify-send "Workspaces saved."
