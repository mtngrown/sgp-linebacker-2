# frozen_string_literal: true

class Star
  DEFAULT_INNER_RADIUS_RATIO = 0.45
  DEFAULT_FILL = 'gold'
  DEFAULT_STROKE = 'green'
  DEFAULT_STROKE_WIDTH = 0.02
  DEFAULT_FONT_SIZE = 0.3
  DEFAULT_LABEL_COLOR = 'black'

  STAR_DATA = [
    { center: [0.5, 1.6], label: '1', label_offset: :ur },
    { center: [3.1, 1.6], label: '2', label_offset: :ur },
    { center: [3.5, 2.2], label: '3', label_offset: :ur },
    { center: [1.8, 3.7], label: '4', label_offset: :lr },
    { center: [3.9, 3.6], label: '5', label_offset: :ll },
    { center: [3.9, 5.2], label: '6', label_offset: :ll },
    { center: [5.3, 2.2], label: '7', label_offset: :lr },
    { center: [7.6, 6.0], label: '8', label_offset: :ur },
    { center: [7.4, 8.8], label: '9', label_offset: :ur },
    { center: [13.2, 12.2], label: '10', label_offset: :lr }
  ].freeze

  attr_reader :xml, :center, :outer_radius, :inner_radius, :label, :label_offset, :fill, :stroke, :stroke_width,
              :font_size, :label_color

  def initialize(xml, center, radius, options = {})
    @xml = xml
    @center = center
    @outer_radius = radius
    @inner_radius = options[:inner_radius] || radius * DEFAULT_INNER_RADIUS_RATIO
    @label = options[:label]
    @label_offset = options[:label_offset] || [0, 0]
    @fill = options[:fill] || DEFAULT_FILL
    @stroke = options[:stroke] || DEFAULT_STROKE
    @stroke_width = options[:stroke_width] || DEFAULT_STROKE_WIDTH
    @font_size = options[:font_size] || DEFAULT_FONT_SIZE
    @label_color = options[:label_color] || DEFAULT_LABEL_COLOR
  end

  def self.add_stars_to_svg(xml)
    STAR_DATA.each do |data|
      new(
        xml,
        data[:center],
        radius,
        label: data[:label],
        label_offset: send(data[:label_offset])
      ).add_to_svg
    end
  end

  def self.radius
    0.2
  end

  def add_to_svg
    add_star
    add_label if label
  end

  private

  def add_star
    points_str = star_points(center[0], center[1], outer_radius, inner_radius).map { |x, y| "#{x},#{y}" }.join(' ')
    xml.polygon(points: points_str, fill: fill, stroke: stroke, 'stroke-width': stroke_width.to_s)
  end

  def add_label
    lx, ly = label_position
    xml.text_(label, x: lx, y: ly, 'font-size': font_size, fill: label_color, 'text-anchor': 'middle')
  end

  def label_position
    cx, cy = center
    offset_x, offset_y = label_offset
    [cx + offset_x, cy + offset_y]
  end

  def star_points(cx, cy, outer_radius, inner_radius)
    points = []
    angle = Math::PI / 5 # 36 degrees in radians

    (0...10).each do |i|
      radius = i.even? ? outer_radius : inner_radius
      x = cx + radius * Math.cos(i * angle - Math::PI / 2)
      y = cy + radius * Math.sin(i * angle - Math::PI / 2)
      points << [x.round(2), y.round(2)]
    end

    points
  end

  def self.ur
    [0.2, -0.15] # Upper right
  end

  def self.lr
    [0.28, 0.3]  # Lower right
  end

  def self.ll
    [-0.25, 0.3] # Lower left
  end
end
