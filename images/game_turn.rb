#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
def stroke_width
  3
end

def stroke
  'black'
end

def box_border(xml)
  xml.rect(x: 0, y: '0', width: '100', height: '100', fill: 'none', stroke:, 'stroke-width': stroke_width)
end

def box_text(xml, number)
  x = 100
  y = '70'
  xml.text_(number.to_s, x: (x / 2).to_s, y:, fill: 'black', style: 'font: bold 64px sans-serif',
                         'text-anchor': 'middle', alignment_baseline: 'central', 'font-size': '64px',
                         'font-weight': 'bold')
end

def turn_box(xml, number)
  dy = number.zero? ? 900 : (number - 1) * 100
  xml.g(transform: "translate(0, #{dy})") do
    box_border(xml)
    box_text(xml, number)
  end
end

def to_svg
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.svg(xmlns: 'http://www.w3.org/2000/svg', width: '125', height: '1025') do
      xml.g(transform: 'translate(20, 20)') do
        (1..9).each do |number|
          turn_box(xml, number)
        end
      end
    end
  end
  builder.to_xml
end

File.write('game-turn.svg', to_svg)
