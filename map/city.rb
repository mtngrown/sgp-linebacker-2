# frozen_string_literal: true

# A city is a square with an associated name.
# The city is centered on the square.
# The label position will be passed in as a parameter.
class City
  attr_reader :center, :name, :label_position

  def initialize(center, name, label_position)
    @center = center
    @name = name
    @label_position = label_position
  end
end
