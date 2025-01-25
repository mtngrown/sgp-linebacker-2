#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rspec/autorun'

class ParseBezier
  attr_reader :path, :commands

  def initialize(path)
    @path = path
  end

  def commands
    @commands ||= path.scan(/([a-zA-Z])|([-+]?\d*\.?\d+)/).map { |c| c[0] || c[1] }
  end

  def parse
    @path.scan(/([a-zA-Z])|([-+]?\d*\.?\d+)/).map { |c| c[0] || c[1] }
  end
end

RSpec.describe ParseBezier do
  describe 'commands' do
    it 'parses the path' do
      parse_bezier = ParseBezier.new('M100,100 C100,0 90,0 90,100')
      expect(parse_bezier.commands).to eq(%w[M 100 100 C 100 0 90 0 90 100])
    end

    it 'parses the path with a relative move' do
      parse_bezier = ParseBezier.new('m100,100 c100,-100 -100,-100 -100,0')
      expect(parse_bezier.commands).to eq(%w[m 100 100 c 100 -100 -100 -100 -100 0])
    end

    it 'parses the path with a close path' do
      parse_bezier = ParseBezier.new('m100,100 c100,-100 -100,-100 -100,0 z')
      expect(parse_bezier.commands).to eq(%w[m 100 100 c 100 -100 -100 -100 -100 0 z])
    end

    it 'parses the path with a cubic bezier' do
      parse_bezier = ParseBezier.new('m100,100 c100,-100 -100,-100 -100,0 c100,-100 -100,-100 -100,0')
      expect(parse_bezier.commands).to eq(%w[m 100 100 c 100 -100 -100 -100 -100 0 c 100 -100 -100 -100 -100 0])
    end
  end
end
