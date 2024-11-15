# frozen_string_literal: true

require 'nokogiri'

# A coastline is a series of points that define the coastline.
# We'll be using various curve functions to generate the coastline.
class Coastline
  attr_reader :xml

  def points
    [
      [7.6, 0], # Top border Zone 2
      [7.4, 0.3],
      [7.4, 0.6],
      [7.0, 0.6],
      [6.5, 0.4], # Furthest point inland Zone 2
      [6.9, 0.7],
      [7.0, 0.9],
      [7.3, 1.0],
      [7.4, 1.0],
      [7.35, 1.4],
      [7.5, 1.45],
      [7.5, 1.5],
      [7.5, 1.8],
      [7.4, 2.0],
      [7.6, 2.2],
      [7.5, 2.3],
      [7.8, 2.5],
      [7.9, 2.7],
      [8.4, 2.9], # Eastern border
      [8.6, 3.0], # first point in Sourh China Sea
      [8.65, 3.25],
      [8.75, 3.35],
      [8.85, 3.6],
      [8.9, 3.9],
      [8.7, 4.2],
      [8.8, 4.15],
      [8.9, 5.2],
      [8.95, 5.5],
      [8.85, 5.85],
      [8.65, 6.2],
      [8.65, 6.5],
      [8.7, 6.7], # Last point in South China Sea, southern border
      [8.7, 6.8],
      [8.95, 7.1],
      [8.9, 7.3],
      [9.1, 7.55],
      [9.0, 7.85],
      [8.85, 8.15],
      [9.3, 8.1],
      [9.5, 8.3],
      [9.65, 8.5],
      [9.60, 8.7],
      [9.80, 8.95],
      [10.20, 9.0],
      [10.35, 9.10],
      [10.55, 9.25],
      [10.75, 9.30],
      [10.90, 9.60] # Last point in Zone 6 Than Hoa
    ]
  end

  def initialize(xml)
    @xml = xml
  end

  def add_line_path
    xml.path(d: "M #{points_to_line_path}", fill: 'none', stroke: 'gray', 'stroke-width': '0.2',
             'stroke-linejoin': 'round')
  end

  def add_circles(radius = 0.05, fill = 'blue', stroke = 'blue', stroke_width = 0.01)
    points.each do |x, y|
      xml.circle(cx: x, cy: y, r: radius, fill: fill, stroke: stroke, 'stroke-width': stroke_width)
    end
  end

  def add_quadratic_path
    xml.path(
      d: "M #{points[0][0]},#{points[0][1]} Q #{points[1][0] - 0.1},#{points[1][1] - 0.3} #{points[1][0]},#{points[1][1]} T #{points[2][0]},#{points[2][1]} T #{points[3][0]},#{points[3][1]}", fill: 'none', stroke: 'black', 'stroke-width': '0.02'
    )
  end

  def add_cubic_path
    xml.path(
      d: "M #{points[0][0]},#{points[0][1]} C #{points[0][0] + 0.1},#{points[0][1] + 0.2} #{points[1][0] - 0.1},#{points[1][1]} #{points[1][0]},#{points[1][1]} S #{points[2][0] + 0.1},#{points[2][1]} #{points[3][0]},#{points[3][1]}", fill: 'none', stroke: 'black', 'stroke-width': '0.02'
    )
  end

  def add_smooth_quadratic_path
    xml.path(
      d: "M #{points[0][0]},#{points[0][1]} Q #{points[0][0] + 0.1},#{points[0][1] + 0.3} #{points[1][0]},#{points[1][1]} Q #{points[2][0] + 0.1},#{points[2][1]} #{points[3][0]},#{points[3][1]}", fill: 'none', stroke: 'black', 'stroke-width': '0.02'
    )
  end

  def add_arc_path
    xml.path(
      d: "M #{points[0][0]},#{points[0][1]} A 1 1 0 0 1 #{points[1][0]},#{points[1][1]} A 1 1 0 0 1 #{points[2][0]},#{points[2][1]} A 2 2 0 0 1 #{points[3][0]},#{points[3][1]}", fill: 'none', stroke: 'black', 'stroke-width': '0.02'
    )
  end

  private

  def points_to_line_path
    points.map { |point| "#{point[0]},#{point[1]}" }.join(' ')
  end
end
