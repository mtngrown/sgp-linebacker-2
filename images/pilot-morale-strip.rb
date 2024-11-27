#! /usr/bin/env ruby


# Save SVG content to a file
# Here is the prompt:
#
# This next one is a lot more interesting, you might find it
# stetches your expertise. What we're going to do is create an
# SVG file which contains the attached image. After the image
# is correct, we'll create a Ruby script to emit the image. The
# image is very simple, it's just a boxed strip of numbers. The
# absolute scales don't matter as much as having the 7 boxes all
# the same size and perfectly aligned. It's fine to draw each box
# individually, and have adjacent borders overlap. Here's the
# image, and good luck!

require 'nokogiri'

svg_content = <<~SVG
<?xml version="1.0" ?>
<svg xmlns="http://www.w3.org/2000/svg" width="1400" height="100">
    <rect x="0" y="0" width="200" height="100" fill="white" stroke="black" stroke_width="2"/>
    <text x="100.0" y="60.0" fill="black" style="font: bold 48px sans-serif" text_anchor="middle" alignment_baseline="central">1</text>
    <rect x="200" y="0" width="200" height="100" fill="white" stroke="black" stroke_width="2"/>
    <text x="300.0" y="60.0" fill="black" style="font: bold 48px sans-serif" text_anchor="middle" alignment_baseline="central">2</text>
    <rect x="400" y="0" width="200" height="100" fill="white" stroke="black" stroke_width="2"/>
    <text x="500.0" y="60.0" fill="black" style="font: bold 48px sans-serif" text_anchor="middle" alignment_baseline="central">3</text>
    <rect x="600" y="0" width="200" height="100" fill="white" stroke="black" stroke_width="2"/>
    <text x="700.0" y="60.0" fill="black" style="font: bold 48px sans-serif" text_anchor="middle" alignment_baseline="central">4</text>
    <rect x="800" y="0" width="200" height="100" fill="white" stroke="black" stroke_width="2"/>
    <text x="900.0" y="60.0" fill="black" style="font: bold 48px sans-serif" text_anchor="middle" alignment_baseline="central">5</text>
    <rect x="1000" y="0" width="200" height="100" fill="white" stroke="black" stroke_width="2"/>
    <text x="1100.0" y="60.0" fill="black" style="font: bold 48px sans-serif" text_anchor="middle" alignment_baseline="central">6</text>
    <rect x="1200" y="0" width="200" height="100" fill="white" stroke="black" stroke_width="2"/>
    <text x="1300.0" y="60.0" fill="black" style="font: bold 48px sans-serif" text_anchor="middle" alignment_baseline="central">0</text>
</svg>
SVG

# File.write('us_pilot_morale.svg', svg_content)

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

def morale_box(xml, number)
  dx = number.zero? ? 600 : (number - 1) * 100
  xml.g(transform: "translate(#{dx}, 0)") do
    xml.rect(x: 0, y: '0', width: '100', height: '100', fill: 'white', stroke:, 'stroke-width': stroke_width)
    x = 100
    y = '65'
    xml.text_(number.to_s, x: (x / 2).to_s, y:, fill: 'black', style: 'font: bold 48px sans-serif', 'text-anchor': 'middle', alignment_baseline: 'central', 'font-size': '48px', 'font-weight': 'bold')
end
end

def to_svg
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.svg(xmlns: 'http://www.w3.org/2000/svg', width: '725', height: '125') do
      xml.g(transform: 'translate(20, 20)') do
      morale_box(xml, 1)
      morale_box(xml, 2)
      morale_box(xml, 3)
      morale_box(xml, 4)
      morale_box(xml, 5)
      morale_box(xml, 6)
      morale_box(xml, 0)
      end
    end
  end
  builder.to_xml
end

File.write('us-pilot-morale.svg', to_svg)