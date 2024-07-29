#!/bin/bash

# Initialize or clear the content of temp.txt
> temp.txt

# Loop through pages 9 to 12
for i in {9..12}; do
    # Concatenate left and right pages into temp.txt
    cat "page-$i-left.txt" >> temp.txt
    cat "page-$i-right.txt" >> temp.txt
done

sed -i '' 's/#/\\#/g' temp.txt

cp temp.txt temp.tex

xelatex rules

echo "All files have been concatenated into temp.txt."

