#! /usr/bin/env ruby # coding: utf-8

class CrystalCell::Povray::Triangle < Mageo::Triangle
  
  def initialize(vec0, vec1, vec2, color)
    super(vec0, vec1, vec2)
    @color = color
  end

  # povray 形式の文字列を返す。
  # color は Float による配列。通常、0〜1の範囲。
  def to_pov
    v = self.vertices
    result = sprintf("triangle{<%f,%f,%f>,<%f,%f,%f>,<%f,%f,%f> " +
      "pigment {color rgb<%f,%f,%f>}}",
      *@vertices[0], *@vertices[1], *@vertices[2], *@color)
    #result = "polygon { 4, " + sprintf("<%7.4f, %7.4f, %7.4f>, ", v[0][0], v[0][1], v[0][2]) +
    #  sprintf("<%7.4f, %7.4f, %7.4f>, ", v[1][0], v[1][1], v[1][2]) +
    #  sprintf("<%7.4f, %7.4f, %7.4f>, ", v[2][0], v[2][1], v[2][2]) +
    #  sprintf("<%7.4f, %7.4f, %7.4f> " , v[0][0], v[0][1], v[0][2]) +
    #  sprintf("pigment { color rgb <%7.4f, %7.4f0, %7.4f0> } }", *@color)
    return result
  end

  def dump(io)
    io.puts self.to_pov
  end
end

