#! /usr/bin/env ruby
# coding: utf-8

require "pp"
require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Triangle < Test::Unit::TestCase
  $tolerance = 10.0 ** (-10)

  #VEC_O = Mageo::Vector3D[0.0, 0.0, 0.0]
  #VEC_X = Mageo::Vector3D[1.0, 0.0, 0.0]
  #VEC_Y = Mageo::Vector3D[0.0, 1.0, 0.0]
  #VEC_Z = Mageo::Vector3D[0.0, 0.0, 1.0]

  def setup
    @t00 = CrystalCell::Povray::Triangle.new(
      [0.0, 0.0, 0.0],
      [1.0, 0.0, 0.0],
      [0.0, 1.0, 0.0],
      [0.25, 0.5, 0.75]
    )
  end

  def test_to_pov
    assert_equal(
      "triangle{<0.000000,0.000000,0.000000>,<1.000000,0.000000,0.000000>,<0.000000,1.000000,0.000000> pigment {color rgb<0.250000,0.500000,0.750000>}}",
      @t00.to_pov
    )

    @t00.transmit = 0.5
    assert_equal(
      "triangle{<0.000000,0.000000,0.000000>,<1.000000,0.000000,0.000000>,<0.000000,1.000000,0.000000> pigment {color rgb<0.250000,0.500000,0.750000> transmit 0.500000}}",
      @t00.to_pov
    )
  end

end


