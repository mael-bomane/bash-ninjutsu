#!/bin/bash

read -p "file extension(s) : " exts
read -p "replace: " find_str
read -p "with: " replace_str

# Convert extensions to find-expressions
find_expr=""
for ext in $exts; do
    find_expr="$find_expr -name '*.$ext' -o"
done
# Remove the trailing -o
find_expr="${find_expr::-3}"

# handle errors if no match
shopt -s nullglob

# Run the find and replace
eval find . -type d -name .git -prune -o \( $find_expr \) -type f -print0 \
    | while IFS= read -r -d '' file; do
        # Check if it's a text file
        if file "$file" | grep -qE 'text|ASCII'; then
            sed -i "s/${find_str}/${replace_str}/g" "$file"
        else
            echo "Skipping binary file: $file"
        fi
    done

