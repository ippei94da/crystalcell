#! /usr/bin/env ruby
# coding: utf-8

require "pp"
require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Camera < Test::Unit::TestCase
  def setup
    @c00 = CrystalCell::Povray::Camera.new(
      orthographic: true,
      location:     [   3.0, 3.0, 3.0 ],
      look_at:      [   0.0, 0.0, 0.0 ],
      sky:          [   0.0, 0.0, 1.0 ],
      right:        [ -1.00, 0.0, 0.0 ],
      up:           [   0.0, 1.0, 0.0 ],
      angle:        68
    )
  end

  def test_initialize
    hash = {
      orthographic: true,
      location:     [   3.0, 3.0, 3.0 ],
      look_at:      [   0.0, 0.0, 0.0 ],
      sky:          [   0.0, 0.0, 1.0 ],
      right:        [ -1.00, 0.0, 0.0 ],
      up:           [   0.0, 1.0, 0.0 ],
      angle:        68
    }
    @c01 = CrystalCell::Povray::Camera.new(hash)
    assert_equal( true               , @c01.orthographic)
    assert_equal( [   3.0, 3.0, 3.0 ], @c01.location    )
    assert_equal( [   0.0, 0.0, 0.0 ], @c01.look_at     )
    assert_equal( [   0.0, 0.0, 1.0 ], @c01.sky         )
    assert_equal( [ -1.00, 0.0, 0.0 ], @c01.right       )
    assert_equal( [   0.0, 1.0, 0.0 ], @c01.up          )
    assert_equal( 68                 , @c01.angle       )
  end

  def test_accessor
    assert_equal( true               , @c00.orthographic)
    assert_equal( [   3.0, 3.0, 3.0 ], @c00.location    )
    assert_equal( [   0.0, 0.0, 0.0 ], @c00.look_at     )
    assert_equal( [   0.0, 0.0, 1.0 ], @c00.sky         )
    assert_equal( [ -1.00, 0.0, 0.0 ], @c00.right       )
    assert_equal( [   0.0, 1.0, 0.0 ], @c00.up          )
    assert_equal( 68                 , @c00.angle       )

    @c00.orthographic = false
    assert_equal( false              , @c00.orthographic)
  end

  def test_additional
    c10 = CrystalCell::Povray::Camera.new(
      orthographic: true,
      location:     [   3.0, 3.0, 3.0 ],
      look_at:      [   0.0, 0.0, 0.0 ],
      sky:          [   0.0, 0.0, 1.0 ],
      right:        [ -1.00, 0.0, 0.0 ],
      up:           [   0.0, 1.0, 0.0 ],
      angle:        68,
      additions:[ "background {color rgb<1,1,1>}",
                  "light_source{ < 4, 1, 4 > color <1,1,1> parallel point_at 0 }",
                  "default{ texture{ finish{ ambient 0.4 phong 1.0 phong_size 10 } } }",
                ]
    )
    correct = <<HERE
camera {
  orthographic
  location <3.000000, 3.000000, 3.000000 >
  look_at  <0.000000, 0.000000, 0.000000 >
  sky      <0.000000, 0.000000, 1.000000 >
  right    <-1.000000, 0.000000, 0.000000 >
  up       <0.000000, 1.000000, 0.000000 >
  angle    68.000000
}
background {color rgb<1,1,1>}
light_source{ < 4, 1, 4 > color <1,1,1> parallel point_at 0 }
default{ texture{ finish{ ambient 0.4 phong 1.0 phong_size 10 } } }
HERE
    io = StringIO.new
    c10.dump(io)
    io.rewind
    result = io.read
    assert_equal(correct, result)
  end

  def test_dump
    correct = <<HERE
camera {
  orthographic
  location <3.000000, 3.000000, 3.000000 >
  look_at  <0.000000, 0.000000, 0.000000 >
  sky      <0.000000, 0.000000, 1.000000 >
  right    <-1.000000, 0.000000, 0.000000 >
  up       <0.000000, 1.000000, 0.000000 >
  angle    68.000000
}
HERE
    io = StringIO.new
    @c00.dump(io)
    io.rewind
    result = io.read
    assert_equal(correct, result)
  end

end