#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rspec/autorun'

# This is an aborted attempt at computing a bounding box for a bezier path.
# It can't be done by just examining the control points, it has to be drawn.
# Given that linear paths with rounded joins and end caps will be perfectly
# adequate, going deeper on this is not warranted at the time of writing.
class BoundingBox
  def analyze_svg_path(path)
    # Initialize variables
    current_pos = [0, 0]
    bounding_box = { min_x: Float::INFINITY, min_y: Float::INFINITY, max_x: -Float::INFINITY, max_y: -Float::INFINITY }

    # Parse the path into commands and coordinates
    commands = path.scan(/([a-zA-Z])|([-+]?\d*\.?\d+)/).map { |c| c[0] || c[1] }

    # Process commands and their arguments
    commands.each_with_index do |command, index|
      case command
      when 'm', 'M' # Moveto
        dx, dy = commands[index + 1, 2].map(&:to_f)
        current_pos = command == 'm' ? [current_pos[0] + dx, current_pos[1] + dy] : [dx, dy]
        bounding_box = update_bounding_box(bounding_box, current_pos)
      when 'c', 'C' # Cubic Bézier
        3.times do |i|
          dx, dy = commands[index + 1 + (i * 2), 2].map(&:to_f)
          point = command == 'c' ? [current_pos[0] + dx, current_pos[1] + dy] : [dx, dy]
          bounding_box = update_bounding_box(bounding_box, point)
        end
        # Update current position to the final point
        dx, dy = commands[index + 7, 2].map(&:to_f)
        current_pos = command == 'c' ? [current_pos[0] + dx, current_pos[1] + dy] : [dx, dy]
      when 'z', 'Z' # Closepath
        # Typically returns to the start position, no bounding box update needed
        next
      end
    end

    # Return bounding box corners
    {
      upper_left: [bounding_box[:min_x], bounding_box[:max_y]],
      lower_right: [bounding_box[:max_x], bounding_box[:min_y]]
    }
  end

  def update_bounding_box(bounding_box, point)
    x, y = point
    {
      min_x: [bounding_box[:min_x], x].min,
      min_y: [bounding_box[:min_y], y].min,
      max_x: [bounding_box[:max_x], x].max,
      max_y: [bounding_box[:max_y], y].max
    }
  end

  # Example usage
  # path = "m 622.45845,159.08844 c 23.74432,18.62321 48.57869,40.29445 72.83369,57.83845 -0.964,-11.228 0.369,-22.228 4,-33 ..."
  # bounding_box = analyze_svg_path(path)
  # puts bounding_box
end

RSpec.describe BoundingBox do
  it 'analyzes the bounding box of an SVG path' do
    path = 'm 622.45845,159.08844 c 23.74432,18.62321 48.57869,40.29445 72.83369,57.83845 -0.964,-11.228 0.369,-22.228 4,-33 ...'
    bounding_box = BoundingBox.new.analyze_svg_path(path)
    expect(bounding_box).to eq({ upper_left: [200, 0], lower_right: [800, 635] })
  end

  it
end
