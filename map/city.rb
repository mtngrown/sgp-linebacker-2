# frozen_string_literal: true

require 'nokogiri'

class City
  DEFAULT_FILL = 'lightblue'
  DEFAULT_STROKE = 'blue'
  DEFAULT_STROKE_WIDTH = 0.02
  DEFAULT_FONT_SIZE = 0.25
  DEFAULT_LABEL_COLOR = 'black'

  CITY_DATA = [
    { center: [0.6, 2.4], width: 0.45, name: 'THAI NGUYEN', label_alignment: 'l' },
    { center: [6.6, 1.1], width: 0.45, name: 'HAIPHONG', label_alignment: 'm' },
    { center: [3.2, 4.1], width: 0.7, name: 'HANOI', label_alignment: 'm' },
    { center: [6.5, 4.5], width: 0.45, name: 'NAM DINH', label_alignment: 'm' },
    { center: [8.9, 8.75], width: 0.45, name: 'THAN HOA', label_alignment: 'l' },
    { center: [12.2, 11.8], width: 0.45, name: 'VINH', label_alignment: 'm' }
  ].freeze

  attr_reader :xml, :center, :width, :name, :label_alignment, :fill, :stroke, :stroke_width, :font_size, :label_color

  def initialize(xml, center, width, name, label_alignment, options = {})
    @xml = xml
    @center = center
    @width = width
    @name = name
    @label_alignment = label_alignment
    @fill = options[:fill] || DEFAULT_FILL
    @stroke = options[:stroke] || DEFAULT_STROKE
    @stroke_width = options[:stroke_width] || DEFAULT_STROKE_WIDTH
    @font_size = options[:font_size] || DEFAULT_FONT_SIZE
    @label_color = options[:label_color] || DEFAULT_LABEL_COLOR
  end

  def add_to_svg
    add_polygon
    add_label
  end

  def self.add_all_to_svg(xml)
    CITY_DATA.each do |data|
      new(
        xml,
        data[:center],
        data[:width],
        data[:name],
        data[:label_alignment]
      ).add_to_svg
    end
  end

  private

  def add_polygon
    xml.polygon(points: points, fill: fill, stroke: stroke, 'stroke-width': stroke_width)
  end

  def add_label
    xml.text_(name,
              x: label_x_position,
              y: center[1] + label_y_offset,
              'text-anchor': anchor,
              'font-family': 'sans-serif',
              'font-size': font_size,
              fill: label_color)
  end

  def anchor
    case label_alignment
    when 'm'
      'middle'
    when 'l'
      'start'
    else
      'middle'
    end
  end

  def label_x_position
    case label_alignment
    when 'm'
      center[0]
    when 'l'
      center[0] - width / 2
    else
      center[0]
    end
  end

  def label_y_offset
    width / 2 + font_size + 0.1
  end

  def points
    [
      [center[0] - width / 2, center[1] - width / 2],
      [center[0] + width / 2, center[1] - width / 2],
      [center[0] + width / 2, center[1] + width / 2],
      [center[0] - width / 2, center[1] + width / 2]
    ].map { |x, y| "#{x},#{y}" }.join(' ')
  end
end
