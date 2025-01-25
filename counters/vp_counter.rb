#! /usr/bin/env ruby
# frozen_string_literal: true

require_relative 'counter'

# For whatever "VP" stands for.
class VPCounter < Counter
  def color = 'rgb(100,100,100)'
  def build_counter(xml, number)
    counter_background(xml)
    xml.text_('VP', x: '512', y: '495', 'font-size': '400', 'text-anchor': 'middle', 'text-align': 'center', color: color, fill: color)
    xml.text_(number, x: '512', y: '895', 'font-size': '400', 'text-anchor': 'middle', 'text-align': 'center', color: color, fill: color)
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

File.write('vp-counter.svg', VPCounter.new('yellow').to_svg)
