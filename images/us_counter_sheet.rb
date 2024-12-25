#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'

require_relative 'b52_counter'
require_relative 'f4_counter'
require_relative 'f111_counter'
require_relative 'radar_counter'

# 8 rows, 10 columns.

# Row 3, rolumns 4-10 are B52
# Row 4, columns 1-10 are B52
# Row 5, columns 1-7 are B52

def placeholder(xml)
  xml.rect(x: '0', y: '0', width: '1024', height: '1024', fill: 'none', stroke: 'black', 'stroke-width': '2')
end

def background_color
  'rgb(183,208,220)'
end

def row_1(xml)
  (1..10).each_with_index do |column, index|
    xml.g(transform: "translate(#{(column - 1) * 200},#{0 * 200}) scale(0.2)") do
      RadarCounter.new(background_color).build_counter(xml, index + 1)
    end
  end
end

def row_2(xml)
  (1..10).each_with_index do |column, index|
    xml.g(transform: "translate(#{(column - 1) * 200},#{1 * 200}) scale(0.2)") do
      RadarCounter.new(background_color).build_counter(xml, index + 11)
    end
  end
end

def row_3(xml)
  (1..3).each_with_index do |column, index|
    xml.g(transform: "translate(#{(column - 1) * 200},#{2 * 200}) scale(0.2)") do
      RadarCounter.new(background_color).build_counter(xml, index + 21)
    end
  end
  (4..8).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{2 * 200}) scale(0.2)") do
      B52Counter.new(background_color).build_counter(xml, '9')
    end
  end
  (9..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{2 * 200}) scale(0.2)") do
      B52Counter.new(background_color).build_counter(xml, '6')
    end
  end
end

def row_4(xml)
  (1..8).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{3 * 200}) scale(0.2)") do
      B52Counter.new(background_color).build_counter(xml, '6')
    end
  end
  (9..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{3 * 200}) scale(0.2)") do
      B52Counter.new(background_color).build_counter(xml, '3')
    end
  end
end

def row_5(xml)
  (1..7).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{4 * 200}) scale(0.2)") do
      B52Counter.new(background_color).build_counter(xml, '3')
    end
  end
  (8..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{4 * 200}) scale(0.2)") do
      F111Counter.new(background_color).build_counter(xml, '4')
    end
  end
end

def row_6(xml)
  (1..2).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{5 * 200}) scale(0.2)") do
      F111Counter.new(background_color).build_counter(xml, '4')
    end
  end

  (3..7).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{5 * 200}) scale(0.2)") do
      F111Counter.new(background_color).build_counter(xml, '2')
    end
  end

  column = 8
  xml.g(transform: "translate(#{(column - 1) * 200},#{5 * 200}) scale(0.2)") do
    F4Counter.new(background_color).build_counter(xml, '16')
  end

  (9..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{5 * 200}) scale(0.2)") do
      F4Counter.new(background_color).build_counter(xml, '8')
    end
  end
end

def row_7(xml)
  (1..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{6 * 200}) scale(0.2)") do
      F4Counter.new(background_color).build_counter(xml, '8')
    end
  end
end

def row_8(xml)
  (1..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{7 * 200}) scale(0.2)") do
      F4Counter.new(background_color).build_counter(xml, '8')
    end
  end
end

def to_svg # rubocop:disable Metrics/MethodLength
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.svg(xmlns: 'http://www.w3.org/2000/svg', width: '2000', height: '1600') do
      xml.g(transform: 'scale(0.5)') do
        row_1(xml)
        row_2(xml)
        row_3(xml)
        row_4(xml)
        row_5(xml)
        row_6(xml)
        row_7(xml)
        row_8(xml)
      end
    end
  end
  builder.to_xml
end

File.write('us-counter-sheet.svg', to_svg)
