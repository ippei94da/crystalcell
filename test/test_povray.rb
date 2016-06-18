#! /usr/bin/env ruby
# coding: utf-8

require "pp"
require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Povray < Test::Unit::TestCase
  def setup
    atoms = [
      CrystalCell::Atom.new( 'Li', [0.0, 0.0, 0.0] ),
      CrystalCell::Atom.new( 'O' , [0.2, 0.2, 0.2] ),
    ]
    @c02 = CrystalCell::Cell.new(
      [[2.0, 2.0, 2.0], [0.0, 2.0, 2.0], [0.0, 0.0, 2.0]],  
      atoms)
    @c02.comment = 'c02'


    @p00 = CrystalCell::Povray.new()
  end

  def test_dump_pov
    io = StringIO.new
    @p00.dump_pov(STDOUT)
    #@p00.dump_pov(io)
  end

end

