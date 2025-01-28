# frozen_string_literal: true

# Marker element for line endings
# https://developer.mozilla.org/en-US/docs/Web/SVG/Element/marker
# https://blog.shalvah.me/posts/learn-svg-by-drawing-an-arrow
class Arrowhead
  attr_reader :xml

  def initialize(xml)
    @xml = xml
  end

  def marker
    {
      id: 'arrowhead',
      viewBox: '0 0 80 80',
      refX: '35',
      refY: '25',
      style: 'stroke-width: 2px; stroke: black; fill: black',
      markerWidth: '7',
      markerHeight: '11',
      markerUnits: 'userSpaceOnUse',
      orient: 'auto-start-reverse'
    }
  end

  def outline
    'M 5,25 L 0,40 L 40,25 L 0,10 Z'
  end

  def build
    xml.marker(marker) do
      xml.path(d: outline)
    end
  end

  def self.write(options = {})
    filename = options[:outfile] || '/tmp/arrowhead.svg'

    File.write(filename,
      Nokogiri::XML::Builder.new do |xml|
        xml.svg do
          Arrowhead.new(xml).build
        end
      end.to_xml)
  end
end
