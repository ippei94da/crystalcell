#! /usr/bin/env ruby # coding: utf-8

require "mageo/triangle.rb"
require "mageo/sphere.rb"
require "mageo/cylinder.rb"
#gem "crysna"
#require "crysna.rb"
#require "crysna/periodiccell.rb"
require "povrayutils/elementfeature.rb"

class Mageo::Sphere
  # povray 形式の文字列を返す。
  # color は Float による配列。通常、0〜1の範囲。
  def to_pov(color)
    sprintf( "object { sphere{<% 7.4f, % 7.4f, % 7.4f>, %7.4f} pigment {color rgb <%4.2f, %4.2f, %4.2f>} }",
      *position, radius, *color)
  end
end


