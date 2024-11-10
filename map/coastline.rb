# frozen_string_literal: true

require 'nokogiri'

# A coastline is a series of points that define the coastline.
# We'll be using various curve functions to generate the coastline.
class Coastline
  attr_reader :xml

  def points
    [
      [7.6, 0], # Top border
      [7.4, 0.3],
      [7.4, 0.6],
      [7.0, 0.6],
      [6.5, 0.4], # Furthest point inland
      [6.9, 0.7],
      [7.0, 0.9],
      [7.3, 1.0],
      [7.4, 1.0],
      [8.4, 2.9] # Eastern border
    ]
  end

  def initialize(xml)
    @xml = xml
  end

  def add_line_path
    xml.path(d: "M #{points_to_line_path}", fill: 'none', stroke: 'black', 'stroke-width': '0.02')
  end

  def add_quadratic_path
    xml.path(d: "M #{points[0][0]},#{points[0][1]} Q #{points[1][0] - 0.1},#{points[1][1] - 0.3} #{points[1][0]},#{points[1][1]} T #{points[2][0]},#{points[2][1]} T #{points[3][0]},#{points[3][1]}", fill: 'none', stroke: 'black', 'stroke-width': '0.02')
  end

  def add_cubic_path
    xml.path(d: "M #{points[0][0]},#{points[0][1]} C #{points[0][0] + 0.1},#{points[0][1] + 0.2} #{points[1][0] - 0.1},#{points[1][1]} #{points[1][0]},#{points[1][1]} S #{points[2][0] + 0.1},#{points[2][1]} #{points[3][0]},#{points[3][1]}", fill: 'none', stroke: 'black', 'stroke-width': '0.02')
  end

  def add_smooth_quadratic_path
    xml.path(d: "M #{points[0][0]},#{points[0][1]} Q #{points[0][0] + 0.1},#{points[0][1] + 0.3} #{points[1][0]},#{points[1][1]} Q #{points[2][0] + 0.1},#{points[2][1]} #{points[3][0]},#{points[3][1]}", fill: 'none', stroke: 'black', 'stroke-width': '0.02')
  end

  def add_arc_path
    xml.path(d: "M #{points[0][0]},#{points[0][1]} A 1 1 0 0 1 #{points[1][0]},#{points[1][1]} A 1 1 0 0 1 #{points[2][0]},#{points[2][1]} A 2 2 0 0 1 #{points[3][0]},#{points[3][1]}", fill: 'none', stroke: 'black', 'stroke-width': '0.02')
  end

  private

  def points_to_line_path
    points.map { |point| "#{point[0]},#{point[1]}" }.join(' ')
  end
end
