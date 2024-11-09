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
      Zone.new([8.4, 0], [11.7, 6.7], label: "South China Sea"),
      Zone.new([0, 3.1], [4.3, 6.7], label: "Zone 3"),
      Zone.new([4.3, 3.1], [8.4, 6.7], label: "Zone 4"),
      Zone.new([8.4, 6.7], [11.7, 9.5], label: "Zone 6"),
      Zone.new([4.3, 6.7], [8.4, 9.5], label: "Zone 5"),
      Zone.new([11.7, 9.5], [18.1, 12.6], label: "Zone 9"),
      Zone.new([8.4, 9.5], [11.7, 12.6], label: "Zone 8"),
      Zone.new([4.3, 9.5], [8.4, 12.6], label: "Zone 7")
    ]
  end

  def initialize_stars
    [
      Star.new([0.5, 1.6], sr, label: "1", label_offset: ur),
      Star.new([3.1, 1.6], sr, label: "2", label_offset: ur),
      Star.new([3.5, 2.2], sr, label: "3", label_offset: ur),
      Star.new([1.8, 3.7], sr, label: "4", label_offset: lr),
      Star.new([3.9, 3.6], sr, label: "5", label_offset: ll),
      Star.new([3.9, 5.2], sr, label: "6", label_offset: ll),
      Star.new([5.3, 2.2], sr, label: "7", label_offset: lr),
      Star.new([7.6, 6.0], sr, label: "8", label_offset: ur),
      Star.new([7.4, 8.8], sr, label: "9", label_offset: ur),
      Star.new([9.2, 12.2], sr, label: "10", label_offset: ur)
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

  private

  def sr # star radius
    0.2
  end

  def ur # upper right
    [0.20, -0.15]
  end

  def lr # lower right
    [0.25, 0.3]
  end

  def ul # upper left
    [-0.4, 0.0]
  end

  def ll # lower left
    [-0.25, 0.3]
  end
end

SVGGenerator.new.generate_svg
