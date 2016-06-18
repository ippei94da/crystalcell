#! /usr/bin/env ruby # coding: utf-8

class Mageo::Sphere
  # povray 形式の文字列を返す。
  # color は Float による配列。通常、0〜1の範囲。
  def to_pov(color)
    sprintf( "object { sphere{<% 7.4f, % 7.4f, % 7.4f>, %7.4f} pigment {color rgb <%4.2f, %4.2f, %4.2f>} }",
      *position, radius, *color)
  end

  def dump(io)
    io.print self.to_pov
  end
end


