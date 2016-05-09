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

  #def initialize(hash = {})
  #  
  #end

  def dump(io)
    #camera { orthographic
    #  // orthographic       // これを入れる場合は location の前に。
    #  location <  3.0, 3.0, 3.0 > // camera location
    #  look_at  <  0.0, 0.0, 0.0 > // 注視点
    #  sky      <  0.0, 0.0, 1.0 >
    #  right    <-1.00, 0.0, 0.0 >
    #  up       <  0.0, 1.0, 0.0 >
    #  angle    68                 // カメラの水平方向の画角。左右合計の角度。
    #}
  end

end

    #background {color rgb<1,1,1>}
    #light_source{ < 4, 1, 4 > color <1,1,1> parallel point_at 0 }
    ##default{ texture{ finish{ ambient 0.4 phong 1.0 phong_size 10 } } }
    #@background = [1.0, 1.0, 1.0]
    #@light_source{ < 4, 1, 4 > color <1,1,1> parallel point_at 0 }
    ##default{ texture{ finish{ ambient 0.4 phong 1.0 phong_size 10 } } }

