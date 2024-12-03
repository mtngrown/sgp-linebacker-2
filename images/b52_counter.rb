#!/usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
# require_relative 'bounding_box'

# One single B52 counter
class B52Counter
  # rubocop:disable Layout/LineLength
  PATH = 'm 622.45845,159.08844 c 23.74432,18.62321 48.57869,40.29445 72.83369,57.83845 -0.964,-11.228 0.369,-22.228 4,-33 5.407,-0.973 10.907,-1.307 16.5,-1 1.336,-6.202 3.002,-6.369 5,-0.5 5,0.333 10,0.667 15,1 2.76,7.042 4.426,14.375 5,22 -0.12,12.36 -1.62,24.527 -4.5,36.5 -1.399,0.727 -2.899,1.227 -4.5,1.5 21.70236,15.55935 43.29157,31.2747 64.76763,47.14603 2.41222,1.78269 4.82301,3.56735 7.39827,4.30207 0.085,-8.44651 0.1589,-8.60404 0.37406,-13.03071 0.262,-5.15 2.7629,-20.32828 5.1679,-24.84428 5,-0.333 10,-0.667 15,-1 1.769,-5.369 3.435,-5.536 5,-0.5 5.333,0.667 10.667,1.333 16,2 2.574,7.272 4.241,14.772 5,22.5 -0.611,12.336 -2.277,24.503 -5,36.5 -3.79,-0.492 -4.456,0.341 -2,2.5 37.49,27.578 75.156,54.911 113,82 2.7,1.857 4.366,4.357 5,7.5 0.33,16.175 -0.004,32.175 -1,48 -40.306,-22.154 -80.64,-44.321 -121,-66.5 -5.667,-0.333 -11.333,-0.667 -17,-1 -63.895,-34.446 -126.43042,-68.54389 -190.53542,-102.43089 -2.64791,-2.015 -6.14058,-3.75111 -9.95053,-5.29947 -0.89415,5.50716 0.44198,116.45928 -0.36239,149.01269 C 621.1033,441.44674 619.416,466.847 618.5,476 c 0.333,1.833 0.667,3.667 1,5.5 26.349,24.85 52.849,49.517 79.5,74 0.5,10.328 0.666,20.661 0.5,31 -29.637,-3.609 -59.303,-6.942 -89,-10 -0.36909,14.77754 -0.87841,27.52579 -2.23597,42.90999 -1.62291,3.45746 -0.30931,1.12201 -2.76404,6.09001 -4,2.667 -8,2.667 -12,0 -0.535,-2.161 -1.368,-4.161 -2.5,-6 -1.268,-14.312 -2.101,-28.645 -2.5,-43 -29.703,2.973 -59.37,6.306 -89,10 -0.166,-10.339 0,-20.672 0.5,-31 26.635,-24.3 52.968,-48.967 79,-74 0.499,-3.652 0.49816,-12.49014 0.35759,-17.00738 -0.71657,-15.49823 -2.43249,-22.82209 -3.02549,-37.49209 1.157,-49.292 1.76973,-97.50349 1.60456,-146.18901 C 573.29981,282.9291 568.856,285.401 565.5,287.5 c -62.973,33.821 -125.973,67.654 -189,101.5 -6,0.333 -12,0.667 -18,1 -39.839,22.42 -79.839,44.587 -120,66.5 -0.333,-8.333 -0.667,-16.667 -1,-25 -0.14,-9.096 0.36,-18.096 1.5,-27 39.411,-29.289 78.911,-58.455 118.5,-87.5 -3.493,-0.165 -5.326,-1.998 -5.5,-5.5 -1.65,-10.279 -2.816,-20.612 -3.5,-31 0.705,-7.905 2.372,-15.572 5,-23 5.333,-0.667 10.667,-1.333 16,-2 1.565,-5.036 3.231,-4.869 5,0.5 5,0.333 10,0.667 15,1 4.709,9.694 6.042,19.861 4,30.5 0.333,1 0.667,2 1,3 23.667,-17.333 47.333,-34.667 71,-52 -1.128,-0.762 -2.295,-1.429 -3.5,-2 -1.472,-4.223 -2.23605,-12.33223 -2.76405,-16.77523 -1.07885,-7.842 -0.92461,-10.26711 -1.59044,-17.10315 l 0.85442,-9.35175 c 0.95924,-5.02655 2.098,-10.5958 4,-15.2698 5,-0.333 10,-0.667 15,-1 1.487,-5.584 3.153,-5.751 5,-0.5 5.333,0.667 10.667,1.333 16,2 2.098,5.491 4.16472,15.40192 4.23298,16.13839 0.0894,0.96395 -0.21786,-0.87987 -0.12889,1.96197 -0.39274,3.70101 -0.47371,7.62159 -0.33997,11.16362 0.473,2.825 2.04195,3.39395 4.23595,1.23595 22.86,-17.027 45.86,-33.86 69,-50.5 0.13817,-5.48908 0.10944,-5.96583 0.24754,-11.44084 0.36312,-1.60078 -0.0492,-5.70075 0.36995,-10.5138 0.0496,-6.21668 1.01095,-39.831357 1.38251,-57.04536 -0.267,-7.7223 -0.60137,-8.13132 0.33263,-15.74232 0.27088,-3.732176 0.2726,-1.741451 0.66658,-6.751324 C 578.654,50.1409 578.321,43.8076 577.5,37.5 c -0.155,-4.7237 1.678,-8.3904 5.5,-11 1.031,-10.3571 5.531,-18.85714 13.5,-25.5 2,-0.666667 4,-0.666667 6,0 7.922,6.67382 12.588,15.1738 14,25.5 3.388,2.8091 5.054,6.4758 5,11 -0.808,5.9739 -1.141,11.9739 -0.95829,18.500529 0.53008,2.75815 0.67137,5.070644 0.79145,8.822564 l 0.33368,16.348517 c 0.167,23.0024 -0.66737,20.63618 0.34303,63.81915 0.15538,7.18815 0.3019,8.05288 0.44858,14.09768 z'
  # rubocop:enable Layout/LineLength

  def counter_background(xml)
    xml.rect(
      x: '0',
      y: '0',
      width: counter_width,
      height: counter_height,
      fill: 'coral',
      "fill-opacity": '0.3',
      stroke: 'black',
      "stroke-width": '1'
    )
  end

  def b52_outline(xml)
    xml.path(d: PATH, fill: '#343330', id: 'path998',
             style: 'fill:#302f2e;fill-opacity:1;stroke:#00d300;stroke-opacity:1')
  end

  def b52_bounding_box(xml)
    xml.rect(
      x: '236',
      y: '0',
      width: '728',
      height: '628',
      fill: 'palegreen',
      "fill-opacity": '0.3',
      stroke: 'black',
      "stroke-width": '1'
    )
  end

  # No idea why -100 is the correct (or close enoug) offset.
  # It needs to be calculated based on the counter width.
  def offset_x
    -80
  end

  # This needs to be calculated based on the counter height
  def offset_y
    (1024 - 628) / 2
  end

  def top_left_value(xml)
    xml.text_('?',
              x: '200',
              y: '200',
              'text-anchor': 'middle',
              'text-align': 'center',
              'font-family': 'sans-serif',
              'font-size': font_size)
  end

  def top_right_value(xml)
    xml.text_('?',
              x: '800',
              y: '200',
              'text-anchor': 'middle',
              'text-align': 'center',
              'font-family': 'sans-serif',
              'font-size': font_size)
  end

  def build_counter(xml)
    counter_background(xml)
    xml.g(transform: "translate(#{offset_x},#{offset_y})") do
      b52_outline(xml)
      b52_bounding_box(xml)
    end
    top_left_value(xml)
    top_right_value(xml)
  end

  def to_svg
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.svg(xmlns: 'http://www.w3.org/2000/svg', width: counter_width, height: counter_height) do
        build_counter(xml)
      end
    end
    builder.to_xml
  end

  private

  def font_size
    108
  end

  def counter_width
    1024
  end

  def counter_height
    1024
  end
end

File.write('b52-counter.svg', B52Counter.new.to_svg)
