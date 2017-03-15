#! /usr/bin/env ruby
# coding: utf-8

require "pp"
require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Tetrahedron < Test::Unit::TestCase
  def setup
    @t00 = CrystalCell::Povray::Tetrahedron.new(
      [0.0, 0.0, 0.0],
      [1.0, 1.0, 0.0],
      [0.0, 1.0, 1.0],
      [1.0, 0.0, 1.0],
      [0.25, 0.5, 0.75])
  end

  def test_to_pov
    #VERTEX_INDICES_OF_TRIANGLES = [ [ 0, 1, 2 ], [ 1, 2, 3 ], [ 2, 3, 0 ], [ 3, 0, 1 ] ]
    correct = [
      "triangle{ <  0.0000,  0.0000,  0.0000>,< 1.0000, 1.0000, 0.0000>,< 0.0000, 1.0000, 1.0000> pigment {color rgb< 0.2500, 0.5000, 0.7500>}}",
      "triangle{ <  1.0000,  1.0000,  0.0000>,< 0.0000, 1.0000, 1.0000>,< 1.0000, 0.0000, 1.0000> pigment {color rgb< 0.2500, 0.5000, 0.7500>}}",
      "triangle{ <  0.0000,  1.0000,  1.0000>,< 1.0000, 0.0000, 1.0000>,< 0.0000, 0.0000, 0.0000> pigment {color rgb< 0.2500, 0.5000, 0.7500>}}",
      "triangle{ <  1.0000,  0.0000,  1.0000>,< 0.0000, 0.0000, 0.0000>,< 1.0000, 1.0000, 0.0000> pigment {color rgb< 0.2500, 0.5000, 0.7500>}}",
    ].join("\n")
    assert_equal(
      correct,
      @t00.to_pov
    )

    @t00.transmit = 0.5
    correct = [
      "triangle{ <  0.0000,  0.0000,  0.0000>,< 1.0000, 1.0000, 0.0000>,< 0.0000, 1.0000, 1.0000> pigment {color rgb< 0.2500, 0.5000, 0.7500> transmit  0.5000}}",
      "triangle{ <  1.0000,  1.0000,  0.0000>,< 0.0000, 1.0000, 1.0000>,< 1.0000, 0.0000, 1.0000> pigment {color rgb< 0.2500, 0.5000, 0.7500> transmit  0.5000}}",
      "triangle{ <  0.0000,  1.0000,  1.0000>,< 1.0000, 0.0000, 1.0000>,< 0.0000, 0.0000, 0.0000> pigment {color rgb< 0.2500, 0.5000, 0.7500> transmit  0.5000}}",
      "triangle{ <  1.0000,  0.0000,  1.0000>,< 0.0000, 0.0000, 0.0000>,< 1.0000, 1.0000, 0.0000> pigment {color rgb< 0.2500, 0.5000, 0.7500> transmit  0.5000}}",
    ].join("\n")
    assert_equal(
      correct,
      @t00.to_pov
    )
  end

end


