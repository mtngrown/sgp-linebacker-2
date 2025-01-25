class UsHoldingArea
  BORDER_POINTS = [
    [13.5, 0],
    [16.0, 0],
    [16.0, 7.5],
    [13.5, 7.5]
  ].freeze

  def initialize
    @svg = Nokogiri::XML::Builder.new do |xml|
      xml.svg(xmlns: 'http://www.w3.org/2000/svg', width: '10cm', height: '10cm') do
        xml.rect(width: '100%', height: '100%', fill: 'lightblue')
      end
    end
  end
end
