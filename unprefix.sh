#!/bin/bash

read -p "prefix to remove: " prefix

# handle errors if no match
shopt -s nullglob

for i in *.png; do
    if [[ "$i" == "$prefix"* ]]; then
        new_name="${i#"$prefix"}"
        mv -- "$i" "$new_name"
    fi
done
