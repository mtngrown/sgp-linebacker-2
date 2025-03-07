#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require_relative 'counter'
require_relative 'nv_background'
class SamCounter < Counter
  include NvBackground

  def fill_color = 'rgb(100,100,100)'

  def build_counter(xml, number)
    counter_background(xml)
    xml.text_('SAM', x: '512', y: '495', 'font-size': '400', 'text-anchor': 'middle', 'text-align': 'center',
                     color: fill_color, fill: fill_color)
    xml.text_(number, x: '512', y: '895', 'font-size': '400', 'text-anchor': 'middle', 'text-align': 'center',
                      color: fill_color, fill: fill_color)
  end

  def to_svg
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.svg(xmlns: 'http://www.w3.org/2000/svg', width: counter_width, height: counter_height) do
        build_counter(xml, '0')
      end
    end
    builder.to_xml
  end
end

File.write('sam-counter.svg', SamCounter.new.to_svg)
