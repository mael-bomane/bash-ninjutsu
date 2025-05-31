#!/bin/bash

read -p "prefix to add: " prefix

# handle errors if no match
shopt -s nullglob

for f in *.png; do
    mv -- "$f" "${prefix}${f}"
done

