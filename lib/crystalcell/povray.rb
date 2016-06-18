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
  
  # camera_info indicates hash with the keys of camera info,
  #   e.g., :camera_type, :location, :direction, :right, :sky, :up, :look_at
  def initialize(cell: , camera_info: {}, environments: DEFAULT_ENVIRONMENTS)
    @camera      = CrystalCell::Povray::Camera.new(camera_info)
    @environments = environments
    @cell = cell.to_povcell
    @objects     = []

    ## @camera.look_at
    center = Mageo::Vector3D[0.0, 0.0, 0.0]
    @cell.axes.each do |axis|
      #pp center
      #pp axis
      center += axis.to_v3d * 0.5
    end
    @camera.look_at = center
  end

  # Indicate relative position from center of cell with polar coordinate.
  def camera_location(r, theta, phi)
  end

  def camera_location_polar(r, theta, phi)
    Mageo::Polar3D.to_cartesian(r, theta, phi)

    #@camera.look_at +
  end

  #lattice を描くか
  def set_lattice(axes)
  end

  def set_atoms(cell)
  end

  def dump(io)
    @camera.dump(io)
    @environments.each { |item| io.puts item }
    @cell.dump(io)
    @objects.each { |obj| obj.dump(io) }
  end
  

  # Indicate camera position as polar coordinate)
  # theta, phi in degree.
  def gen_image(r, theta, phi) 
    to_pov
  end

  def gen_4in1_images
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

