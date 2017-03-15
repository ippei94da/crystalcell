#! /usr/bin/env ruby # coding: utf-8

class CrystalCell::Povray::Triangle < Mageo::Triangle

  attr_accessor :color, :transmit
  
  def initialize(vec0, vec1, vec2, color, transmit = nil)
    super(vec0, vec1, vec2)
    @color = color
    @transmit = transmit
  end

  # povray 形式の文字列を返す。
  # color は Float による配列。通常、0〜1の範囲。
  def to_pov
    #v = self.vertices
    #sprintf( "object { cylinder{ <% 7.4f, % 7.4f, % 7.4f>, <% 7.4f, % 7.4f, % 7.4f>, %7.4f } pigment { color rgb <%4.2f, %4.2f, %4.2f> } }",
    result = sprintf("triangle{ < % 7.4f, % 7.4f, % 7.4f>,<% 7.4f,% 7.4f,% 7.4f>,<% 7.4f,% 7.4f,% 7.4f>",
      *@vertices[0], *@vertices[1], *@vertices[2])
    result +=  sprintf(" pigment {color rgb<% 7.4f,% 7.4f,% 7.4f>", *@color)
    result +=  sprintf(" transmit % 7.4f", @transmit) if @transmit
    result +=  "}}"
    return result
  end

  def dump(io)
    io.puts self.to_pov
  end
end

