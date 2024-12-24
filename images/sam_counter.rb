#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require_relative 'counter'

class SamCounter < Counter
  def build_counter(xml, number)
    counter_background(xml)
    xml.text_('SAM', x: '512', y: '495', 'font-size': '400', 'text-anchor': 'middle', 'text-align': 'center')
    xml.text_(number, x: '512', y: '895', 'font-size': '400', 'text-anchor': 'middle', 'text-align': 'center')
  end

  def to_svg
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.svg(xmlns: 'http://www.w3.org/2000/svg', width: counter_width, height: counter_height) do
        ['0', '00', '000'].each do |number|
          build_counter(xml, number)
        end
      end
    end
    builder.to_xml
  end
end

File.write('sam-counter.svg', SamCounter.new('yellow').to_svg)