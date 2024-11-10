# frozen_string_literal: true

# There are 9 zones. We'll draw a border (rectable)
# around each zone and label it.
class Zone
  DEFAULT_FILL_COLOR = '#E0FFE0'
  DEFAULT_STROKE_COLOR = 'black'
  DEFAULT_STROKE_WIDTH = 0.002
  DEFAULT_FONT_SIZE = 0.5

  attr_reader :ll, :ur, :options

  def initialize(ll, ur, options = {}) # rubocop:disable Naming/MethodParameterName
    @ll = ll
    @ur = ur
    @options = options
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
    [ll[0] + width / 2.0, ll[1] + height / 2.0]
  end

  def rect_svg
    "<rect x='#{ll[0]}' y='#{ll[1]}' width='#{width}'\
      height='#{height}' fill='#{fill}' stroke='#{stroke}' stroke-width='#{stroke_width}cm' />"
  end

  def label_svg
    if label
      "<text x='#{center[0]}' y='#{center[1]}'\
        fill='#{super_light_gray_fill}' font-size='#{font_size}'\
        text-anchor='middle' dy='.3em'>#{label}</text>"
    else
      ''
    end
  end

  def to_svg
    <<~SVG
      #{rect_svg}
      #{label_svg}
    SVG
  end

  def light_gray_fill
    '#d3d3d3'
  end

  # Here are three increasingly lighter gray shades than #D3D3D3:
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
