#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require_relative 'counter'
require_relative 'nv_background'

# A counter with the word "HIT" in the center.
class HitCounter < Counter
  include NvBackground

  def fill_color = 'rgb(100,100,100)'

  def build_counter(xml)
    counter_background(xml)
    xml.text_(
      'HIT',
      x: '512',
      y: '695',
      'font-size': '500',
      'text-anchor': 'middle',
      'text-align': 'center',
      fill: fill_color,
      color: fill_color
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

File.write('hit-counter.svg', HitCounter.new.to_svg)
