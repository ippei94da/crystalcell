#! /usr/bin/env ruby
# coding: utf-8

#
#
#
class CrystalCell::Povray::Camera
  #
    #camera { orthographic
    #  // orthographic       // これを入れる場合は location の前に。
    #  location <  3.0, 3.0, 3.0 > // camera location
    #  look_at  <  0.0, 0.0, 0.0 > // 注視点
    #  sky      <  0.0, 0.0, 1.0 >
    #  right    <-1.00, 0.0, 0.0 >
    #  up       <  0.0, 1.0, 0.0 >
    #  angle    68                 // カメラの水平方向の画角。左右合計の角度。
    #}
    #@orthographic = true
    #@location = [   3.0, 3.0, 3.0 ]
    #@look_at  = [   0.0, 0.0, 0.0 ]
    #@sky      = [   0.0, 0.0, 1.0 ]
    #@right    = [ -1.00, 0.0, 0.0 ]
    #@up       = [   0.0, 1.0, 0.0 ]
    #@angle    = 68

  attr_accessor :orthographic, :location, :look_at, :sky, :right, :up, :angle

  def initialize(orthographic:, location:, look_at:, sky:, right:, up:, angle:,
                 additions: [])
    @orthographic = orthographic
    @location     = location    
    @look_at      = look_at     
    @sky          = sky         
    @right        = right       
    @up           = up          
    @angle        = angle       
    @additions    = additions       
  end

  def dump(io)
    io.puts "camera {"
    io.puts "  orthographic" if @orthographic
    io.printf("  location <%f, %f, %f >\n", *@location)
    io.printf("  look_at  <%f, %f, %f >\n", *@look_at)
    io.printf("  sky      <%f, %f, %f >\n", *@sky)
    io.printf("  right    <%f, %f, %f >\n", *@right)
    io.printf("  up       <%f, %f, %f >\n", *@up)
    io.printf("  angle    %f\n"           , @angle)
    io.puts "}"
    @additions.each do |i|
      io.puts i
    end
  end

end


