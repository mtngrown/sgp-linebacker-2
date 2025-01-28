

class UsHoldingArea
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
    0.75
  end

  # Now we need to add the text "US HOLDING AREA"
  def add_text_us
    @xml.text_(
      'US',
      x: 14.5,
      y: 2.75,
      'font-size': 0.75,
      fill: 'black',
      'text-anchor': 'left',
      'font-weight': 'bold',
      'font-family': "'Courier New', Courier, monospace"
    )
  end

  def add_text_holding
    @xml.text_(
      'HOLDING',
      x: 14.5,
      y: 2.75 + linespace,
      'font-size': 0.75,
      fill: 'black',
      'text-anchor': 'left',
      'font-weight': 'bold',
      'font-family': "'Courier New', Courier, monospace"
    )
  end
  
  def add_text_area
    @xml.text_(
      'AREA',
      x: 14.5,
      y: 2.75 + 2 * linespace,
      'font-size': 0.75,
      fill: 'black',
      'text-anchor': 'left',
      'font-weight': 'bold',
      'font-family': "'Courier New', Courier, monospace"
    )
  end

  def add_arrow_south_china_sea
    @xml.path(
      d: "M 14.0, 4.0 L 12.0, 4.0",
      fill: 'black',
      stroke: 'black',
      'stroke-width': '0.1',
#      'marker-end': 'url(#arrowhead)'
    )
  end

  def add_arrow_zone_6
    @xml.path(
      d: "M 14.0, 7.5 L 12.0, 8.5",
      fill: 'black',
      stroke: 'black',
      'stroke-width': '0.1',
#      'marker-end': 'url(#arrowhead)'
    )
  end

  def add_arrow_zone_9
    @xml.path(
      d: "M 16.0, 7.5 L 16.0, 9.2",
      fill: 'black',
      stroke: 'black',
      'stroke-width': '0.1',
#      'marker-end': 'url(#arrowhead)'
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
