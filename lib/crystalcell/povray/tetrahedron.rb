#! /usr/bin/env ruby # coding: utf-8

class CrystalCell::Povray::Tetrahedron < Mageo::Tetrahedron
  
  def initialize(v0, v1, v2, v3, color)
    super(v0, v1, v2, v3)
    @color =  color
  end

  # povray 形式の文字列を返す。
  # color は Float による配列。通常、0〜1の範囲。
  def to_pov
    triangles.map { |triangle| triangle.to_pov }.join("\n")
  end

  def dump(io)
    io.puts self.to_pov
  end

  def triangles
    results = VERTEX_INDICES_OF_TRIANGLES.map do |indices|
    CrystalCell::Povray::Triangle.new( *(indices.map{|i| @vertices[i] }), @color )
    end
    return results
  end

  private

end

