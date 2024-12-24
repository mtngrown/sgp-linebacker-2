#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require_relative 'counter'
class Mig21Counter < Counter
  def initialize(background_color)
    super(background_color)
  end
end
