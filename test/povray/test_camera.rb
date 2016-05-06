#! /usr/bin/env ruby
# coding: utf-8

require "pp"
require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Camera < Test::Unit::TestCase
  def setup
    @c00 = CrystalCell::Povray::Camera.new
  end

  def test_dump
    #TODO
  end

end

