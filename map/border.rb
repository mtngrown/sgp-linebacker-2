# frozen_string_literal: true

# border.rb

# Only draw the border around the zones.
# Should probably be renamed to ZoneBorder.
class Border
  LOWER_LINE = 13.0
  BORDER_POINTS = [
    [0, 0],
    [11.7, 0],
    [11.7, 9.5],
    [18.1, 9.5],
    [18.1, LOWER_LINE],
    [4.3, LOWER_LINE],
    [4.3, 6.7],
    [0, 6.7]
  ].freeze

  def initialize(xml)
    @xml = xml
  end

  def add_to_svg
    @xml.path(
      d: "M #{BORDER_POINTS.map { |x, y| "#{x},#{y}" }.join(' L ')} Z",
      fill: 'none',
      stroke: 'black',
      'stroke-width': '0.1'
    )
  end
end
