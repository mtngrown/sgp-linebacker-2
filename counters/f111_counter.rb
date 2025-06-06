#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require_relative 'counter'

# This is the F111 counter.
class F111Counter < Counter
  PATH = 'M 494.265 953.654 L 490.822 951.843 L 490.822 938.47 L 490.543 922.729 L 487.2 913.814 L 477.588 920.5 L 466.723 921.475 L 454.464 921.057 L 444.713 920.361 L 440.673 918.689 L 436.634 916.321 L 436.773 922.868 L 435.798 929.415 L 434.683 935.266 L 433.29 940.002 L 431.201 943.485 L 428.833 943.903 L 425.211 938.191 L 423.818 932.619 L 422.982 926.49 L 421.728 918.968 L 348.602 936.937 L 307.234 905.108 L 424.018 721.147 L 420.902 619.027 L 394.11 637.496 L 40.0534 643.504 L 40.0654 637.171 L 40.5044 629.685 L 41.1994 621.897 L 42.3114 615.153 L 45.0004 610.588 L 49.0314 605.653 L 54.2244 601.425 L 59.2084 599.277 L 388.988 503.141 L 457.938 321.506 L 457.15 287.228 L 458.57 239.917 L 461.878 200.547 L 476.85 139.871 L 486.157 118.121 L 494.133 107.563 L 502.108 118.121 L 511.415 139.871 L 526.387 200.547 L 529.695 239.917 L 531.115 287.228 L 530.327 321.506 L 599.277 503.141 L 929.057 599.277 L 934.041 601.425 L 939.234 605.653 L 943.265 610.588 L 945.954 615.153 L 947.066 621.897 L 947.761 629.685 L 948.2 637.171 L 948.212 643.504 L 594.155 637.496 L 567.363 619.027 L 564.247 721.147 L 681.031 905.108 L 639.663 936.937 L 566.537 918.968 L 565.283 926.49 L 564.447 932.619 L 563.054 938.191 L 559.432 943.903 L 557.064 943.485 L 554.975 940.002 L 553.582 935.266 L 552.467 929.415 L 551.492 922.868 L 551.631 916.321 L 547.592 918.689 L 543.552 920.361 L 533.801 921.057 L 521.542 921.475 L 510.677 920.5 L 501.065 913.814 L 497.722 922.729 L 497.443 938.47 L 497.443 951.843 L 494 953.654'

  def fill = 'rgb(100,100,100)'

  def f111_outline(xml)
    xml.path(d: PATH,
             fill: fill, # '#343330',
             style: 'fill-opacity:1;stroke:#00d300;stroke-opacity:1')
  end

  def build_counter(xml, number)
    counter_background(xml)
    xml.g(transform: "translate(#{offset_x},#{offset_y})") do
      bounding_box(xml)
    end
    xml.g(transform: 'translate(153,120) scale(0.75)') do
      f111_outline(xml)
    end
    top_left_value(xml, number)
    top_right_value(xml, 'S')
  end

  def to_svg
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.svg(xmlns: 'http://www.w3.org/2000/svg', width: counter_width, height: counter_height) do
        build_counter(xml, '4')
      end
    end
    builder.to_xml
  end
end

File.write('f111-counter.svg', F111Counter.new('#A0A6E7').to_svg)
