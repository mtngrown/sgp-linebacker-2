#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
def stroke_width
  3
end

def height
  100
end

def width
  200
end

def stroke
  'black'
end

def box_border(xml)
  xml.rect(x: 0, y: '0', width: '100', height: '100', fill: 'none', stroke:, 'stroke-width': stroke_width)
end

def box_text(xml, number)
  x = 100
  y = '65'
  xml.text_(number.to_s, x: (x / 2).to_s, y:, fill: 'black', style: 'font: bold 48px sans-serif',
                         'text-anchor': 'middle', alignment_baseline: 'central', 'font-size': '64px',
                         'font-weight': 'bold')
end

def morale_box(xml, number)
  dx = number.zero? ? 600 : (number - 1) * 100
  xml.g(transform: "translate(#{dx}, 0)") do
    box_border(xml)
    box_text(xml, number)
  end
end

def pilot_morale_text
  'US Pilot Morale'
end

def title(xml)
  xml.text_(pilot_morale_text, x: '10', y: '10', fill: 'black', style: 'font: 36px sans-serif',
                               'text-anchor': 'middle', alignment_baseline: 'central', 'font-size': '36px',
                               'font-weight': 'medium')
end

def to_svg
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.svg(xmlns: 'http://www.w3.org/2000/svg', width: '725', height: '160') do
      xml.g(transform: 'translate(20, 20)') do
        xml.g(transform: 'translate(0, 35)') do
          (1..6).each do |number|
            morale_box(xml, number)
          end
          morale_box(xml, 0)
        end
        xml.g(transform: "translate(#{725 / 2}, 20)") do
          title(xml)
        end
      end
    end
  end
  builder.to_xml
end

File.write('us-pilot-morale.svg', to_svg)
