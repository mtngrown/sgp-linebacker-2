# frozen_string_literal: true

require_relative 'default_styling'

# Legend is to the left of the map area.
class AirfieldLegend
  include DefaultStyling
  xoffset = 0.1
  yoffset = 8.3
  linespace = 0.5

  AIRFIELDS = [
    { position: [xoffset, yoffset], label: 1, name: 'Dong Hi' },
    { position: [xoffset, yoffset + linespace], label: 2, name: 'Sep' },
    { position: [xoffset, yoffset + (2 * linespace)], label: 3, name: 'Bao Giang' },
    { position: [xoffset, yoffset + (3 * linespace)], label: 4, name: 'Kim Anh' },
    { position: [xoffset, yoffset + (4 * linespace)], label: 5, name: 'Gia Lam' },
    { position: [xoffset, yoffset + (5 * linespace)], label: 6, name: 'Bac Mai' },
    { position: [xoffset, yoffset + (6 * linespace)], label: 7, name: 'Kien Anh' },
    { position: [xoffset, yoffset + (7 * linespace)], label: 8, name: 'Ninh Binh' },
    { position: [xoffset, yoffset + (8 * linespace)], label: 9, name: 'Yen Dai' },
    { position: [xoffset, yoffset + (9 * linespace)], label: 10, name: 'Thanh Hoa' }
  ].freeze

  attr_reader :xml

  def initialize(xml)
    @xml = xml
  end

  def to_svg
    AIRFIELDS.each do |af|
      xml.text_("#{af[:label]}. #{af[:name]}",
                x: af[:position][0],
                y: af[:position][1],
                'font-size': '0.4',
                fill: text_color,
                'font-weight': 'bold',
                'font-family': "'Courier New', Courier, monospace")
    end
  end
end 