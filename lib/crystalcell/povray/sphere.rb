#! /usr/bin/env ruby # coding: utf-8

class Mageo::Sphere
  # povray 形式の文字列を返す。
  # color は Float による配列。通常、0〜1の範囲。
  def to_pov(color: , transmit: nil)
    result = sprintf("object { sphere{<% 7.4f, % 7.4f, % 7.4f>, %7.4f} ", *position, radius)
    #sprintf( "object { sphere{<% 7.4f, % 7.4f, % 7.4f>, %7.4f} pigment {color rgb <%4.2f, %4.2f, %4.2f>} }",
    #  *position, radius, *color)

    if transmit
      result += sprintf("pigment {color rgbt <%4.2f, %4.2f, %4.2f, %4.2f>} }", *color, transmit)
    else
      result += sprintf("pigment {color rgb <%4.2f, %4.2f, %4.2f>} }", *color)
    end
  end

  def dump(io)
    io.puts self.to_pov
  end
end


