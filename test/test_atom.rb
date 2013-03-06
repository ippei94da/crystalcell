#! /usr/bin/ruby

require "test/unit"
require "crystalcell"
require "rubygems"
#gem "mageo"
#require "mageo/vector3d.rb"
require "mageo"

class TC_Atom < Test::Unit::TestCase
  $tolerance = 10.0 ** (-10)

  def setup
    @a0 = CrystalCell::Atom.new("Li", [ 0.0, 0.0, 0.0 ])
    @a1 = CrystalCell::Atom.new("Li", [ 1.0, 1.0, 1.0 ])
    @a2 = CrystalCell::Atom.new("Li", [ 0.0, 0.0, 0.0 ])
    @a3 = CrystalCell::Atom.new("Be", [ 0.0, 0.0, 0.0 ])
    @a4 = CrystalCell::Atom.new("Li", [ 1.0, 2.3, 4.5 ])
    @a5 = CrystalCell::Atom.new("Li", [-1.0,-2.3,-4.5 ])
    @a6 = CrystalCell::Atom.new(   3, [-1.0,-2.3,-4.5 ])
  end

  def test_initialize
    assert_raise(CrystalCell::Atom::TypeError){ CrystalCell::Atom.new(nil, nil, nil) }
    assert_raise(CrystalCell::Atom::TypeError){ CrystalCell::Atom.new(nil, nil, "A") }
    assert_raise(CrystalCell::Atom::TypeError){ CrystalCell::Atom.new(nil, [0.0, 0.0], "A") }
    assert_raise(CrystalCell::Atom::TypeError){ CrystalCell::Atom.new(nil, [0.0, 0.0, 0.0, 0.0], "A") }
    a0 = CrystalCell::Atom.new(nil, [ 0.0, 0.0, 0.0], nil)
    a1 = CrystalCell::Atom.new(nil, [ 0.0, 0.0, 0.0], "A")
    assert_equal(nil, a0.name)
    assert_equal("A", a1.name)
  end

  def test_equal_in_delta?
    assert_equal(true , CrystalCell::Atom.equal_in_delta?(@a0, @a0))
    assert_equal(false, CrystalCell::Atom.equal_in_delta?(@a0, @a1))
    assert_equal(true , CrystalCell::Atom.equal_in_delta?(@a0, @a2))
    assert_equal(false, CrystalCell::Atom.equal_in_delta?(@a0, @a3))
    assert_equal(false, CrystalCell::Atom.equal_in_delta?(@a1, @a0))
    assert_equal(true , CrystalCell::Atom.equal_in_delta?(@a1, @a1))
    assert_equal(false, CrystalCell::Atom.equal_in_delta?(@a1, @a2))
    assert_equal(false, CrystalCell::Atom.equal_in_delta?(@a1, @a3))
    assert_equal(true , CrystalCell::Atom.equal_in_delta?(@a2, @a0))
    assert_equal(false, CrystalCell::Atom.equal_in_delta?(@a2, @a1))
    assert_equal(true , CrystalCell::Atom.equal_in_delta?(@a2, @a2))
    assert_equal(false, CrystalCell::Atom.equal_in_delta?(@a2, @a3))
    assert_equal(false, CrystalCell::Atom.equal_in_delta?(@a3, @a0))
    assert_equal(false, CrystalCell::Atom.equal_in_delta?(@a3, @a1))
    assert_equal(false, CrystalCell::Atom.equal_in_delta?(@a3, @a2))
    assert_equal(true , CrystalCell::Atom.equal_in_delta?(@a3, @a3))

    assert_equal(true , CrystalCell::Atom.equal_in_delta?(@a0, @a0, 2.0))
    assert_equal(true , CrystalCell::Atom.equal_in_delta?(@a0, @a1, 2.0))
    assert_equal(true , CrystalCell::Atom.equal_in_delta?(@a0, @a2, 2.0))
    assert_equal(false, CrystalCell::Atom.equal_in_delta?(@a0, @a3, 2.0))
    assert_equal(true , CrystalCell::Atom.equal_in_delta?(@a1, @a0, 2.0))
    assert_equal(true , CrystalCell::Atom.equal_in_delta?(@a1, @a1, 2.0))
    assert_equal(true , CrystalCell::Atom.equal_in_delta?(@a1, @a2, 2.0))
    assert_equal(false, CrystalCell::Atom.equal_in_delta?(@a1, @a3, 2.0))
    assert_equal(true , CrystalCell::Atom.equal_in_delta?(@a2, @a0, 2.0))
    assert_equal(true , CrystalCell::Atom.equal_in_delta?(@a2, @a1, 2.0))
    assert_equal(true , CrystalCell::Atom.equal_in_delta?(@a2, @a2, 2.0))
    assert_equal(false, CrystalCell::Atom.equal_in_delta?(@a2, @a3, 2.0))
    assert_equal(false, CrystalCell::Atom.equal_in_delta?(@a3, @a0, 2.0))
    assert_equal(false, CrystalCell::Atom.equal_in_delta?(@a3, @a1, 2.0))
    assert_equal(false, CrystalCell::Atom.equal_in_delta?(@a3, @a2, 2.0))
    assert_equal(true , CrystalCell::Atom.equal_in_delta?(@a3, @a3, 2.0))

    assert_equal(true , @a0.equal_in_delta?(@a0))
    assert_equal(false, @a0.equal_in_delta?(@a1))
    assert_equal(true , @a0.equal_in_delta?(@a2))
    assert_equal(false, @a0.equal_in_delta?(@a3))
    assert_equal(false, @a1.equal_in_delta?(@a0))
    assert_equal(true , @a1.equal_in_delta?(@a1))
    assert_equal(false, @a1.equal_in_delta?(@a2))
    assert_equal(false, @a1.equal_in_delta?(@a3))
    assert_equal(true , @a2.equal_in_delta?(@a0))
    assert_equal(false, @a2.equal_in_delta?(@a1))
    assert_equal(true , @a2.equal_in_delta?(@a2))
    assert_equal(false, @a2.equal_in_delta?(@a3))
    assert_equal(false, @a3.equal_in_delta?(@a0))
    assert_equal(false, @a3.equal_in_delta?(@a1))
    assert_equal(false, @a3.equal_in_delta?(@a2))
    assert_equal(true , @a3.equal_in_delta?(@a3))

    assert_equal(true , @a0.equal_in_delta?(@a0, 2.0))
    assert_equal(true , @a0.equal_in_delta?(@a1, 2.0))
    assert_equal(true , @a0.equal_in_delta?(@a2, 2.0))
    assert_equal(false, @a0.equal_in_delta?(@a3, 2.0))
    assert_equal(true , @a1.equal_in_delta?(@a0, 2.0))
    assert_equal(true , @a1.equal_in_delta?(@a1, 2.0))
    assert_equal(true , @a1.equal_in_delta?(@a2, 2.0))
    assert_equal(false, @a1.equal_in_delta?(@a3, 2.0))
    assert_equal(true , @a2.equal_in_delta?(@a0, 2.0))
    assert_equal(true , @a2.equal_in_delta?(@a1, 2.0))
    assert_equal(true , @a2.equal_in_delta?(@a2, 2.0))
    assert_equal(false, @a2.equal_in_delta?(@a3, 2.0))
    assert_equal(false, @a3.equal_in_delta?(@a0, 2.0))
    assert_equal(false, @a3.equal_in_delta?(@a1, 2.0))
    assert_equal(false, @a3.equal_in_delta?(@a2, 2.0))
    assert_equal(true , @a3.equal_in_delta?(@a3, 2.0))
  end

  def test_equal
    assert_equal(true, @a0 == CrystalCell::Atom.new("Li", [0.0, 0.0, 0.0]))
    assert_equal(true, @a1 == CrystalCell::Atom.new("Li", [1.0, 1.0, 1.0]))
    assert_equal(true, @a2 == CrystalCell::Atom.new("Li", [0.0, 0.0, 0.0]))
    assert_equal(true, @a3 == CrystalCell::Atom.new("Be", [0.0, 0.0, 0.0]))

    assert_equal(false, @a0 == CrystalCell::Atom.new("Li", [0.9, 0.0, 0.0]))
    assert_equal(false, @a1 == CrystalCell::Atom.new("Li", [1.1, 1.0, 1.0]))
    assert_equal(false, @a2 == CrystalCell::Atom.new("Li", [0.9, 0.0, 0.0]))
    assert_equal(false, @a3 == CrystalCell::Atom.new("Be", [0.9, 0.0, 0.0]))
  end

  def test_internal_coordinates
    assert_equal(Vector3DInternal[ 0.0, 0.0, 0.0 ], @a0.internal_coordinates)
    assert_equal(Vector3DInternal[ 0.0, 0.0, 0.0 ], @a1.internal_coordinates)
    assert_equal(Vector3DInternal[ 0.0, 0.0, 0.0 ], @a2.internal_coordinates)
    assert_equal(Vector3DInternal[ 0.0, 0.0, 0.0 ], @a3.internal_coordinates)

    assert_equal(Vector3DInternal, @a4.internal_coordinates.class)
    assert_in_delta(0.0, @a4.internal_coordinates[0], $tolerance)
    assert_in_delta(0.3, @a4.internal_coordinates[1], $tolerance)
    assert_in_delta(0.5, @a4.internal_coordinates[2], $tolerance)

    assert_equal(Vector3DInternal, @a5.internal_coordinates.class)
    assert_in_delta(0.0, @a5.internal_coordinates[0], $tolerance)
    assert_in_delta(0.7, @a5.internal_coordinates[1], $tolerance)
    assert_in_delta(0.5, @a5.internal_coordinates[2], $tolerance)
  end

  def test_translation_symmetry_operation
    assert_equal(Vector3DInternal[ 0, 0, 0 ], @a0.translation_symmetry_operation)
    assert_equal(Vector3DInternal[ 1, 1, 1 ], @a1.translation_symmetry_operation)
    assert_equal(Vector3DInternal[ 0, 0, 0 ], @a2.translation_symmetry_operation)
    assert_equal(Vector3DInternal[ 0, 0, 0 ], @a3.translation_symmetry_operation)
    assert_equal(Vector3DInternal[ 1, 2, 4 ], @a4.translation_symmetry_operation)
    assert_equal(Vector3DInternal[-1,-3,-5 ], @a5.translation_symmetry_operation)
  end

  def test_set_position
    assert_equal(Vector3DInternal[ 1.2, 2.3, 3.4 ], @a3.set_position([ 1.2, 2.3, 3.4 ]))
    assert_equal(Vector3DInternal[ 2.3, 3.4, 4.5 ], @a4.set_position([ 2.3, 3.4, 4.5 ]))
    assert_raise(CrystalCell::Atom::TypeError){
      @a4.set_position(Vector3D[ 2.3, 3.4, 4.5 ])
    }
  end

  def test_element
    @a6.element = "Li"
    assert_equal(@a5, @a6)
  end

  def test_translate!
    @a0.translate!([ 1.2, 3.4, 5.6 ])
    assert_equal("Li", @a0.element)
    assert_in_delta(1.2 , @a0.position[0], $tolerance)
    assert_in_delta(3.4 , @a0.position[1], $tolerance)
    assert_in_delta(5.6 , @a0.position[2], $tolerance)

    @a3.translate!([ 1.2, 3.4, 5.6 ])
    assert_equal("Be", @a3.element)
    assert_in_delta(1.2 , @a3.position[0], $tolerance)
    assert_in_delta(3.4 , @a3.position[1], $tolerance)
    assert_in_delta(5.6 , @a3.position[2], $tolerance)


    @a5.translate!([ 1.0, 1.0, 1.0 ])
    assert_equal("Li", @a5.element)
    assert_in_delta(0.0 , @a5.position[0], $tolerance)
    assert_in_delta(-1.3 , @a5.position[1], $tolerance)
    assert_in_delta(-3.5 , @a5.position[2], $tolerance)
    
    # Vector3D なら例外
    assert_raise(CrystalCell::Atom::TypeError){ @a0.translate!(Vector3D[ 0.0, 0.0, 0.0 ]) }

    # 3次元でなければ例外
    assert_raise(CrystalCell::Atom::TypeError){ @a0.translate!([ 0.0, 0.0 ]) }
    assert_raise(CrystalCell::Atom::TypeError){ @a0.translate!([ 0.0, 0.0, 0.0, 0.0 ]) }
  end

  def test_translate
    t = @a0.translate([ 1.2, 3.4, 5.6 ])
    assert_equal("Li", t.element)
    assert_in_delta(1.2, t.position[0], $tolerance)
    assert_in_delta(3.4, t.position[1], $tolerance)
    assert_in_delta(5.6, t.position[2], $tolerance)

    t = @a3.translate([ 1.2, 3.4, 5.6 ])
    assert_equal("Be", t.element)
    assert_in_delta(1.2, t.position[0], $tolerance)
    assert_in_delta(3.4, t.position[1], $tolerance)
    assert_in_delta(5.6, t.position[2], $tolerance)

    t = @a5.translate([ 1.0, 1.0, 1.0 ])
    assert_equal("Li", t.element)
    assert_in_delta(0.0, t.position[0], $tolerance)
    assert_in_delta(-1.3, t.position[1], $tolerance)
    assert_in_delta(-3.5, t.position[2], $tolerance)
    
    # Vector3D なら例外
    assert_raise(CrystalCell::Atom::TypeError){ @a0.translate(Vector3D[ 0.0, 0.0, 0.0 ]) }

    # 3次元でなければ例外
    assert_raise(CrystalCell::Atom::TypeError){ @a0.translate([ 0.0, 0.0 ]) }
    assert_raise(CrystalCell::Atom::TypeError){ @a0.translate([ 0.0, 0.0, 0.0, 0.0 ]) }
  end

end

