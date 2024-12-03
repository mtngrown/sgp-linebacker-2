#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'

def placeholder(xml)
  xml.rect(x: '0', y: '0', width: '1024', height: '1024', fill: 'none', stroke: 'black', 'stroke-width': '2')
end

def row_1(xml)
  (1..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{0 * 200}) scale(0.2)") do
      placeholder(xml)
    end
  end
end

def row_2(xml)
  (1..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{1 * 200}) scale(0.2)") do
      placeholder(xml)
    end
  end
end

def row_3(xml)
  (1..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{2 * 200}) scale(0.2)") do
      placeholder(xml)
    end
  end
end

def row_4(xml)
  (1..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{3 * 200}) scale(0.2)") do
      placeholder(xml)
    end
  end
end

def row_5(xml)
  (1..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{4 * 200}) scale(0.2)") do
      placeholder(xml)
    end
  end
end

def row_6(xml)
  (1..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{5 * 200}) scale(0.2)") do
      placeholder(xml)
    end
  end
end

def row_7(xml)
  (1..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{6 * 200}) scale(0.2)") do
      placeholder(xml)
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
      end
    end
  end
  builder.to_xml
end

File.write('nv-counter-sheet.svg', to_svg)
