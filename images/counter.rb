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

  def top_left_value(xml, value)
    xml.text_(value,
              x: '200',
              y: '300',
              'text-anchor': 'middle',
              'text-align': 'center',
              'font-family': 'sans-serif',
              'font-size': font_size)
  end

  def top_right_value(xml, value)
    xml.text_(value,
              x: '800',
              y: '300',
              'text-anchor': 'middle',
              'text-align': 'center',
              'font-family': 'sans-serif',
              'font-size': font_size)
  end

  def counter_width
    1024
  end

  def counter_height
    1024
  end

  def font_size
    '300px'
  end
end
