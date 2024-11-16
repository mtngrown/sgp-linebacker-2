# frozen_string_literal: true

# A city is a square with an associated name.
# The city is centered on the square.
# The label position will be passed in as a parameter.
class CityHeredoc
  DEFAULT_FILL = 'lightblue'
  DEFAULT_STROKE = 'blue'
  DEFAULT_STROKE_WIDTH = 0.02
  DEFAULT_FONT_SIZE = 0.25
  DEFAULT_LABEL_COLOR = 'black'

  attr_reader :center, :width, :name, :label_alignment, :fill, :stroke, :stroke_width, :font_size, :label_color

  def initialize(center, width, name, label_alignment, options = {})
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

  # Draw an SVG rectangle or closed polygon using
  # the coordinates of the city defined by the center
  # attribute. The width is the length of the side of the square.
  def to_svg
    <<~SVG
      <polygon points='#{points}' fill='#{fill}' stroke='#{stroke}' stroke-width='#{stroke_width}' />
      <text x='#{label_x_position}' text-anchor='#{anchor}' y='#{center[1] + label_y_offset}' font-family='sans-serif' font-size='#{font_size}' fill='#{label_color}'>#{name}</text>
    SVG
  end

  private

  def anchor
    case label_alignment
    when 'm'
      'middle'
    when 'l'
      # This needs to align on the left side of the city.
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

  def label_x_offset
    (font_size / 2) + 0.3
  end

  def label_y_offset
    width / 2 + font_size + 0.1
  end

  def points
    [
      center[0] - width / 2,
      center[1] - width / 2,
      center[0] + width / 2,
      center[1] - width / 2,
      center[0] + width / 2,
      center[1] + width / 2,
      center[0] - width / 2,
      center[1] + width / 2
    ].join(',')
  end
end
