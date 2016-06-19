#! /usr/bin/env ruby
# coding: utf-8

require "pp"
require "helper"
#require "test/unit"
#require "pkg/klass.rb"
#
class CrystalCell::Povray
  attr_reader :camera
end

class TC_Povray < Test::Unit::TestCase
  TOLERANCE = 1.0E-10

  def setup
    atoms = [
      CrystalCell::Atom.new( 'Li', [0.0, 0.0, 0.0] ),
      CrystalCell::Atom.new( 'O' , [0.2, 0.2, 0.2] ),
    ]
    cell = CrystalCell::Cell.new(
      [[2.0, 2.0, 2.0], [0.0, 2.0, 2.0], [0.0, 0.0, 2.0]],  
      atoms)
    cell.comment = 'c02'

    @p00 = CrystalCell::Povray.new(cell: cell)
  end

  def test_initialize
    ## look_at
    assert_in_delta( 1.0, @p00.camera.look_at[0], TOLERANCE)
    assert_in_delta( 2.0, @p00.camera.look_at[1], TOLERANCE)
    assert_in_delta( 3.0, @p00.camera.look_at[2], TOLERANCE)
  end

  def test_camera_location
    ## look_at
    @p00.camera_location([ 1.2, 2.3, 3.4])
    assert_in_delta(2.2 , @p00.camera.location[0], TOLERANCE)
    assert_in_delta(4.3 , @p00.camera.location[1], TOLERANCE)
    assert_in_delta(6.4 , @p00.camera.location[2], TOLERANCE)

    setup
    @p00.camera.look_at = [0.1, 2.3, 3.4]
    @p00.camera_location([ 1.2, 2.3, 3.4])
    assert_in_delta(1.3 , @p00.camera.location[0], TOLERANCE)
    assert_in_delta(4.6 , @p00.camera.location[1], TOLERANCE)
    assert_in_delta(6.8 , @p00.camera.location[2], TOLERANCE)
  end

  def test_camera_location_polar
    ## look_at
    @p00.camera_location_polar( 6.0, 0.0, 0.0)
    assert_in_delta(1.0 , @p00.camera.location[0], TOLERANCE)
    assert_in_delta(2.0 , @p00.camera.location[1], TOLERANCE)
    assert_in_delta(9.0 , @p00.camera.location[2], TOLERANCE)

    @p00.camera_location_polar( 6.0, 90.0, 0.0)
    assert_in_delta(7.0 , @p00.camera.location[0], TOLERANCE)
    assert_in_delta(2.0 , @p00.camera.location[1], TOLERANCE)
    assert_in_delta(3.0 , @p00.camera.location[2], TOLERANCE)

    @p00.camera_location_polar( 6.0, 90.0, 90.0)
    assert_in_delta(1.0 , @p00.camera.location[0], TOLERANCE)
    assert_in_delta(8.0 , @p00.camera.location[1], TOLERANCE)
    assert_in_delta(3.0 , @p00.camera.location[2], TOLERANCE)

    #setup
    #@p00.camera.look_at = [0.1, 2.3, 3.4]
    #@p00.camera_location_polar()
  end

  def test_shoot_snap
    #basename = 'test/povray/tmp'
    #povfile = basename + '.pov'
    #pngfile = basename + '.png'

    #FileUtils.rm povfile if File.exist? povfile
    #FileUtils.rm pngfile if File.exist? pngfile

    #@p00.shoot_snap(basename)

    ##FileUtils.rm povfile if File.exist? povfile
    ##FileUtils.rm pngfile if File.exist? pngfile
  end

  def test_shoot_4in1
    #basename = 'test/povray/tmp'
    #@p00.shoot_4in1(basename)
  end

  def test_dump
    #io = StringIO.new
    #@p00.dump(io)
    #io.rewind
    #puts io.read
  end

end

