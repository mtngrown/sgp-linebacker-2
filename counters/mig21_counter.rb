#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require_relative 'counter'
require_relative 'nv_background'

class Mig21Counter < Counter
  include NvBackground

  # def color
  #   'rgb(253,191,191)'
  # end

  PATH = 'M 320.579 987.483 L 321.74 981.095 L 321.934 973.158 L 323.87 967.544 L 322.902 954.38 L 323.095 945.862 L 322.708 941.409 L 322.127 938.699 L 322.127 897.272 L 322.127 897.272 L 345.938 897.853 L 345.938 898.821 L 349.81 900.756 L 351.552 907.725 L 434.02 966.769 L 437.118 967.156 L 440.215 965.221 L 440.989 961.736 L 441.57 878.881 L 439.441 874.042 L 436.73 878.881 L 435.956 901.918 L 356.392 771.441 L 356.005 700.588 L 358.134 700.588 L 360.651 699.427 L 551.333 699.04 L 553.076 710.268 L 553.85 698.459 L 555.012 692.651 L 554.237 665.356 L 451.443 507.002 L 448.346 485.321 L 445.635 497.904 L 445.248 497.129 L 444.667 497.323 L 359.102 364.136 L 355.618 302.382 L 353.875 237.917 L 352.908 189.908 L 351.552 165.323 L 349.036 124.863 L 347.874 113.635 L 345.551 104.924 L 342.067 104.149 L 336.453 103.569 L 319.998 43.1697 L 317 10.6472 L 314.14 43.1697 L 297.685 103.569 L 292.071 104.149 L 288.587 104.924 L 286.264 113.635 L 285.102 124.863 L 282.586 165.323 L 281.23 189.908 L 280.263 237.917 L 278.52 302.382 L 275.036 364.136 L 189.471 497.323 L 188.89 497.129 L 188.503 497.904 L 185.792 485.321 L 182.695 507.002 L 79.9006 665.356 L 79.1256 692.651 L 80.2876 698.459 L 81.0616 710.268 L 82.8046 699.04 L 273.487 699.427 L 276.004 700.588 L 278.133 700.588 L 277.746 771.441 L 198.182 901.918 L 197.408 878.881 L 194.697 874.042 L 192.568 878.881 L 193.149 961.736 L 193.923 965.221 L 197.02 967.156 L 200.118 966.769 L 282.586 907.725 L 284.328 900.756 L 288.2 898.821 L 288.2 897.853 L 312.011 897.272 L 312.011 897.272 L 312.011 938.699 L 311.43 941.409 L 311.043 945.862 L 311.236 954.38 L 310.268 967.544 L 312.204 973.158 L 312.398 981.095 L 313.559 987.483 L 317 994.259 L 320.579 987.483'

  def fill = 'rgb(100,100,100)'

  def mig21_outline(xml)
    xml.path(
      d: PATH,
      fill: fill,
      style: 'fill-opacity:1;stroke:#00d300;stroke-opacity:1'
    )
  end

  def build_counter(xml)
    counter_background(xml)
    xml.g(transform: "translate(#{offset_x},#{offset_y})") do
      bounding_box(xml)
    end
    xml.g(transform: 'translate(150,350) scale(0.50)') do
      mig21_outline(xml)
    end
    xml.g(transform: 'translate(550,180) scale(0.50)') do
      mig21_outline(xml)
    end
  end

  def to_svg
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.svg(xmlns: 'http://www.w3.org/2000/svg', width: counter_width, height: counter_height) do
        build_counter(xml)
      end
    end
    builder.to_xml
  end
end

File.write('mig21-counter.svg', Mig21Counter.new.to_svg)
