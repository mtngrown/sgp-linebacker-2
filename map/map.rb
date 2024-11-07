#! /usr/bin/env ruby

# border_shape = [
#   [0, 0],
#   [11.7, 0],
#   [11.7, 9.5],
#   [18.1, 9.5],
#   [18.1, 12.6],
#   [4.7, 12.6],
#   [4.7, 6.7],
#   [0, 6.7],
# ]


# Define the points array
border_shape = [
  [0, 0],
  [11.7, 0],
  [11.7, 9.5],
  [18.1, 9.5],
  [18.1, 12.6],
  [4.7, 12.6],
  [4.7, 6.7],
  [0, 6.7],
]

# Set canvas dimensions
canvas_width = 18.0 # cm
canvas_height = 15.0 # cm

# Generate SVG path data by connecting each point with "L"
path_data = border_shape.map { |x, y| "#{x},#{y}" }.join(" L ")

# Write SVG file
File.open("border_shape.svg", "w") do |file|
  file.puts <<~SVG
    <svg xmlns="http://www.w3.org/2000/svg" width="#{canvas_width}cm" height="#{canvas_height}cm" viewBox="0 0 #{canvas_width} #{canvas_height}">
      <!-- Canvas Background -->
      <rect width="100%" height="100%" fill="lightgreen" />
      
      <!-- Viewport Background -->
      <rect x="0" y="0" width="#{canvas_width}" height="#{canvas_height}" fill="lightcoral" />
      
      <!-- Path -->
      <path d="M #{path_data} Z" fill="none" stroke="black" stroke-width="0.002cm" />
    </svg>
  SVG
end

puts "SVG file 'border_shape.svg' created successfully!"
