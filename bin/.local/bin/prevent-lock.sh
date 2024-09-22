#!/usr/bin/env bash

ps -aux | grep prevent-lock | grep -v grep | awk '{ print $2 }' | xargs kill -9

while true; do
  if playerctl metadata --format '{{mpris:artUrl}}' | grep -E -q "\.(mp4|mkv|avi|webm|mov|flv|wmv|mpg|mpeg)$"; then
    xautolock -disable
  else
    xautolock -enable
  fi
  sleep 30
done
