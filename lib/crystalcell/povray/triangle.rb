#! /usr/bin/env ruby # coding: utf-8

class Mageo::Triangle
  # povray 形式の文字列を返す。
  # color は Float による配列。通常、0〜1の範囲。
  def to_pov(color)
    v = self.vertices
    result = "polygon { 4, " + sprintf("<%7.4f, %7.4f, %7.4f>, ", v[0][0], v[0][1], v[0][2]) +
      sprintf("<%7.4f, %7.4f, %7.4f>, ", v[1][0], v[1][1], v[1][2]) +
      sprintf("<%7.4f, %7.4f, %7.4f>, ", v[2][0], v[2][1], v[2][2]) +
      sprintf("<%7.4f, %7.4f, %7.4f> " , v[0][0], v[0][1], v[0][2]) +
      "pigment { color rgb <1, 0, 0> } }"
    return result
  end

  def dump(io)
    io.print self.to_pov
  end
end

