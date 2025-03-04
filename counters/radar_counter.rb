#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require_relative 'counter'
require_relative 'background_fill'
require_relative 'nv_background'

# The top 2 and half rows of the US counter sheet.
# Top row of NV counter sheet.
class RadarCounter < Counter
  include NvBackground

  def gray_index = 90

  def fill_color
    "rgb(#{gray_index},#{gray_index},#{gray_index})"
  end

  def add_value(xml, value)
    value ||= '??'
    xml.text_(value,
              x: '612',
              y: '700',
              fill: fill_color,
              stroke: fill_color,
              'text-anchor': 'middle',
              'text-align': 'center',
              'font-family': 'sans-serif',
              'font-size': '300px') # font_size
  end

  def oval_outline(xml)
    xml.circle(cx: 600, cy: 100, r: 200, fill: fill_color)
    # xml.circle(cx: 450, cy: 100, r: 200)
    # xml.circle(cx: 750, cy: 100, r: 200)
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
        build_counter(xml, 2)
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

File.write('radar-counter.svg', RadarCounter.new.to_svg)
