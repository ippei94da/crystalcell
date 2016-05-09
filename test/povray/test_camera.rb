#! /usr/bin/env ruby
# coding: utf-8

require "pp"
require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Camera < Test::Unit::TestCase
  def setup
    @c00 = CrystalCell::Povray::Camera.new
    @c00.orthographic = true
    @c00.location = [   3.0, 3.0, 3.0 ]
    @c00.look_at  = [   0.0, 0.0, 0.0 ]
    @c00.sky      = [   0.0, 0.0, 1.0 ]
    @c00.right    = [ -1.00, 0.0, 0.0 ]
    @c00.up       = [   0.0, 1.0, 0.0 ]
    @c00.angle    = 68
  end

  def test_dump
    correct = <<HERE
camera { orthographic
  // orthographic
  location <  3.0, 3.0, 3.0 >
  look_at  <  0.0, 0.0, 0.0 >
  sky      <  0.0, 0.0, 1.0 >
  right    <-1.00, 0.0, 0.0 >
  up       <  0.0, 1.0, 0.0 >
  angle    68
}
HERE
    assert_equal(correct, @c00.dump)
  end

end

    #background {color rgb<1,1,1>}
    #light_source{ < 4, 1, 4 > color <1,1,1> parallel point_at 0 }
    ##default{ texture{ finish{ ambient 0.4 phong 1.0 phong_size 10 } } }
