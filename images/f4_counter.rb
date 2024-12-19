#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require_relative 'counter'

class F4Counter < Counter
  # disable:rubocop Metrics/Linelength
  PATH = 'm 111.01062,323 h -1.198 l -3.015,-8.699 -35.450004,4.568 -0.731,-2.741 -0.274,-2.284 v -3.015 l 0.182,-2.467 0.274,-1.736 31.613004,-30.151 -2.193,-16.903 -2.832004,0.548 -2.101,0.092 -0.457,-2.193 -0.274,-2.832 -3.792,-31.065 -75.24,16.263 -0.366,2.924 -1.096,0.914 -1.005,-1.554 -0.366,-25.034 h 2.924 l 0.731,-3.198 1.462,-2.375 2.467,-3.015 52.855,-58.521 2.696,-17.679 2.558,11.878 9.274,-10.873 -0.046,-6.578 0.639,-7.767 1.005,-6.487 1.188,-4.385 2.01017,-1.005 3.28883,-0.183 -0.091,-5.939 0.274,-4.3854 0.45727,-2.923667 0.365,-1.096433 0.73116,-1.187733 1.46157,-6.7e-5 1.005,1.0051 -0.045,-3.1979 -0.137,-5.2992 0.274004,-12.2431 0.274,-9.5935 0.548,-10.6899 1.096,-10.5072 1.005,-8.1316 0.823,-3.2892 0.913,-2.01 0.731,-1.2792 0.731,-4.751 1.188,-3.6547 1.553,-3.4719 2.10138,-3.472 2.112,3.472 1.553,3.4719 1.188,3.6547 0.731,4.751 0.731,1.2792 0.913,2.01 0.823,3.2892 1.005,8.1316 1.096,10.5072 0.548,10.6899 0.274,9.5935 0.274,12.2431 -0.137,5.2992 -0.045,3.1979 1.005,-1.0051 1.46157,6.7e-5 0.73116,1.187733 0.365,1.096433 0.45727,2.923667 0.274,4.3854 -0.091,5.939 3.28883,0.183 2.01017,1.005 1.188,4.385 1.005,6.487 0.639,7.767 -0.046,6.578 9.274,10.873 2.558,-11.878 2.696,17.679 52.855,58.521 2.467,3.015 1.462,2.375 0.731,3.198 h 2.924 l -0.366,25.034 -1.005,1.554 -1.096,-0.914 -0.366,-2.924 -75.24,-16.263 -3.792,31.065 -0.274,2.832 -0.457,2.193 -2.101,-0.092 -2.832,-0.548 -2.193,16.903 31.613,30.151 0.274,1.736 0.182,2.467 v 3.015 l -0.274,2.284 -0.731,2.741 -35.45,-4.568 -3.015,8.699 H 111'
  # enable:rubocop Metrics/Linelength

  # No idea why -100 is the correct (or close enoug) offset.
  # It needs to be calculated based on the counter width.
  def offset_x
    -80
  end

  # This needs to be calculated based on the counter height
  def offset_y
    (1024 - 628) / 2
  end

  def f4_outline(xml)
    xml.path(d: PATH, fill: '#343330', id: 'path998',
             style: 'fill:#302f2e;fill-opacity:1;stroke:#00d300;stroke-opacity:1')
  end

  def top_left_value(xml)
    xml.text_('?',
              x: '200',
              y: '200',
              'text-anchor': 'middle',
              'text-align': 'center',
              'font-family': 'sans-serif',
              'font-size': font_size)
  end

  def top_right_value(xml)
    xml.text_('?',
              x: '800',
              y: '200',
              'text-anchor': 'middle',
              'text-align': 'center',
              'font-family': 'sans-serif',
              'font-size': font_size)
  end

  def f4_bounding_box(xml)
    xml.rect(
      x: '236',
      y: '0',
      width: '728',
      height: '628',
      fill: 'palegreen',
      'fill-opacity': '0.3',
      stroke: 'black',
      'stroke-width': '1'
    )
  end

  def build_counter(xml)
    counter_background(xml)
    xml.g(transform: "translate(#{offset_x},#{offset_y})") do
      f4_bounding_box(xml)
    end
    xml.g(transform: 'translate(300,180) scale(2.0)') do
      f4_outline(xml)
    end
    top_left_value(xml)
    top_right_value(xml)
  end

  def to_svg
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.svg(xmlns: 'http://www.w3.org/2000/svg', width: counter_width, height: counter_height) do
        build_counter(xml)
      end
    end
    builder.to_xml
  end
end

File.write('f4-counter.svg', F4Counter.new.to_svg)
