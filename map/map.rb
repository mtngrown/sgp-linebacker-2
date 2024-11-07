#!/usr/bin/env ruby

class SVGGenerator
  BORDER_POINTS = [
    [0, 0],
    [11.7, 0],
    [11.7, 9.5],
    [18.1, 9.5],
    [18.1, 12.6],
    [4.7, 12.6],
    [4.7, 6.7],
    [0, 6.7]
  ]

  attr_reader :canvas_width, :canvas_height

  def initialize(canvas_width = 20.0, canvas_height = 16.0)
    @canvas_width = canvas_width
    @canvas_height = canvas_height
  end

  def bounding_box
    x_values = BORDER_POINTS.map { |point| point[0] }
    y_values = BORDER_POINTS.map { |point| point[1] }
    x_min, x_max = x_values.min, x_values.max
    y_min, y_max = y_values.min, y_values.max

    [[x_min, y_min], [x_max, y_max]]
  end

  def bounding_box_rect
    x_min, y_min = bounding_box[0]
    x_max, y_max = bounding_box[1]
    width = x_max - x_min
    height = y_max - y_min

    "<rect x='#{x_min}' y='#{y_min}' width='#{width}' height='#{height}' fill='lightblue' stroke='blue' stroke-width='0.1' />"
  end

  def canvas_rect
    "<rect width='100%' height='100%' fill='lightgreen' />"
  end

  def viewport_rect
    "<rect x='0' y='0' width='#{canvas_width}' height='#{canvas_height}' fill='lightcoral' />"
  end

  def path_data
    BORDER_POINTS.map { |x, y| "#{x},#{y}" }.join(" L ")
  end

  def generate_svg
    File.open("border_shape.svg", "w") do |file|
      file.puts <<~SVG
        <svg xmlns="http://www.w3.org/2000/svg" width="#{canvas_width}cm" height="#{canvas_height}cm" viewBox="0 0 #{canvas_width} #{canvas_height}">
          #{canvas_rect}
          #{viewport_rect}
          #{bounding_box_rect}
          <g transform="translate(0.5, 0.5)">
            <path d="M #{path_data} Z" fill="none" stroke="black" stroke-width="0.002cm" />
          </g>
        </svg>
      SVG
    end
    puts "SVG file 'border_shape.svg' created successfully!"
  end
end

# Usage
svg_generator = SVGGenerator.new
svg_generator.generate_svg
