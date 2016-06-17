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
    #@right    =
    #@up       = [   0.0, 1.0, 0.0 ]
    #@angle    = 68

  attr_accessor :camera_type, :location, :look_at, :sky, :right, :up, :angle

  # camera_type: perspectice, orthographic, etc.
  # Note: default values of some setting is modified from original povray
  #   because of left-handed coordinate system.
  #   This library provide only on right-handed system in crystallography.
  #
  #   ---------------------------------------------
  #   setting       default_orig default_this
  #   perspective
  #   location      <0,0,0>       the same
  #   direction     <0,0,1>       the same
  #   right         <1.33,0,0>    [-1.33, 0.0, 0.0],
  #   sky           <0,1,0>       [  0.0, 0.0, 1.0],
  #   up            <0,1,0>       the same
  #   look_at       <0,0,1>       
  def initialize(camera_type:      nil, # perspective
                 location:         nil, # <0,0,0>
                 right:            [-1.33, 0.0, 0.0],
                 up:               [  0.0, 1.0, 0.0],
                 direction:        nil,
                 sky:              [  0.0, 0.0, 1.0],
                 angle:            nil,
                 camera_modifiers: [],
                 look_at:          [  0.0, 0.0, 0.0]
                 )
    @camera_type  = camera_type
    @location     = location    
    @right        = right       
    @up           = up          
    @direction    = direction   
    @sky          = sky         
    @angle        = angle       
    @camera_modifiers    = camera_modifiers       
    @look_at      = look_at     
  end

  def dump(io)
    io.puts "camera {"
    io.printf("  %s\n", @camera_type) if @camera_type
    io.printf("  location  <%f, %f, %f >\n", *@location)  if @location
    io.printf("  right     <%f, %f, %f >\n", *@right)     if @right
    io.printf("  up        <%f, %f, %f >\n", *@up)        if @up
    io.printf("  direction <%f, %f, %f >\n", *@direction) if @direction
    io.printf("  sky       <%f, %f, %f >\n", *@sky)
    io.printf("  angle     %f\n"           , @angle)      if @angle
    @camera_modifiers.each do |i|
      io.puts i
    end
    io.printf("  look_at   <%f, %f, %f >\n", *@look_at) if @look_at
    io.puts "}"
  end

end

