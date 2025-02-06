require_relative 'default_styling'

# Draw the US holding area.
class UsHoldingArea
  include DefaultStyling

  BORDER_POINTS = [
    [14.0, 0],
    [18.0, 0],
    [18.0, 7.5],
    [14.0, 7.5]
  ].freeze

  def initialize(xml)
    @xml = xml
  end

  def linespace
    0.6
  end

  def initial_text_position_y
    1.0
  end

  def font_size
    '0.6'
  end

  # Now we need to add the text "US HOLDING AREA"
  def add_text_us
    @xml.text_(
      'US',
      x: 14.5,
      y: initial_text_position_y,
      'font-size': font_size,
      fill: text_color,
      'text-anchor': 'left',
      'font-weight': 'bold',
      'font-family': "'Courier New', Courier, monospace"
    )
  end

  def add_text_holding
    @xml.text_(
      'HOLDING',
      x: 14.5,
      y: initial_text_position_y + linespace,
      'font-size': font_size,
      fill: text_color,
      'text-anchor': 'left',
      'font-weight': 'bold',
      'font-family': "'Courier New', Courier, monospace"
    )
  end

  def add_text_area
    @xml.text_(
      'AREA',
      x: 14.5,
      y: initial_text_position_y + (2 * linespace),
      'font-size': font_size,
      fill: text_color,
      'text-anchor': 'left',
      'font-weight': 'bold',
      'font-family': "'Courier New', Courier, monospace"
    )
  end

  def arrow_stroke_width
    0.2
  end

  def add_arrow_south_china_sea
    @xml.path(
      d: 'M 14.0, 4.0 L 12.0, 4.0',
      fill: fill_color,
      stroke: stroke_color,
      'stroke-width': arrow_stroke_width,
      'marker-end': 'url(#arrowhead)'
    )
  end

  def add_arrow_zone_6
    @xml.path(
      d: 'M 14.0, 7.5 L 12.0, 8.5',
      fill: fill_color,
      stroke: stroke_color,
      'stroke-width': arrow_stroke_width,
      'marker-end': 'url(#arrowhead)'
    )
  end

  def add_arrow_zone_9
    @xml.path(
      d: 'M 16.0, 7.5 L 16.0, 9.2',
      fill: fill_color,
      stroke: stroke_color,
      'stroke-width': arrow_stroke_width,
      'marker-end': 'url(#arrowhead)'
    )
  end

  def add_arrows
    add_arrow_south_china_sea
    add_arrow_zone_6
    add_arrow_zone_9
  end

  def add_text
    add_text_us
    add_text_holding
    add_text_area
    add_arrows
  end

  def add_to_svg
    @xml.path(
      d: "M #{BORDER_POINTS.map { |x, y| "#{x},#{y}" }.join(' L ')} Z",
      fill: 'none',
      stroke: 'black',
      'stroke-width': '0.1'
    )
    add_text
  end
end
