#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'

# <?xml version="1.0" encoding="UTF-8" standalone="no"?>
# <svg
#    width="210mm"
#    height="297mm"
#    viewBox="0 0 210 297"
#    version="1.1" >
#   <g>
#     <circle
#        style="fill:none;stroke:#e50000;stroke-width:0.767292;stroke-linecap:round;stroke-linejoin:round;stroke-dashoffset:17.9906;paint-order:markers stroke fill"
#        id="path690"
#        cx="82.758453"
#        cy="97.441414"
#        r="19.13233" />
#     <circle
#        style="fill:none;stroke:#e50000;stroke-width:0.767292;stroke-linecap:round;stroke-linejoin:round;stroke-dashoffset:17.9906;paint-order:markers stroke fill"
#        id="circle692"
#        cx="112.12436"
#        cy="97.441414"
#        r="19.13233" />
#   </g>
# </svg>

class OvalCounter
  # No idea why -100 is the correct (or close enoug) offset.
  # It needs to be calculated based on the counter width.
  def offset_x
    -80
  end

  def counter_background(xml)
    xml.rect(
      x: '0',
      y: '0',
      width: counter_width,
      height: counter_height,
      fill: 'coral',
      "fill-opacity": '0.3',
      stroke: 'black',
      "stroke-width": '1'
    )
  end

  # This needs to be calculated based on the counter height
  def offset_y
    (1024 - 628) / 2
  end

  def add_value(xml, value)
    value ||= '??'
    xml.text_(value,
              x: '612',
              y: '700',
              'text-anchor': 'middle',
              'text-align': 'center',
              'font-family': 'sans-serif',
              'font-size': '300px') # font_size
  end

  def oval_outline(xml)
    xml.circle(cx: 450, cy: 100, r: 200)
    xml.circle(cx: 750, cy: 100, r: 200)
  end

  def build_counter(xml, value = nil)
    counter_background(xml)
    xml.g(transform: "translate(#{offset_x},#{offset_y})") do
      oval_outline(xml)
      add_value(xml, value)
    end
  end

  def to_svg
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.svg(xmlns: 'http://www.w3.org/2000/svg', width: counter_width, height: counter_height) do
        build_counter(xml)
      end
    end
    builder.to_xml
  end

  def counter_width
    1024
  end

  def counter_height
    1024
  end
end

File.write('oval-counter.svg', OvalCounter.new.to_svg)
