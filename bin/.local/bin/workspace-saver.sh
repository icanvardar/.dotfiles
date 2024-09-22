#!/usr/bin/env bash

ps -aux | grep workspace-saver | grep -v grep | awk '{ print $2 }' | xargs kill -9

# loads MY PRECIOUS LAYOUTS
idx=9
while [ $idx -gt -1 ]; do
  path="$HOME/.dotfiles/i3/.config/i3/workspaces/$idx.json"
  i3_data=$(i3-save-tree --workspace $idx 2>/dev/null)
  workspace_data=$(cat $path)

  if [ ! -f "$path" ] || ! diff <(echo "$i3_data") <(echo "$workspace_data") >/dev/null 2>&1; then
    i3-msg "workspace $idx; append_layout $path"
  fi

  idx=$((idx - 1))
done

# OMG THIS INFINITE LOOP BACKUPS MY LAYOUT EVERY 10 MINUTES, SWEEEEEEEET!
while true; do
  idx=9
  while [ $idx -gt -1 ]; do
    path="$HOME/.dotfiles/i3/.config/i3/workspaces/$idx.json"

    current_layout=$(mktemp)
    i3-save-tree --workspace $idx >"$current_layout"

    if [ ! -f "$path" ] || ! diff "$current_layout" "$path" >/dev/null 2>&1; then
      mv "$current_layout" "$path"
    else
      rm "$current_layout"
    fi

    idx=$((idx - 1))
  done
  sleep 600
done
