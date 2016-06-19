class CrystalCell::Povray; end

require 'crystalcell/povray/camera.rb'
require 'crystalcell/povray/cell.rb'
require 'crystalcell/povray/cylinder.rb'
require 'crystalcell/povray/element.rb'
require 'crystalcell/povray/sphere.rb'
require 'crystalcell/povray/triangle.rb'

DEFAULT_ENVIRONMENTS = [
  'background {color rgb<1,1,1>}',
  'light_source{ < 4, 1, 4 > color <1,1,1> parallel point_at 0 }',
  'default{ texture{ finish{ ambient 0.4 phong 1.0 phong_size 10 } } }',
]

class CrystalCell::Povray
  attr_reader :camera, :environments, :cell, :axes
  
  # camera_info indicates hash with the keys of camera info,
  #   e.g., :camera_type, :location, :direction, :right, :sky, :up, :look_at
  def initialize(cell: , camera_info: {}, environments: DEFAULT_ENVIRONMENTS)
    @camera      = CrystalCell::Povray::Camera.new(camera_info)
    @environments = environments
    @cell = cell.to_povcell
    @axes = nil
    @objects     = []

    ## @camera.look_at
    center = Mageo::Vector3D[0.0, 0.0, 0.0]
    @cell.axes.each { |axis| center += axis.to_v3d * 0.5 }
    @camera.look_at = center
  end

  # Reset camera location, using relative vector from center of cell
  # with cartesian coordinate.
  def camera_location(vector)
    look_at = @camera.look_at || [0.0, 0.0, 0.0]
    look_at = Mageo::Vector3D[*look_at]
    @camera.location = look_at + Mageo::Vector3D[*vector]
  end

  # Reset camera location, using relative vector from center of cell
  # with polar coordinates.
  # theta and phi is set as degree. Not radian.
  def camera_location_polar(r, theta, phi)
    theta =  (2.0 * Math::PI) * theta / 360.0
    phi   =  (2.0 * Math::PI) * phi   / 360.0

    look_at = Mageo::Vector3D[*(@camera.look_at || [0.0, 0.0, 0.0])]
    polar = Mageo::Polar3D.new(r, theta, phi)
    @camera.location = look_at + polar.to_v3d
  end

  #
  def shoot_snap(basename)
    povfile = basename + '.pov'
    File.open(povfile, 'w') do |io|
      dump(io)
    end
    system "povray -D #{povfile}"
  end

  # shoot 4 angles and unite.
  def shoot_4in1(basename, delete_intermediate = true)
    name_x = basename + '-x'
    name_y = basename + '-y'
    name_z = basename + '-z'
    name_w = basename + '-w'
    name_zw = basename + '-zw'
    name_xy = basename + '-xy'
    name_zwxy = basename + '-zwxy'

    r = 10.0
    povray = Marshal.load(Marshal.dump(self))
    povray.camera_location_polar(r, 0, 0)   ; povray.shoot_snap( name_z )
    povray.camera_location_polar(r, 90, 0)  ; povray.shoot_snap( name_x )
    povray.camera_location_polar(r, 90, 90) ; povray.shoot_snap( name_y )
    povray.camera_location_polar(r, 80, 70) ; povray.shoot_snap( name_w )

    system "convert +append #{name_z }.png #{name_w }.png #{name_zw  }.png"
    system "convert +append #{name_x }.png #{name_y }.png #{name_xy  }.png"
    system "convert -append #{name_zw}.png #{name_xy}.png #{name_zwxy}.png"

    #中間ファイルを消す。
    if delete_intermediate
      [
        name_w + '.png',
        name_w + '.pov',
        name_x + '.png',
        name_x + '.pov',
        name_y + '.png',
        name_y + '.pov',
        name_z + '.png',
        name_z + '.pov',
        name_zw + '.png',
        name_xy + '.png',
      ].each do |file|
        FileUtils.rm file if FileTest.exist? file
      end
    end
  end

  ##lattice を描くか
  #def set_lattice(axes)
  #end

  #def set_atoms(cell)
  #end

  # 3つの棒で座標軸を配置
  # x, y, z 軸をそれぞれ red, green, blue で表示。
  def set_axes(position)
    #o = Vector3D[-1.0, -1.0, 0.0]
    o = Mageo::Vector3D[*position]
    x = Mageo::Vector3D[1.0, 0.0, 0.0]
    y = Mageo::Vector3D[0.0, 1.0, 0.0]
    z = Mageo::Vector3D[0.0, 0.0, 1.0]
    ox = o + x
    oy = o + y
    oz = o + z

    @axes = [
      CrystalCell::Povray::Cylinder.new(o, ox, 0.04, x),
      CrystalCell::Povray::Cylinder.new(o, oy, 0.04, y),
      CrystalCell::Povray::Cylinder.new(o, oz, 0.04, z)
    ]
  end

  def dump(io)
    @camera.dump(io)
    @environments.each { |item| io.puts item }
    @cell.dump(io)

    if @axes
      @axes.each {|axis| axis.dump(io)}
    end
    
    @objects.each { |obj| obj.dump(io) }
  end

end

#  def test_gen_image
#    TODO
#  end
#
#  def test_gen_4in1_images
#    TODO
#  end
#
#  def test_additional
#    c10 = CrystalCell::Povray::Camera.new(
#      camera_type: 'orthographic',
#      location:     [   3.0, 3.0, 3.0 ],
#      look_at:      [   0.0, 0.0, 0.0 ],
#      sky:          [   0.0, 0.0, 1.0 ],
#      right:        [ -1.00, 0.0, 0.0 ],
#      up:           [   0.0, 1.0, 0.0 ],
#      angle:        68,
#      additions:[ "background {color rgb<1,1,1>}",
#                  "light_source{ < 4, 1, 4 > color <1,1,1> parallel point_at 0 }",
#                  "default{ texture{ finish{ ambient 0.4 phong 1.0 phong_size 10 } } }",
#                ]
#    )
#    correct = <<HERE
#camera {
#  orthographic
#  location <3.000000, 3.000000, 3.000000 >
#  sky      <0.000000, 0.000000, 1.000000 >
#  right    <-1.000000, 0.000000, 0.000000 >
#  up       <0.000000, 1.000000, 0.000000 >
#  angle    68.000000
#  look_at  <0.000000, 0.000000, 0.000000 >
#}
#HERE
#    io = StringIO.new
#    c10.dump(io)
#    io.rewind
#    result = io.read
#    assert_equal(correct, result)
#  end

  #bond を描くか
  #def set_bond(cell)
  #end

