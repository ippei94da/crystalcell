#! /usr/bin/env ruby
# coding: utf-8

require "pp"
require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Camera < Test::Unit::TestCase
  def setup
    @c00 = CrystalCell::Povray::Camera.new(
      camera_type: 'orthographic',
      location:     [   3.0, 3.0, 3.0 ],
      sky:          [   0.0, 0.0, 1.0 ],
      right:        [ -1.00, 0.0, 0.0 ],
      up:           [   0.0, 1.0, 0.0 ],
      angle:        68,
      look_at:      [   0.0, 0.0, 0.0 ],
    )
  end

  def test_initialize
    hash = {
      #camera_type: 'orthographic',
      location:     [   3.0, 3.0, 3.0 ],
      sky:          [   0.0, 0.0, 1.0 ],
      right:        [ -1.00, 0.0, 0.0 ],
      up:           [   0.0, 1.0, 0.0 ],
      angle:        68,
      look_at:      [   0.0, 0.0, 0.0 ],
    }
    c01 = CrystalCell::Povray::Camera.new(hash)
    assert_equal( nil     , c01.camera_type)
    assert_equal( [   3.0, 3.0, 3.0 ], c01.location    )
    assert_equal( [   0.0, 0.0, 0.0 ], c01.look_at     )
    assert_equal( [   0.0, 0.0, 1.0 ], c01.sky         )
    assert_equal( [ -1.00, 0.0, 0.0 ], c01.right       )
    assert_equal( [   0.0, 1.0, 0.0 ], c01.up          )
    assert_equal( 68                 , c01.angle       )

    hash = {
      camera_type: 'orthographic',
      #location:     [   3.0, 3.0, 3.0 ],
      sky:          [   0.0, 0.0, 1.0 ],
      right:        [ -1.00, 0.0, 0.0 ],
      up:           [   0.0, 1.0, 0.0 ],
      angle:        68,
      look_at:      [   0.0, 0.0, 0.0 ],
    }
    c01 = CrystalCell::Povray::Camera.new(hash)
    assert_equal( 'orthographic'     , c01.camera_type)
    assert_equal( nil, c01.location    )
    assert_equal( [   0.0, 0.0, 0.0 ], c01.look_at     )
    assert_equal( [   0.0, 0.0, 1.0 ], c01.sky         )
    assert_equal( [ -1.00, 0.0, 0.0 ], c01.right       )
    assert_equal( [   0.0, 1.0, 0.0 ], c01.up          )
    assert_equal( 68                 , c01.angle       )

    hash = {
      camera_type: 'orthographic',
      location:     [   3.0, 3.0, 3.0 ],
      #sky:          [   0.0, 0.0, 1.0 ],
      right:        [ -1.00, 0.0, 0.0 ],
      up:           [   0.0, 1.0, 0.0 ],
      angle:        68,
      look_at:      [   0.0, 0.0, 0.0 ],
    }
    c01 = CrystalCell::Povray::Camera.new(hash)
    assert_equal( 'orthographic'     , c01.camera_type)
    assert_equal( [   3.0, 3.0, 3.0 ], c01.location    )
    assert_equal( [   0.0, 0.0, 0.0 ], c01.look_at     )
    assert_equal( nil                , c01.sky         )
    assert_equal( [ -1.00, 0.0, 0.0 ], c01.right       )
    assert_equal( [   0.0, 1.0, 0.0 ], c01.up          )
    assert_equal( 68                 , c01.angle       )

    hash = {
      camera_type: 'orthographic',
      location:     [   3.0, 3.0, 3.0 ],
      sky:          [   0.0, 0.0, 1.0 ],
      #right:        [ -1.00, 0.0, 0.0 ],
      up:           [   0.0, 1.0, 0.0 ],
      angle:        68,
      look_at:      [   0.0, 0.0, 0.0 ],
    }
    c01 = CrystalCell::Povray::Camera.new(hash)
    assert_equal( 'orthographic'     , c01.camera_type)
    assert_equal( [   3.0, 3.0, 3.0 ], c01.location    )
    assert_equal( [   0.0, 0.0, 0.0 ], c01.look_at     )
    assert_equal( [   0.0, 0.0, 1.0 ], c01.sky         )
    assert_equal( nil                , c01.right       )
    assert_equal( [   0.0, 1.0, 0.0 ], c01.up          )
    assert_equal( 68                 , c01.angle       )

    hash = {
      camera_type: 'orthographic',
      location:     [   3.0, 3.0, 3.0 ],
      sky:          [   0.0, 0.0, 1.0 ],
      right:        [ -1.00, 0.0, 0.0 ],
      #up:           [   0.0, 1.0, 0.0 ],
      angle:        68,
      look_at:      [   0.0, 0.0, 0.0 ],
    }
    c01 = CrystalCell::Povray::Camera.new(hash)
    assert_equal( 'orthographic'     , c01.camera_type)
    assert_equal( [   3.0, 3.0, 3.0 ], c01.location    )
    assert_equal( [   0.0, 0.0, 0.0 ], c01.look_at     )
    assert_equal( [   0.0, 0.0, 1.0 ], c01.sky         )
    assert_equal( [ -1.00, 0.0, 0.0 ], c01.right       )
    assert_equal( nil                , c01.up          )
    assert_equal( 68                 , c01.angle       )

    hash = {
      camera_type: 'orthographic',
      location:     [   3.0, 3.0, 3.0 ],
      sky:          [   0.0, 0.0, 1.0 ],
      right:        [ -1.00, 0.0, 0.0 ],
      up:           [   0.0, 1.0, 0.0 ],
      #angle:        68,
      look_at:      [   0.0, 0.0, 0.0 ],
    }
    c01 = CrystalCell::Povray::Camera.new(hash)
    assert_equal( 'orthographic'     , c01.camera_type)
    assert_equal( [   3.0, 3.0, 3.0 ], c01.location    )
    assert_equal( [   0.0, 0.0, 0.0 ], c01.look_at     )
    assert_equal( [   0.0, 0.0, 1.0 ], c01.sky         )
    assert_equal( [ -1.00, 0.0, 0.0 ], c01.right       )
    assert_equal( [   0.0, 1.0, 0.0 ], c01.up          )
    assert_equal( nil                , c01.angle       )

    hash = {
      camera_type: 'orthographic',
      location:     [   3.0, 3.0, 3.0 ],
      sky:          [   0.0, 0.0, 1.0 ],
      right:        [ -1.00, 0.0, 0.0 ],
      up:           [   0.0, 1.0, 0.0 ],
      angle:        68,
      #look_at:      [   0.0, 0.0, 0.0 ],
    }
    c01 = CrystalCell::Povray::Camera.new(hash)
    assert_equal( 'orthographic'     , c01.camera_type)
    assert_equal( [   3.0, 3.0, 3.0 ], c01.location    )
    assert_equal( [   0.0, 0.0, 1.0 ], c01.sky         )
    assert_equal( [ -1.00, 0.0, 0.0 ], c01.right       )
    assert_equal( [   0.0, 1.0, 0.0 ], c01.up          )
    assert_equal( 68                 , c01.angle       )
    assert_equal( nil                , c01.look_at     )

    assert_nothing_raised(){ CrystalCell::Povray::Camera.new({})}
    assert_nothing_raised(){ CrystalCell::Povray::Camera.new}
  end

  def test_accessor
    assert_equal( 'orthographic'     , @c00.camera_type)
    assert_equal( [   3.0, 3.0, 3.0 ], @c00.location    )
    assert_equal( [   0.0, 0.0, 0.0 ], @c00.look_at     )
    assert_equal( [   0.0, 0.0, 1.0 ], @c00.sky         )
    assert_equal( [ -1.00, 0.0, 0.0 ], @c00.right       )
    assert_equal( [   0.0, 1.0, 0.0 ], @c00.up          )
    assert_equal( 68                 , @c00.angle       )

    @c00.camera_type = 'orthographic'
    assert_equal( 'orthographic'              , @c00.camera_type)
  end

  def test_dump
    ############################################################
    c10 = CrystalCell::Povray::Camera.new(
      camera_type: 'orthographic',
      location:     [   3.0, 3.0, 3.0 ],
      right:        [ -1.00, 0.0, 0.0 ],
      up:           [   0.0, 1.0, 0.0 ],
      sky:          [   0.0, 0.0, 1.0 ],
      angle:        68,
      look_at:      [   0.0, 0.0, 0.0 ],
    )
    correct = <<HERE
camera {
  orthographic
  location  <3.000000, 3.000000, 3.000000 >
  right     <-1.000000, 0.000000, 0.000000 >
  up        <0.000000, 1.000000, 0.000000 >
  sky       <0.000000, 0.000000, 1.000000 >
  angle     68.000000
  look_at   <0.000000, 0.000000, 0.000000 >
}
HERE
    io = StringIO.new
    c10.dump(io)
    io.rewind
    result = io.read
    assert_equal(correct, result)

    ## no angle ##########################################################
    c10 = CrystalCell::Povray::Camera.new(
      camera_type: 'orthographic',
      location:     [   3.0, 3.0, 3.0 ],
      sky:          [   0.0, 0.0, 1.0 ],
      right:        [ -1.00, 0.0, 0.0 ],
      up:           [   0.0, 1.0, 0.0 ],
      look_at:      [   0.0, 0.0, 0.0 ],
    )
    correct = <<HERE
camera {
  orthographic
  location  <3.000000, 3.000000, 3.000000 >
  right     <-1.000000, 0.000000, 0.000000 >
  up        <0.000000, 1.000000, 0.000000 >
  sky       <0.000000, 0.000000, 1.000000 >
  look_at   <0.000000, 0.000000, 0.000000 >
}
HERE
    io = StringIO.new
    c10.dump(io)
    io.rewind
    result = io.read
    assert_equal(correct, result)

    ## no ortho ##########################################################
    c10 = CrystalCell::Povray::Camera.new(
      location:     [   3.0, 3.0, 3.0 ],
      sky:          [   0.0, 0.0, 1.0 ],
      right:        [ -1.00, 0.0, 0.0 ],
      up:           [   0.0, 1.0, 0.0 ],
      look_at:      [   0.0, 0.0, 0.0 ],
    )
    correct = <<HERE
camera {
  location  <3.000000, 3.000000, 3.000000 >
  right     <-1.000000, 0.000000, 0.000000 >
  up        <0.000000, 1.000000, 0.000000 >
  sky       <0.000000, 0.000000, 1.000000 >
  look_at   <0.000000, 0.000000, 0.000000 >
}
HERE
    io = StringIO.new
    c10.dump(io)
    io.rewind
    result = io.read
    assert_equal(correct, result)
    ############################################################
  end

end

