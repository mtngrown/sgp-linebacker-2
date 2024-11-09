class Zone
  DEFAULT_FILL_COLOR = "#E0FFE0"
  DEFAULT_STROKE_COLOR = "black"
  DEFAULT_STROKE_WIDTH = 0.002
  DEFAULT_FONT_SIZE = 0.5

  attr_reader :ll, :ur, :options

  def initialize(ll, ur, options = {})
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

  def to_svg
    rect_svg = "<rect x='#{ll[0]}' y='#{ll[1]}' width='#{width}' height='#{height}' fill='#{fill}' stroke='#{stroke}' stroke-width='#{stroke_width}cm' />"
    label_svg = label ? "<text x='#{center[0]}' y='#{center[1]}' fill='#d3d3d3' font-size='#{font_size}' text-anchor='middle' dy='.3em'>#{label}</text>" : ""
    
    <<~SVG
      #{rect_svg}
      #{label_svg}
    SVG
  end
end

