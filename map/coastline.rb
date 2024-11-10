# frozen_string_literal: true

# A coastline is a series of points that define the coastline.
# We'll be using various curve functions to generate the coastline.
class Coastline
  def to_line_svg
    <<~SVG
      <path d='M #{points_to_path}' fill='none' stroke='black' stroke-width='0.02' />
    SVG
  end

  def to_quadratic_svg
    <<~SVG
      <path d='M #{points[0][0]},#{points[0][1]} Q #{points[1][0] - 0.1},#{points[1][1] - 0.3} #{points[1][0]},#{points[1][1]} T #{points[2][0]},#{points[2][1]} T #{points[3][0]},#{points[3][1]}' fill='none' stroke='black' stroke-width='0.02' />
    SVG
  end

  def to_cubic_svg
    <<~SVG
      <path d='M #{points[0][0]},#{points[0][1]} C #{points[0][0] + 0.1},#{points[0][1] + 0.2} #{points[1][0] - 0.1},#{points[1][1]} #{points[1][0]},#{points[1][1]} S #{points[2][0] + 0.1},#{points[2][1]} #{points[3][0]},#{points[3][1]}' fill='none' stroke='black' stroke-width='0.02' />
    SVG
  end

  def to_smooth_quadratic_svg
    <<~SVG
      <path d='M #{points[0][0]},#{points[0][1]} Q #{points[0][0] + 0.1},#{points[0][1] + 0.3} #{points[1][0]},#{points[1][1]} Q #{points[2][0] + 0.1},#{points[2][1]} #{points[3][0]},#{points[3][1]}' fill='none' stroke='black' stroke-width='0.02' />
    SVG
  end

  def to_arc_svg
    <<~SVG
      <path d='M #{points[0][0]},#{points[0][1]} A 1 1 0 0 1 #{points[1][0]},#{points[1][1]} A 1 1 0 0 1 #{points[2][0]},#{points[2][1]} A 2 2 0 0 1 #{points[3][0]},#{points[3][1]}' fill='none' stroke='black' stroke-width='0.02' />
    SVG
  end

  private

  def points
    [
      [7.6, 0],
      [7.4, 0.6],
      [6.5, 0.4],
      [8.4, 2.9]
    ]
  end

  def points_to_path
    points.map { |point| "#{point[0]},#{point[1]}" }.join(' ')
  end
end
