#! /usr/bin/ruby

require "test/unit"
require "rubygems"
gem "mageo"
require "mageo/vector3d.rb"
require "crystalcell/latticeaxes.rb"

class CrystalCell::LatticeAxes
  #public :triangulate, :rotate
  #public :rotate
end

class TC_LatticeAxes < Test::Unit::TestCase
  $tolerance = 10 ** (-10)

  include Math

  def setup
    @axes1 = [ [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0] ]

    @lc1 = CrystalCell::LatticeAxes.new([ [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0] ])
    @lc2 = CrystalCell::LatticeAxes.new([ [0.5, 0.5, 0.0], [0.5, 0.0, 0.5], [0.0, 0.5, 0.5] ])
    @lc3 = CrystalCell::LatticeAxes.new(CrystalCell::LatticeAxes.lc_to_axes([1.0, 1.0, 1.0, 90.0, 90.0, 90.0]))
    @lc4 = CrystalCell::LatticeAxes.new(
      CrystalCell::LatticeAxes.lc_to_axes(
      [ Math::sqrt(0.5), Math::sqrt(0.5), Math::sqrt(0.5),
      60.0, 60.0, 60.0]) # Math::sqrt(0.5) == 0.5* Math::sqrt(2.0)
    )
    @lc5 = CrystalCell::LatticeAxes.new([ [1.0, 1.0, 1.0], [0.0, 1.0, 1.0], [0.0, 0.0, 1.0] ])
    @lc6 = CrystalCell::LatticeAxes.new([ [1.0, 1.0, 1.0], [0.0,-1.0,-1.0], [0.0, 0.0, 1.0] ])

    @vec_x = Vector3D[ 1.0, 0.0, 0.0 ]
    @vec_y = Vector3D[ 0.0, 1.0, 0.0 ]
    @vec_z = Vector3D[ 0.0, 0.0, 1.0 ]
    @vec_0 = Vector3D[ 0.0, 0.0, 0.0 ]
    @vec_1 = Vector3D[ 1.0, 1.0, 0.0 ]
  end

  def test_initialize
    assert_raise(ArgumentError) { CrystalCell::LatticeAxes.new }
    assert_raise(CrystalCell::LatticeAxes::InitializeError) { CrystalCell::LatticeAxes.new([]) }
    assert_raise(CrystalCell::LatticeAxes::InitializeError) {
      CrystalCell::LatticeAxes.new([1.0, 1.0, 1.0, 90.0, 90.0, 90.0])
    }

    assert_raise(CrystalCell::LatticeAxes::InitializeError) {CrystalCell::LatticeAxes.new([0,1])}
    assert_raise(CrystalCell::LatticeAxes::InitializeError) {CrystalCell::LatticeAxes.new([0,1,2,3])}
    assert_nothing_raised {CrystalCell::LatticeAxes.new([ @vec_x, @vec_y, @vec_z ]) }
    assert_raise(CrystalCell::LatticeAxes::InitializeError) {CrystalCell::LatticeAxes.new([ @vec_x, @vec_y, @vec_0 ]) }
    assert_raise(CrystalCell::LatticeAxes::InitializeError) {CrystalCell::LatticeAxes.new([ @vec_x, @vec_y, [1, 2, 3, 4] ]) }

    assert_in_delta(1.0, @lc1.axes[0][0], $tolerance)
    assert_in_delta(0.0, @lc1.axes[0][1], $tolerance)
    assert_in_delta(0.0, @lc1.axes[0][2], $tolerance)
    assert_in_delta(0.0, @lc1.axes[1][0], $tolerance)
    assert_in_delta(1.0, @lc1.axes[1][1], $tolerance)
    assert_in_delta(0.0, @lc1.axes[1][2], $tolerance)
    assert_in_delta(0.0, @lc1.axes[2][0], $tolerance)
    assert_in_delta(0.0, @lc1.axes[2][1], $tolerance)
    assert_in_delta(1.0, @lc1.axes[2][2], $tolerance)

    assert_in_delta(- 0.577350269189626, @lc2.axes[0][0], $tolerance)
    assert_in_delta(  0.204124145231932, @lc2.axes[0][1], $tolerance)
    assert_in_delta(  0.353553390593274, @lc2.axes[0][2], $tolerance)
    assert_in_delta(  0.000000000000000, @lc2.axes[1][0], $tolerance)
    assert_in_delta(  0.612372435695795, @lc2.axes[1][1], $tolerance)
    assert_in_delta(  0.353553390593274, @lc2.axes[1][2], $tolerance)
    assert_in_delta(  0.000000000000000, @lc2.axes[2][0], $tolerance)
    assert_in_delta(  0.000000000000000, @lc2.axes[2][1], $tolerance)
    assert_in_delta(  0.707106781186548, @lc2.axes[2][2], $tolerance)

    assert_in_delta(1.0, @lc3.axes[0][0], $tolerance)
    assert_in_delta(0.0, @lc3.axes[0][1], $tolerance)
    assert_in_delta(0.0, @lc3.axes[0][2], $tolerance)
    assert_in_delta(0.0, @lc3.axes[1][0], $tolerance)
    assert_in_delta(1.0, @lc3.axes[1][1], $tolerance)
    assert_in_delta(0.0, @lc3.axes[1][2], $tolerance)
    assert_in_delta(0.0, @lc3.axes[2][0], $tolerance)
    assert_in_delta(0.0, @lc3.axes[2][1], $tolerance)
    assert_in_delta(1.0, @lc3.axes[2][2], $tolerance)

    assert_in_delta(0.577350269189626, @lc4.axes[0][0], $tolerance)
    assert_in_delta(0.204124145231932, @lc4.axes[0][1], $tolerance)
    assert_in_delta(0.353553390593274, @lc4.axes[0][2], $tolerance)
    assert_in_delta(0.000000000000000, @lc4.axes[1][0], $tolerance)
    assert_in_delta(0.612372435695795, @lc4.axes[1][1], $tolerance)
    assert_in_delta(0.353553390593274, @lc4.axes[1][2], $tolerance)
    assert_in_delta(0.000000000000000, @lc4.axes[2][0], $tolerance)
    assert_in_delta(0.000000000000000, @lc4.axes[2][1], $tolerance)
    assert_in_delta(0.707106781186548, @lc4.axes[2][2], $tolerance)

    # triangulate の結果、b 軸の y 成分は 正方向であるべき。
    assert_in_delta(-1.0, @lc6.axes[0][0], $tolerance)
    assert_in_delta(-1.0, @lc6.axes[0][1], $tolerance)
    assert_in_delta(1.0, @lc6.axes[0][2], $tolerance)
    assert_in_delta(0.0, @lc6.axes[1][0], $tolerance)
    assert_in_delta(1.0, @lc6.axes[1][1], $tolerance)
    assert_in_delta(-1.0, @lc6.axes[1][2], $tolerance)
    assert_in_delta(0.0, @lc6.axes[2][0], $tolerance)
    assert_in_delta(0.0, @lc6.axes[2][1], $tolerance)
    assert_in_delta(1.0, @lc6.axes[2][2], $tolerance)
  end

  ## Class methods.

  #def test_self_triangulate
  # result = CrystalCell::LatticeAxes.triangulate([ [0.5, 0.5, 0.0], [0.0, 0.5, 0.5], [0.5, 0.0, 0.5] ])
  # assert_in_delta(0.577350269189626, result[0][0], $tolerance)
  # assert_in_delta(0.204124145231932, result[0][1], $tolerance)
  # assert_in_delta(0.353553390593274, result[0][2], $tolerance)
  # assert_in_delta(0.000000000000000, result[1][0], $tolerance)
  # assert_in_delta(0.612372435695795, result[1][1], $tolerance)
  # assert_in_delta(0.353553390593274, result[1][2], $tolerance)
  # assert_in_delta(0.000000000000000, result[2][0], $tolerance)
  # assert_in_delta(0.000000000000000, result[2][1], $tolerance)
  # assert_in_delta(0.707106781186548, result[2][2], $tolerance)
  #end

  def test_self_lc_to_axes
    axes = CrystalCell::LatticeAxes.lc_to_axes([ 1.0, 1.0, 1.0, 90.0, 90.0, 90.0 ])
    assert_in_delta(@axes1[0][0], axes[0][0], $tolerance)
    assert_in_delta(@axes1[0][1], axes[0][1], $tolerance)
    assert_in_delta(@axes1[0][2], axes[0][2], $tolerance)
    assert_in_delta(@axes1[1][0], axes[1][0], $tolerance)
    assert_in_delta(@axes1[1][1], axes[1][1], $tolerance)
    assert_in_delta(@axes1[1][2], axes[1][2], $tolerance)
    assert_in_delta(@axes1[2][0], axes[2][0], $tolerance)
    assert_in_delta(@axes1[2][1], axes[2][1], $tolerance)
    assert_in_delta(@axes1[2][2], axes[2][2], $tolerance)

    axes = CrystalCell::LatticeAxes.lc_to_axes([ 1.0, 1.0, 1.0, 90.0, 90.0, 90.0 ], false)
    assert_in_delta(- @axes1[0][0], axes[0][0], $tolerance)
    assert_in_delta( @axes1[0][1], axes[0][1], $tolerance)
    assert_in_delta( @axes1[0][2], axes[0][2], $tolerance)
    assert_in_delta( @axes1[1][0], axes[1][0], $tolerance)
    assert_in_delta( @axes1[1][1], axes[1][1], $tolerance)
    assert_in_delta( @axes1[1][2], axes[1][2], $tolerance)
    assert_in_delta( @axes1[2][0], axes[2][0], $tolerance)
    assert_in_delta( @axes1[2][1], axes[2][1], $tolerance)
    assert_in_delta( @axes1[2][2], axes[2][2], $tolerance)
  end

  def test_self_axes_to_lc
    correct = [ 1.0, 1.0, 1.0, 90.0, 90.0, 90.0 ]
    assert_equal(correct, CrystalCell::LatticeAxes.axes_to_lc(@axes1))

    #correct = [ 1.0, 1.0, 1.0, 90.0, 90.0, 90.0 ]
    #assert_equal(correct, CrystalCell::LatticeAxes.axes_to_lc(@axes1))
  end

  def test_equal_in_delta?
    assert_equal(true , @lc1.equal_in_delta?(@lc1, 0.01, 1.0))
    assert_equal(false, @lc1.equal_in_delta?(@lc2, 0.01, 1.0))
    assert_equal(false, @lc1.equal_in_delta?(@lc4, 0.01, 1.0))
    assert_equal(false, @lc2.equal_in_delta?(@lc1, 0.01, 1.0))
    assert_equal(true , @lc2.equal_in_delta?(@lc2, 0.01, 1.0))
    assert_equal(true , @lc2.equal_in_delta?(@lc4, 0.01, 1.0))
    assert_equal(false, @lc4.equal_in_delta?(@lc1, 0.01, 1.0))
    assert_equal(true , @lc4.equal_in_delta?(@lc2, 0.01, 1.0))
    assert_equal(true , @lc4.equal_in_delta?(@lc4, 0.01, 1.0))
  end

  def test_self_righthand?
    # Righthand
    assert_equal(true , CrystalCell::LatticeAxes.righthand?([ @vec_x, @vec_y, @vec_z ]))
    assert_equal(true , CrystalCell::LatticeAxes.righthand?([ @vec_y, @vec_z, @vec_x ]))
    assert_equal(true , CrystalCell::LatticeAxes.righthand?([ @vec_z, @vec_x, @vec_y ]))

    # Lefthand
    assert_equal(false, CrystalCell::LatticeAxes.righthand?([ @vec_z, @vec_y, @vec_x ]))
    assert_equal(false, CrystalCell::LatticeAxes.righthand?([ @vec_x, @vec_z, @vec_y ]))
    assert_equal(false, CrystalCell::LatticeAxes.righthand?([ @vec_y, @vec_x, @vec_z ]))

    # Including zero vector.
    assert_equal(false, CrystalCell::LatticeAxes.righthand?([ @vec_0, @vec_y, @vec_z ]))
    assert_equal(false, CrystalCell::LatticeAxes.righthand?([ @vec_0, @vec_z, @vec_x ]))
    assert_equal(false, CrystalCell::LatticeAxes.righthand?([ @vec_0, @vec_x, @vec_y ]))

    # One vector is on the plane of residual two vectors.
    assert_equal(false, CrystalCell::LatticeAxes.righthand?([ @vec_x, @vec_y, @vec_1 ]))
  end

  def test_self_lefthand?
    # Righthand
    assert_equal(false, CrystalCell::LatticeAxes.lefthand?([ @vec_x, @vec_y, @vec_z ]))
    assert_equal(false, CrystalCell::LatticeAxes.lefthand?([ @vec_y, @vec_z, @vec_x ]))
    assert_equal(false, CrystalCell::LatticeAxes.lefthand?([ @vec_z, @vec_x, @vec_y ]))

    # Lefthand
    assert_equal(true , CrystalCell::LatticeAxes.lefthand?([ @vec_z, @vec_y, @vec_x ]))
    assert_equal(true , CrystalCell::LatticeAxes.lefthand?([ @vec_x, @vec_z, @vec_y ]))
    assert_equal(true , CrystalCell::LatticeAxes.lefthand?([ @vec_y, @vec_x, @vec_z ]))

    # Including zero vector.
    assert_equal(false, CrystalCell::LatticeAxes.lefthand?([ @vec_0, @vec_y, @vec_z ]))
    assert_equal(false, CrystalCell::LatticeAxes.lefthand?([ @vec_0, @vec_z, @vec_x ]))
    assert_equal(false, CrystalCell::LatticeAxes.lefthand?([ @vec_0, @vec_x, @vec_y ]))

    # One vector is on the plane of residual two vectors.
    assert_equal(false, CrystalCell::LatticeAxes.lefthand?([ @vec_x, @vec_y, @vec_1 ]))
  end

  ## Instance methods.

  def test_get_lattice_constants
    assert_in_delta( 1.0, @lc1.get_lattice_constants[0], $tolerance)
    assert_in_delta( 1.0, @lc1.get_lattice_constants[1], $tolerance)
    assert_in_delta( 1.0, @lc1.get_lattice_constants[2], $tolerance)
    assert_in_delta(90.0, @lc1.get_lattice_constants[3], $tolerance)
    assert_in_delta(90.0, @lc1.get_lattice_constants[4], $tolerance)
    assert_in_delta(90.0, @lc1.get_lattice_constants[5], $tolerance)
    assert_in_delta(Math::sqrt(0.5), @lc2.get_lattice_constants[0], $tolerance)
    assert_in_delta(Math::sqrt(0.5), @lc2.get_lattice_constants[1], $tolerance)
    assert_in_delta(Math::sqrt(0.5), @lc2.get_lattice_constants[2], $tolerance)
    assert_in_delta(60.0, @lc2.get_lattice_constants[3], $tolerance)
    assert_in_delta(60.0, @lc2.get_lattice_constants[4], $tolerance)
    assert_in_delta(60.0, @lc2.get_lattice_constants[5], $tolerance)
    assert_in_delta( 1.0, @lc3.get_lattice_constants[0], $tolerance)
    assert_in_delta( 1.0, @lc3.get_lattice_constants[1], $tolerance)
    assert_in_delta( 1.0, @lc3.get_lattice_constants[2], $tolerance)
    assert_in_delta(90.0, @lc3.get_lattice_constants[3], $tolerance)
    assert_in_delta(90.0, @lc3.get_lattice_constants[4], $tolerance)
    assert_in_delta(90.0, @lc3.get_lattice_constants[5], $tolerance)
    assert_in_delta(Math::sqrt(0.5), @lc4.get_lattice_constants[0], $tolerance)
    assert_in_delta(Math::sqrt(0.5), @lc4.get_lattice_constants[1], $tolerance)
    assert_in_delta(Math::sqrt(0.5), @lc4.get_lattice_constants[2], $tolerance)
    assert_in_delta(60.0, @lc4.get_lattice_constants[3], $tolerance)
    assert_in_delta(60.0, @lc4.get_lattice_constants[4], $tolerance)
    assert_in_delta(60.0, @lc4.get_lattice_constants[5], $tolerance)
  end

  def test_righthand?
    assert_equal(true , @lc1.righthand?)
    assert_equal(false, @lc2.righthand?)
  end

  def test_lefthand?
    assert_equal(false, @lc1.lefthand?)
    assert_equal(true , @lc2.lefthand?)
  end

  #def test_internal2cartesian
  # assert_raise(CrystalCell::LatticeAxes::TypeError){
  #   @lc5.internal2cartesian([ 2.0, 3.0, 4.0 ])
  # }
  # assert_in_delta(2.0, @lc5.internal2cartesian([ 2.0, 3.0, 4.0 ])[0], $tolerance)
  # assert_in_delta(5.0, @lc5.internal2cartesian([ 2.0, 3.0, 4.0 ])[1], $tolerance)
  # assert_in_delta(9.0, @lc5.internal2cartesian([ 2.0, 3.0, 4.0 ])[2], $tolerance)
  #end

  #def test_cartesian2internal
  # assert_in_delta(2.0, @lc5.cartesian2internal([ 2.0, 5.0, 9.0 ])[0], $tolerance)
  # assert_in_delta(3.0, @lc5.cartesian2internal([ 2.0, 5.0, 9.0 ])[1], $tolerance)
  # assert_in_delta(4.0, @lc5.cartesian2internal([ 2.0, 5.0, 9.0 ])[2], $tolerance)
  #end

  def test_equal
    assert_equal(true , @lc1 == @lc1)
    assert_equal(true , @lc2 == @lc2)
    assert_equal(true , @lc3 == @lc3)

    assert_equal(false, @lc1 == @lc2)
    assert_equal(false, @lc2 == @lc3)
    assert_equal(true , @lc3 == @lc1)

    assert_equal(true , @lc1 == @lc3)
    assert_equal(false, @lc2 == @lc1)
    assert_equal(false, @lc3 == @lc2)
  end

  def test_triangulate
    t = CrystalCell::LatticeAxes.new([ [0.5, 0.5, 0.0], [0.0, 0.5, 0.5], [0.5, 0.0, 0.5] ])
    assert_in_delta(0.577350269189626, t[0][0], $tolerance)
    assert_in_delta(0.204124145231932, t[0][1], $tolerance)
    assert_in_delta(0.353553390593274, t[0][2], $tolerance)
    assert_in_delta(0.000000000000000, t[1][0], $tolerance)
    assert_in_delta(0.612372435695795, t[1][1], $tolerance)
    assert_in_delta(0.353553390593274, t[1][2], $tolerance)
    assert_in_delta(0.000000000000000, t[2][0], $tolerance)
    assert_in_delta(0.000000000000000, t[2][1], $tolerance)
    assert_in_delta(0.707106781186548, t[2][2], $tolerance)
  end

  #def test_rotate
  # #@lc1 = CrystalCell::LatticeAxes.new([ [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0] ])
  # @lc1.rotate(0, 1, 2)
  # 
  # TODO
  #end


end

