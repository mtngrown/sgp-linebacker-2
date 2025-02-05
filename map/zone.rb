# frozen_string_literal: true

require 'nokogiri'

# The Zone class defines zones within an SVG, drawing a border
# around each zone and labeling it.
class Zone
  DEFAULT_FILL_COLOR = '#E0FFE0'
  DEFAULT_STROKE_COLOR = 'black'
  DEFAULT_STROKE_WIDTH = 0.002
  DEFAULT_FONT_SIZE = 0.5

  # The lower line value matches the map at 12.6.
  # extended to better fit Vinh and its aasociated airfield.
  LOWER_LINE = 13.0

  ZONES_DATA = [
    { ll: [0, 0], ur: [4.3, 3.1], label: 'Zone 1' },
    { ll: [4.3, 0], ur: [8.4, 3.1], label: 'Zone 2' },
    { ll: [8.4, 0], ur: [11.7, 6.7], label: '' },
    { ll: [0, 3.1], ur: [4.3, 6.7], label: 'Zone 3' },
    { ll: [4.3, 3.1], ur: [8.4, 6.7], label: 'Zone 4' },
    { ll: [8.4, 6.7], ur: [11.7, 9.5], label: 'Zone 6' },
    { ll: [4.3, 6.7], ur: [8.4, 9.5], label: 'Zone 5' },
    { ll: [11.7, 9.5], ur: [18.1, LOWER_LINE], label: 'Zone 9' },
    { ll: [8.4, 9.5], ur: [11.7, LOWER_LINE], label: 'Zone 8' },
    { ll: [4.3, 9.5], ur: [8.4, LOWER_LINE], label: 'Zone 7' }
  ].freeze

  attr_reader :xml, :ll, :ur, :options

  def initialize(xml, ll, ur, options = {})
    @xml = xml
    @ll = ll
    @ur = ur
    @options = options
  end

  def self.add_zones_to_svg(xml, options = {})
    ZONES_DATA.each do |zone_data|
      options[:label] = zone_data[:label]
      options[:fill] = 'none'
      zone = Zone.new(xml, zone_data[:ll], zone_data[:ur], options)
      zone.draw
    end
  end

  def draw
    xml.rect(
      x: ll[0],
      y: ll[1],
      width: width,
      height: height,
      fill: fill,
      stroke: stroke,
      'stroke-width': "#{stroke_width}cm"
    )
    add_label if label
  end

  def add_label
    cx, cy = center
    xml.text_(label, x: cx, y: cy, fill: super_light_gray_fill, 'font-size': font_size, 'text-anchor': 'middle',
                     dy: '.3em')
  end

  def fill
    options.fetch(:fill, DEFAULT_FILL_COLOR)
  end

  def stroke
    options.fetch(:stroke, DEFAULT_STROKE_COLOR)
  end

  def stroke_width
    options.fetch(:stroke_width, DEFAULT_STROKE_WIDTH)
  end

  def label
    options[:label]
  end

  def font_size
    options.fetch(:font_size, DEFAULT_FONT_SIZE)
  end

  def width
    ur[0] - ll[0]
  end

  def height
    ur[1] - ll[1]
  end

  def center
    [ll[0] + (width / 2.0), ll[1] + (height / 2.0)]
  end

  def light_gray_fill
    '#d3d3d3'
  end

  def very_light_gray_fill
    '#E0E0E0'
  end

  def super_light_gray_fill
    '#E8E8E8'
  end

  def almost_white_fill
    '#f0f0f0'
  end
end
