#!/usr/bin/env ruby
# frozen_string_literal: true

require 'debug'
require 'nokogiri'

require_relative 'border'
require_relative 'zone_heredoc'
require_relative 'zone'
require_relative 'star'
require_relative 'city'
require_relative 'city_heredoc'
require_relative 'coastline'
require_relative 'us_holding_area'
require_relative 'arrowhead'
# Legend is to the left of the map area.
class AirfieldLegend
  xoffset = 0.1
  yoffset = 8.3
  linespace = 0.5

  AIRFIELDS = [
    { position: [xoffset, yoffset], label: 1, name: 'Dong Hi' },
    { position: [xoffset, yoffset + linespace], label: 2, name: 'Sep' },
    { position: [xoffset, yoffset + (2 * linespace)], label: 3, name: 'Bao Giang' },
    { position: [xoffset, yoffset + (3 * linespace)], label: 4, name: 'Kim Anh' },
    { position: [xoffset, yoffset + (4 * linespace)], label: 5, name: 'Gia Lam' },
    { position: [xoffset, yoffset + (5 * linespace)], label: 6, name: 'Bac Mai' },
    { position: [xoffset, yoffset + (6 * linespace)], label: 7, name: 'Kien Anh' },
    { position: [xoffset, yoffset + (7 * linespace)], label: 8, name: 'Ninh Binh' },
    { position: [xoffset, yoffset + (8 * linespace)], label: 9, name: 'Yen Dai' },
    { position: [xoffset, yoffset + (9 * linespace)], label: 10, name: 'Thanh Hoa' }
  ].freeze

  attr_reader :xml

  def initialize(xml)
    @xml = xml
  end

  def to_svg
    AIRFIELDS.each do |af|
      xml.text_("#{af[:label]}. #{af[:name]}",
                x: af[:position][0],
                y: af[:position][1], 'font-size': '0.4',
                fill: 'black',
                'font-weight': 'bold',
                'font-family': "'Courier New', Courier, monospace")
    end
  end
end

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
  ].freeze

  attr_reader :canvas_width, :canvas_height, :zones, :stars, :cities

  def initialize(canvas_width = 20.0, canvas_height = 16.0)
    @canvas_width = canvas_width
    @canvas_height = canvas_height
    @zones = initialize_zones
  end

  def bounding_box
    x_values = BORDER_POINTS.map(&:first)
    y_values = BORDER_POINTS.map(&:last)
    [[x_values.min, y_values.min], [x_values.max, y_values.max]]
  end

  def bounding_box_fill_color
    'none' # 'lightblue'
  end

  def bounding_box_stroke_color
    'blue'
  end

  def bounding_box_rect
    x_min, y_min = bounding_box[0]
    x_max, y_max = bounding_box[1]
    width = x_max - x_min
    height = y_max - y_min

    "<rect x='#{x_min}' y='#{y_min}' width='#{width}' height='#{height}' fill='#{bounding_box_fill_color}' stroke='#{bounding_box_stroke_color}' stroke-width='0.1' />"
  end

  def x_position
    9.0
  end

  def font_size
    '0.6'
  end

  def line_spacing
    0.6
  end

  def south_text(xml)
    xml.text_(
      'South',
      x: x_position,
      y: 1.0,
      'font-size': font_size,
      fill: 'black',
      'font-weight': 'bold',
      'font-family': "'Courier New', Courier, monospace",
      'text-anchor': 'left'
    )
  end

  def china_text(xml)
    xml.text_(
      'China',
      x: x_position,
      y: 1.0 + line_spacing,
      'font-size': font_size,
      fill: 'black',
      'font-weight': 'bold',
      'font-family': "'Courier New', Courier, monospace",
      'text-anchor': 'left'
    )
  end

  def sea_text(xml)
    xml.text_(
      'Sea',
      x: x_position,
      y: 1.0 + (2 * line_spacing),
      'font-size': font_size,
      fill: 'black',
      'font-weight': 'bold',
      'font-family': "'Courier New', Courier, monospace",
      'text-anchor': 'left'
    )
  end

  def south_china_sea_text(xml)
    south_text(xml)
    china_text(xml)
    sea_text(xml)
  end

  def canvas_fill_color
    'none' # 'lightgreen'
  end

  def viewport_fill_color
    'lightcoral'
  end

  def canvas_rect
    "<rect width='100%' height='100%' fill='#{canvas_fill_color}' />"
  end

  def viewport_rect
    "<rect x='0' y='0' width='#{canvas_width}' height='#{canvas_height}' fill='#{viewport_fill_color}' />"
  end

  def path_data
    BORDER_POINTS.map { |x, y| "#{x},#{y}" }.join(' L ')
  end

  def initialize_zones
    [
      ZoneHeredoc.new([0, 0], [4.3, 3.1], label: 'Zone 1'),
      ZoneHeredoc.new([4.3, 0], [8.4, 3.1], label: 'Zone 2'),
      ZoneHeredoc.new([8.4, 0], [11.7, 6.7], label: ''),
      ZoneHeredoc.new([0, 3.1], [4.3, 6.7], label: 'Zone 3'),
      ZoneHeredoc.new([4.3, 3.1], [8.4, 6.7], label: 'Zone 4'),
      ZoneHeredoc.new([8.4, 6.7], [11.7, 9.5], label: 'Zone 6'),
      ZoneHeredoc.new([4.3, 6.7], [8.4, 9.5], label: 'Zone 5'),
      ZoneHeredoc.new([11.7, 9.5], [18.1, 12.6], label: 'Zone 9'),
      ZoneHeredoc.new([8.4, 9.5], [11.7, 12.6], label: 'Zone 8'),
      ZoneHeredoc.new([4.3, 9.5], [8.4, 12.6], label: 'Zone 7')
    ]
  end

  def generate_svg_original
    File.open('border_shape.svg', 'w') do |file|
      file.puts <<~SVG
        <svg xmlns="http://www.w3.org/2000/svg" width="#{canvas_width}cm" height="#{canvas_height}cm" viewBox="0 0 #{canvas_width} #{canvas_height}">
          #{canvas_rect}
          #{viewport_rect}
          #{bounding_box_rect}
          <g transform="translate(1.0, 1.0)">
            <path d="M #{path_data} Z" fill="#{ZoneHeredoc::DEFAULT_FILL_COLOR}" stroke="#{ZoneHeredoc::DEFAULT_STROKE_COLOR}" stroke-width="#{ZoneHeredoc::DEFAULT_STROKE_WIDTH}cm" />
            #{zones.map(&:to_svg).join("\n")}
          </g>
        </svg>
      SVG
    end
    puts "SVG file 'border_shape.svg' created successfully!"
  end

  def generate_border_svg
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.svg(xmlns: 'http://www.w3.org/2000/svg', width: "#{canvas_width}cm", height: "#{canvas_height}cm",
              viewBox: "0 0 #{canvas_width} #{canvas_height}") do
        xml.rect(width: '100%', height: '100%', fill: bounding_box_fill_color)
        xml.g(transform: 'translate(1.0, 1.0)') do
          xml.defs do
            Arrowhead.new(xml).build
          end
          Border.new(xml).add_to_svg
          Zone.add_zones_to_svg(xml)
          Coastline.new(xml).add_line_path
          Coastline.new(xml).add_circles
          Star.add_stars_to_svg(xml)
          City.add_all_to_svg(xml)
          AirfieldLegend.new(xml).to_svg
          UsHoldingArea.new(xml).add_to_svg
          south_china_sea_text(xml)
        end
      end
    end

    File.write(file_name, builder.to_xml)
    puts "SVG border file '#{file_name}' created successfully!"
  end

  private

  def file_name
    'map.svg'
  end

  # star radius
  def sr
    0.2
  end

  # upper right
  def ur
    [0.20, -0.15]
  end

  # lower right
  def lr
    [0.25, 0.3]
  end

  # upper left
  def ul
    [-0.4, 0.0]
  end

  # lower left
  def ll
    [-0.25, 0.3]
  end
end

SVGGenerator.new.generate_svg_original
SVGGenerator.new.generate_border_svg
