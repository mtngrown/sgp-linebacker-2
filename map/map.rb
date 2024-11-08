#!/usr/bin/env ruby

require_relative "zone"
require_relative "star"

class SVGGenerator
  BORDER_POINTS = [
    [0, 0],
    [11.7, 0],
    [11.7, 9.5],
    [18.1, 9.5],
    [18.1, 12.6],
    [4.3, 12.6],
    [4.3, 6.7],
    [0, 6.7]
  ]

  attr_reader :canvas_width, :canvas_height, :zones, :stars

  def initialize(canvas_width = 20.0, canvas_height = 16.0)
    @canvas_width = canvas_width
    @canvas_height = canvas_height
    @zones = initialize_zones
    @stars = initialize_stars
  end

  def bounding_box
    x_values = BORDER_POINTS.map(&:first)
    y_values = BORDER_POINTS.map(&:last)
    [[x_values.min, y_values.min], [x_values.max, y_values.max]]
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

  def initialize_zones
    [
      Zone.new([0, 0], [4.3, 3.1], label: "Zone 1"),
      Zone.new([4.3, 0], [8.4, 3.1], label: "Zone 2"),
      Zone.new([8.4, 0], [11.7, 6.7], label: "Zone 3"),
      Zone.new([0, 3.1], [4.3, 6.7], label: "Zone 4"),
      Zone.new([4.3, 3.1], [8.4, 6.7], label: "Zone 5"),
      Zone.new([8.4, 6.7], [11.7, 9.5], label: "Zone 6"),
      Zone.new([4.3, 6.7], [8.4, 9.5], label: "Zone 7"),
      Zone.new([11.7, 9.5], [18.1, 12.6], label: "Zone 8"),
      Zone.new([8.4, 9.5], [11.7, 12.6], label: "Zone 9"),
      Zone.new([4.3, 9.5], [8.4, 12.6], label: "Zone 10")
    ]
  end

  def initialize_stars
    [
      Star.new([3, 3], 0.1),
      Star.new([10, 10], 0.1)
    ]
  end

  def generate_svg
    File.open("border_shape.svg", "w") do |file|
      file.puts <<~SVG
        <svg xmlns="http://www.w3.org/2000/svg" width="#{canvas_width}cm" height="#{canvas_height}cm" viewBox="0 0 #{canvas_width} #{canvas_height}">
          #{canvas_rect}
          #{viewport_rect}
          #{bounding_box_rect}
          <g transform="translate(1.0, 1.0)">
            <path d="M #{path_data} Z" fill="#{Zone::DEFAULT_FILL_COLOR}" stroke="#{Zone::DEFAULT_STROKE_COLOR}" stroke-width="#{Zone::DEFAULT_STROKE_WIDTH}cm" />
            #{zones.map(&:to_svg).join("\n")}
            #{stars.map(&:to_svg).join("\n")}
          </g>
        </svg>
      SVG
    end
    puts "SVG file 'border_shape.svg' created successfully!"
  end
end

SVGGenerator.new.generate_svg
