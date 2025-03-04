# frozen_string_literal: true

require_relative 'background_fill'

# Background color for US aircraft counters
module UsBackground
  include BackgroundFill

  def color
    'rgb(191,223,255)' # Light blue color for US counters
  end
end
