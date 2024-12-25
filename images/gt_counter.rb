#! /usr/bin/env ruby
# frozen_string_literal: true

require_relative 'counter'

# For whatever "GT" stands for.
class GTCounter < Counter
  def build_counter(xml)
    counter_background(xml)
    xml.text_('GT', x: '512', y: '695', 'font-size': '500', 'text-anchor': 'middle', 'text-align': 'center')
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

File.write('gt-counter.svg', GTCounter.new('yellow').to_svg)