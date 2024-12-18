# Base class for the wun
class Counter
  def counter_background(xml)
    xml.rect(
      x: '0',
      y: '0',
      width: counter_width,
      height: counter_height,
      fill: 'coral',
      'fill-opacity': '0.3',
      stroke: 'black',
      'stroke-width': '1'
    )
  end

  def counter_width
    1024
  end

  def counter_height
    1024
  end

  def font_size
    108
  end
end