#! /usr/bin/env ruby

BORDER_POINTS = [
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
canvas_width = 20.0 # cm
canvas_height = 16.0 # cm

# SVG rectangle element for the bounding box
bounding_box_rect = '<rect x="0" y="0" width="18.1" height="12.6" fill="lightblue" stroke="blue" stroke-width="0.1" />'
canvas_rect = "<rect width='100%' height='100%' fill='lightgreen' />"
viewport_rect = "<rect x='0' y='0' width='#{canvas_width}' height='#{canvas_height}' fill='lightcoral' />"

# Generate SVG path data by connecting each point with "L"
path_data = BORDER_POINTS.map { |x, y| "#{x},#{y}" }.join(" L ")

# Write SVG file
File.open("border_shape.svg", "w") do |file|
  file.puts <<~SVG
    <svg xmlns="http://www.w3.org/2000/svg" width="#{canvas_width}cm" height="#{canvas_height}cm" viewBox="0 0 #{canvas_width} #{canvas_height}">

      #{canvas_rect}
      #{viewport_rect}
      #{bounding_box_rect}


      <!-- Path -->
      <path d="M #{path_data} Z" fill="none" stroke="black" stroke-width="0.002cm" />
    </svg>
  SVG
end

puts "SVG file 'border_shape.svg' created successfully!"
