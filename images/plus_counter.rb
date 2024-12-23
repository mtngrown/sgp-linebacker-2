# frozen_string_literal: true

require_relative 'counter'

# A single big plus sign in the center of the counter.
class PlusCounter < Counter
  def build_counter(xml)
    counter_background(xml)
    xml.text_('+', x: '512', y: '712', 'font-size': '500', 'text-anchor': 'middle', 'text-align': 'center')
  end
end
