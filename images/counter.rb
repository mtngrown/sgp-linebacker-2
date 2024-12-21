# frozen_string_literal: true

# Base class for the wun
class Counter
  def counter_background(xml)
    xml.rect(
      x: '0',
      y: '0',
      width: counter_width,
      height: counter_height,
      fill: fill,
      'fill-opacity': fill_opacity,
      stroke: stroke,
      'stroke-width': stroke_width
    )
  end

  # No idea why -80 is the correct (or close enoug) offset.
  # It needs to be calculated based on the counter width.
  def offset_x
    -80
  end

  # This needs to be calculated based on the counter height
  def offset_y
    (1024 - 628) / 2
  end

  def bounding_box(xml)
    xml.rect(
      x: '236',
      y: '0',
      width: '728',
      height: '628',
      fill: fill, # 'palegreen',
      'fill-opacity': '0.3',
      stroke: 'black',
      'stroke-width': '0' # '1'
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

  def fill
    '#A0A6E7' # 'white' # 'coral'
  end

  def fill_opacity
    '1' # '0.3'
  end

  def stroke
    'black'
  end

  def stroke_width
    '1'
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
