#! /usr/bin/env ruby
# coding: utf-8

require "pp"
require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Povray < Test::Unit::TestCase
  def setup
    @p00 = CrystalCell::Povray.new()
  end

end

