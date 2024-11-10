
# This is a Ruby script that converts the sequence of play from the rules into LaTeX format.
# It needs to be invoked from the assemble script.

input_text = <<~TEXT
  SEQUENCE OF PLAY
  1. First SAM fire phase
  2. Air-to-Air combat phase:
     A. Interception segment
     B. B-52 defensive fire segment
     C. Air superiority segment
  3. Bombing phase:
     A. Low-level flak attack segment
     B. Bombing phase
  4. Movement phase:
     A. First player movement segment
     B. Second player movement segment
  5. Second SAM fire phase
  6. Record the passage of one GAME TURN
TEXT

# Define a method to parse and convert to LaTeX with alphabetical sub-items
def convert_to_latex(text)
  output = ["\\begin{enumerate}"]
  main_list_open = true
  sub_list_open = false

  # Loop through each line and apply transformations
  text.each_line do |line|
    case line.strip
    when /^SEQUENCE OF PLAY$/
      next  # Skip the title line
    when /^(\d+)\.\s*(.+)$/, /^(\d+)\.\s*(.+):$/
      output << "\t\\end{enumerate}" if sub_list_open  # Close sub-list if open
      sub_list_open = false
      output << "\t\\item #{$2.strip}"  # Main item
    when /^\s*([A-Z])\.\s*(.+)$/
      unless sub_list_open  # Open sub-list with alphabetical labeling
        output << "\t\\begin{enumerate}[label=\\Alph*.]"
        sub_list_open = true
      end
      output << "\t\t\\item #{$2.strip}"  # Sub-item
    when /^GAME TURN$/
      output << "\t\\end{enumerate}" if sub_list_open  # Close sub-list if open
      sub_list_open = false
      output << "\t\\item Record the passage of one GAME TURN"
    end
  end

  output << "\\end{enumerate}"  # Close main list
  output.join("\n")
end

# Print the LaTeX output
latex_output = convert_to_latex(input_text)
puts latex_output

