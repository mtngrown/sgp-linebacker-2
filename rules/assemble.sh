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

# sed -i '' -E 's/^(INTRODUCTION|SETTING UP THE GAME|UNITS|SAM FIRE)$/\\section*{&}/' temp.txt

file="temp.txt"
headers=(
  "INTRODUCTION"
  "SETTING UP THE GAME"
  "UNITS" "SAM FIRE"
  "FLAK CRT"
  "BOMBING"
  "AIR-TO-AIR COMBAT"
  "THE GAME-TURN TRACK"
  "US PILOT MORALE"
  "MOVEMENT"
  "VICTORY POINTS"
  "SCENARIOS"
  "SEQUENCE OF PLAY"
)

# Generate regex pattern for headers
IFS='|' # Set Internal Field Separator to '|'
sed_pattern="${headers[*]}"
# Use sed to replace headers with LaTeX formatted versions
sed -i '' -E "s/^($sed_pattern)$/"'\\section*{&}/' "$file"

# temp_file="temp_$file"
# awk '
#     /^[0-9]+\./ {
#         if (sublevel) {
#             print "\\end{enumerate}"
#             sublevel = 0
#         }
#         if (level) {
#             print "\\end{enumerate}"
#         }
#         print "\\begin{enumerate}"
#         level = 1
#         print "\\item " substr($0, index($0, " ")+1)
#         next
#     }
#     /^[A-Z]\./ {
#         if (!sublevel) {
#             if (!level) { # Ensure main level is open if not already
#                 print "\\begin{enumerate}"
#                 level = 1
#             }
#             print "\\begin{enumerate}"
#             sublevel = 1
#         }
#         print "\\item " substr($0, index($0, " ")+1)
#         next
#     }
#     END {
#         if (sublevel) {
#             print "\\end{enumerate}"
#         }
#         if (level) {
#             print "\\end{enumerate}"
#         }
#     }
# ' "$file" > "$temp_file"

# # Move the temporary file back to the original file
# mv "$temp_file" "$file"



sed -i '' -E 's|(\[GRAPHIC\][[:space:]]+)(.*)|\\texttt{\1\2}\\\\|g' temp.txt


cp temp.txt temp.tex

xelatex rules

echo "All files have been concatenated into temp.txt."

