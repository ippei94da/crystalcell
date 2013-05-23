#! /usr/bin/env ruby
# coding: utf-8

#Module for CIF file
#
#
class Crystalcell::Cif

  #Generatte Cif object from input of 'io'.
  def initialize(io)
    parse(path)
  end

  #Generatte Cif object from file of 'path'.
  def self.load_file(path)
    self.class.new(File.open(path, "r"))
  end

  private

  def parse(io)
    io.read
  end

end

