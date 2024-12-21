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
    'coral'
  end

  def fill_opacity
    '0.3'
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
