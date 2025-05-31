#!/bin/bash

read -p "suffix to remove: " suffix

# handle errors if no match
shopt -s nullglob

for file in *"$suffix"; do
    new_name="${file%"$suffix"}"
    mv -- "$file" "$new_name"
done
