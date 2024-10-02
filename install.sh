#!/bin/bash

directories=$(ls -d */ | cut -f1 -d'/')

for dir in $directories; do
  echo "Stowing $dir"
  stow $dir
done
