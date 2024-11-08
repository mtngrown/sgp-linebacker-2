# Five pointed star representing targets
class Star
  attr_reader :center, :radius
  def initialize(center, radius)
    @center = center
    @radius = radius
  end

  def fill
    "white"
  end

  def stroke
    "black"
  end

  def stroke_width
    0.05
  end

  def points
    # five pointed star
    # https://en.wikipedia.org/wiki/Star_polygon
    [
      [center[0], center[1] - radius],
      [center[0] + radius * Math.cos(Math::PI / 5), center[1] - radius * Math.sin(Math::PI / 5)],
      [center[0] + radius * Math.cos(2 * Math::PI / 5), center[1] - radius * Math.sin(2 * Math::PI / 5)],
      [center[0] + radius * Math.cos(3 * Math::PI / 5), center[1] - radius * Math.sin(3 * Math::PI / 5)],
      [center[0] + radius * Math.cos(4 * Math::PI / 5), center[1] - radius * Math.sin(4 * Math::PI / 5)]
    ].map { |point| point.join(",") }.join(" ")
  end

  # def to_svg
  #   # five pointed star
  #   # https://en.wikipedia.org/wiki/Star_polygon
  #   "<polygon points='#{points}' fill='#{fill}' stroke='#{stroke}' stroke-width='#{stroke_width}cm' />"
  # end

  def star_points(cx, cy, outer_radius, inner_radius)
    points = []
    angle = Math::PI / 5 # 36 degrees in radians
  
    (0...10).each do |i|
      radius = i.even? ? outer_radius : inner_radius
      x = cx + radius * Math.cos(i * angle - Math::PI / 2)
      y = cy + radius * Math.sin(i * angle - Math::PI / 2)
      points << [x.round(2), y.round(2)]
    end
  
    points
  end
  
  def star_polygon(cx, cy, outer_radius, inner_radius, fill: "gold", stroke: "black", stroke_width: 1)
    points = star_points(cx, cy, outer_radius, inner_radius)
    points_str = points.map { |x, y| "#{x},#{y}" }.join(" ")
    "<polygon points='#{points_str}' fill='#{fill}' stroke='#{stroke}' stroke-width='#{stroke_width}' />"
  end
  
  def star_path(cx, cy, outer_radius, inner_radius, fill: "gold", stroke: "black", stroke_width: 0.2)
    points = star_points(cx, cy, outer_radius, inner_radius)
    path_data = "M #{points[0][0]},#{points[0][1]} " + points[1..].map { |x, y| "L #{x},#{y}" }.join(" ") + " Z"
    "<path d='#{path_data}' fill='#{fill}' stroke='#{stroke}' stroke-width='#{stroke_width}' />"
  end

  def to_svg
    star_path(center[0], center[1], radius, radius * 0.5)
  end
end
