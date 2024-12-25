#! /usr/bin/env ruby
# frozen_string_literal: true

require_relative 'counter'

# For whatever "Date" stands for.
class DateCounter < Counter
  def color = 'rgb(100,100,100)'
  def build_counter(xml)
    counter_background(xml)
    xml.text_('Date',
      x: '512',
      y: '695',
      'font-size': '500',
      'text-anchor': 'middle',
      'text-align': 'center',
      transform: 'rotate(45, 512, 695)',
      color: color,
      fill: color
    )
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

File.write('date-counter.svg', DateCounter.new('yellow').to_svg)
