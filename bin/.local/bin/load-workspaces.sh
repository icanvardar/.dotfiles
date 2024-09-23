#!/usr/bin/env bash

dir_path="$HOME/.dotfiles/i3/.config/i3/workspaces"

if [ ! -d $dir_name ]; then
  mkdir -p $dir_path
fi

# loads MY PRECIOUS LAYOUTS
idx=9
while [ $idx -gt -1 ]; do
  path="$HOME/.dotfiles/i3/.config/i3/workspaces/workspace_$idx.json"

  if [ ! -f $path ]; then
    touch $path
  fi

  i3_data=$(i3-save-tree --workspace $idx 2>/dev/null)
  workspace_data=$(cat $path)

  if ! diff <(echo "$i3_data") <(echo "$workspace_data") >/dev/null 2>&1; then
    i3-msg "workspace $idx; append_layout $path"
  fi

  idx=$((idx - 1))
done

notify-send "Workspaces loaded."
