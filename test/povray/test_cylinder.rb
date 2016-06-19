#! /usr/bin/env ruby
# coding: utf-8

require "pp"
require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Cylinder < Test::Unit::TestCase
  def setup
    @c00 = CrystalCell::Povray::Cylinder.new([1.0, 2.0, 3.0], [4.0, 6.0, 8.0], 0.5 , [0.25, 0.5, 0.75])
  end

  def test_initialize
    assert_equal(Mageo::Vector3D[1.0, 2.0, 3.0], @c00.positions[0])
    assert_equal(Mageo::Vector3D[4.0, 6.0, 8.0], @c00.positions[1])
    assert_equal([0.25, 0.5, 0.75], @c00.color)
  end

  def test_to_pov
    assert_equal(
      "object { cylinder{ < 1.0000,  2.0000,  3.0000>, < 4.0000,  6.0000,  8.0000>,  0.5000 } pigment { color rgb <0.25, 0.50, 0.75> } }",
      @c00.to_pov
    )
  end

end


