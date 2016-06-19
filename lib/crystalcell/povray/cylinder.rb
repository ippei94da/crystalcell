#! /usr/bin/env ruby # coding: utf-8

class CrystalCell::Povray::Cylinder < Mageo::Cylinder
  attr_reader :positions, :color

  def initialize(position0, position1, radius, color)
    super(position0, position1, radius)
    @color = color
  end

  # povray 形式の文字列を返す。
  # color は Float による配列。通常、0〜1の範囲。
  def to_pov
    sprintf( "object { cylinder{ <% 7.4f, % 7.4f, % 7.4f>, <% 7.4f, % 7.4f, % 7.4f>, %7.4f } pigment { color rgb <%4.2f, %4.2f, %4.2f> } }",
    *positions[0], *positions[1], radius, *color)
    #*@positions[0], *@positions[1], radius, @color)
  end

  def dump(io)
    io.puts self.to_pov
  end
end
