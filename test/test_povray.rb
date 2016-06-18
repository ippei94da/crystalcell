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

  def test_foo
  end
  
  #def test_dump
  #  io = StringIO.new
  #  #@p00.dump(STDOUT)
  #  @p00.dump(io)
  #  io.rewind
  #  pp io.readlines
  #end

end

