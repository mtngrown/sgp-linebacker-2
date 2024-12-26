#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require_relative 'plus_counter'
require_relative 'radar_counter'
require_relative 'mig21_counter'
require_relative 'hit_counter'
require_relative 'sam_counter'
require_relative 's_counter'
require_relative 'vp_counter'
require_relative 'pm_counter'
require_relative 'gt_counter'
require_relative 'date_counter'

# The hex value that most closely approximates the red color
# of the flag of the Democratic Republic of Vietnam during
# the Vietnam War era is #DA251D
def nvflag_background_color
  '#DA251D'
end

def background_color
  'rgb(253,191,191)'
end

def placeholder(xml)
  xml.rect(x: '0', y: '0', width: '1024', height: '1024', fill: background_color, stroke: 'black', 'stroke-width': '2')
end

def row_1(xml)
  (1..10).each_with_index do |column, index|
    xml.g(transform: "translate(#{(column - 1) * 200},#{0 * 200}) scale(0.2)") do
      RadarCounter.new(background_color).build_counter(xml, index + 1)
    end
  end
end

def row_2(xml)
  (1..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{1 * 200}) scale(0.2)") do
      Mig21Counter.new(background_color).build_counter(xml)
    end
  end
end

def row_3(xml)
  (1..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{2 * 200}) scale(0.2)") do
    Mig21Counter.new(background_color).build_counter(xml)
  end
  end
end

def row_4(xml)
  (1..8).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{3 * 200}) scale(0.2)") do
      HitCounter.new(background_color).build_counter(xml)
    end
  end
  (9..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{3 * 200}) scale(0.2)") do
      SCounter.new(background_color).build_counter(xml)
    end
  end
end

def row_5(xml)
  (1..5).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{4 * 200}) scale(0.2)") do
      SCounter.new(background_color).build_counter(xml)
    end
  end

  vals = ['0', '00', '000']
  (6..8).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{4 * 200}) scale(0.2)") do
      SamCounter.new(background_color).build_counter(xml, vals.shift)
    end
  end
  (9..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{4 * 200}) scale(0.2)") do
      placeholder(xml)
    end
  end
end

def row_6(xml)
  (1..8).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{5 * 200}) scale(0.2)") do
      HitCounter.new(background_color).build_counter(xml)
    end
  end
  
  column = 9
  xml.g(transform: "translate(#{(column - 1) * 200},#{5 * 200}) scale(0.2)") do
    GTCounter.new(background_color).build_counter(xml)
  end

  column = 10
  xml.g(transform: "translate(#{(column - 1) * 200},#{5 * 200}) scale(0.2)") do
    DateCounter.new(background_color).build_counter(xml)
  end
end

def row_7(xml)
  vps = ['0', '00']
  (1..2).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{6 * 200}) scale(0.2)") do
      VPCounter.new(background_color).build_counter(xml, vps.shift)
    end
  end

  column = 3
  xml.g(transform: "translate(#{(column - 1) * 200},#{6 * 200}) scale(0.2)") do
    PMCounter.new(background_color).build_counter(xml)
  end

  (4..10).each do |column|
    fill = background_color
    xml.g(transform: "translate(#{(column - 1) * 200},#{6 * 200}) scale(0.2)") do
      PlusCounter.new(fill).build_counter(xml)
    end
  end
end

def to_svg # rubocop:disable Metrics/MethodLength
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.svg(xmlns: 'http://www.w3.org/2000/svg', width: '1000', height: '700') do
      xml.defs do
        xml.style(type: 'text/css') do
          xml.cdata <<-STYLE
            svg {
              font-family: Arial, Helvetica, sans-serif;
              font-size: 16px;
            }
          STYLE
        end
      end

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
