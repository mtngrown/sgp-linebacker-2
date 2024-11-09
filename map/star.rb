# Five pointed star representing targets
class Star
  DEFAULT_INNER_RADIUS_RATIO = 0.5
  DEFAULT_FILL = "gold"
  DEFAULT_STROKE = "black"
  DEFAULT_STROKE_WIDTH = 1
  DEFAULT_FONT_SIZE = 1
  DEFAULT_LABEL_COLOR = "black"
  attr_reader :center, :outer_radius, :inner_radius, :label, :label_offset, :fill, :stroke, :stroke_width, :font_size, :label_color
  
  def initialize(center, radius, options = {})
    @center = center
    @outer_radius = radius
    @inner_radius = options[:inner_radius] || radius * DEFAULT_INNER_RADIUS_RATIO
    @label = options[:label]
    @label_offset = options[:label_offset] || [0, 0]
    @fill = options[:fill] || DEFAULT_FILL
    @stroke = options[:stroke] || DEFAULT_STROKE
    @stroke_width = options[:stroke_width] || DEFAULT_STROKE_WIDTH
    @font_size = options[:font_size] || DEFAULT_FONT_SIZE
    @label_color = options[:label_color] || DEFAULT_LABEL_COLOR
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
    star_path(center[0], center[1], outer_radius, inner_radius)
  end
end
