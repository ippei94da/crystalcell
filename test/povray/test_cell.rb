#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "pp"

class TC_Povray_Sphere < Test::Unit::TestCase
  def setup
    @s00 = Mageo::Sphere.new( [ 1.0, 2.0, 3.0 ], 2.0)
  end

  def test_to_pov
    assert_equal( 
      "object { sphere{< 1.0000,  2.0000,  3.0000>,  2.0000} pigment {color rgb <0.30, 0.60, 0.90>} }",
      @s00.to_pov(color: [0.3, 0.6, 0.9]) )

    assert_equal( 
      "object { sphere{< 1.0000,  2.0000,  3.0000>,  2.0000} pigment {color rgbt <0.30, 0.60, 0.90, 0.50>} }",
      @s00.to_pov(color: [0.3, 0.6, 0.9], transmit: 0.5) )
  end
end

#class TC_Povray_Cylinder < Test::Unit::TestCase
#  def setup
#    @c00 = Mageo::Cylinder.new([[ 1.0, 2.0, 3.0 ], [4.0, 5.0, 6.0]], 2.0)
#  end
#
#  def test_to_pov
#    assert_equal(
#      "object { cylinder{ < 1.0000,  2.0000,  3.0000>, < 4.0000,  5.0000,  6.0000>,  2.0000 } pigment { color rgb <0.30, 0.60, 0.90> } }",
#      @c00.to_pov([0.3, 0.6, 0.9]) )
#  end
#end
#
#class TC_Povray_Triangle < Test::Unit::TestCase
#  def setup
#    @t00 = Mageo::Triangle.new(
#      [[ 1.0, 2.0, 3.0 ], [4.0, 5.0, 6.0], [0.3, 0.6, 0.9 ]]
#    )
#  end
#
#  def test_to_pov
#    assert_equal(
#      "polygon { 4, < 1.0000,  2.0000,  3.0000>, < 4.0000,  5.0000,  6.0000>, < 0.3000,  0.6000,  0.9000>, < 1.0000,  2.0000,  3.0000> pigment { color rgb <1, 0, 0> } }",
#      @t00.to_pov([0.3, 0.6, 0.9])
#    )
#  end
#end

class CrystalCell::Povray::Cell
#public :atoms_to_povs, :bonds_to_povs, :lattice_to_povs
  public :atom_to_pov
  public :periodic_translations

end
class TC_Povray_Cell < Test::Unit::TestCase
  def setup
    axes = [
      [2.0, 0.0, 0.0],
      [0.0, 2.0, 0.0],
      [0.0, 0.0, 2.0],
    ]
    atoms = [
      CrystalCell::Atom.new("Li", [0.0, 0.0, 0.0]),
      CrystalCell::Atom.new("O", [0.2, 0.3, 0.4]),
    ]
    @c00 = CrystalCell::Povray::Cell.new(axes, atoms)
  end

  def test_atoms_to_povs
    # without tolerance
    assert_equal(
      [ "object { sphere{< 0.0000,  0.0000,  0.0000>,  0.1770} pigment {color rgb <0.53, 0.88, 0.45>} } // Li\n",
        "object { sphere{< 0.4000,  0.6000,  0.8000>,  0.4200} pigment {color rgb <1.00, 0.01, 0.00>} } // O\n"
      ],
      @c00.atoms_to_povs
    )

    # with tolerance
    corrects = [
      "object { sphere{< 0.0000,  0.0000,  0.0000>,  0.1770} pigment {color rgb <0.53, 0.88, 0.45>} } // Li\n",
      "object { sphere{< 2.0000,  0.0000,  0.0000>,  0.1770} pigment {color rgb <0.53, 0.88, 0.45>} } // Li\n",
      "object { sphere{< 0.0000,  2.0000,  0.0000>,  0.1770} pigment {color rgb <0.53, 0.88, 0.45>} } // Li\n",
      "object { sphere{< 2.0000,  2.0000,  0.0000>,  0.1770} pigment {color rgb <0.53, 0.88, 0.45>} } // Li\n",
      "object { sphere{< 0.0000,  0.0000,  2.0000>,  0.1770} pigment {color rgb <0.53, 0.88, 0.45>} } // Li\n",
      "object { sphere{< 2.0000,  0.0000,  2.0000>,  0.1770} pigment {color rgb <0.53, 0.88, 0.45>} } // Li\n",
      "object { sphere{< 0.0000,  2.0000,  2.0000>,  0.1770} pigment {color rgb <0.53, 0.88, 0.45>} } // Li\n",
      "object { sphere{< 2.0000,  2.0000,  2.0000>,  0.1770} pigment {color rgb <0.53, 0.88, 0.45>} } // Li\n",
      "object { sphere{< 0.4000,  0.6000,  0.8000>,  0.4200} pigment {color rgb <1.00, 0.01, 0.00>} } // O\n",
    ]
    t = @c00.atoms_to_povs(tolerance: 0.01)
    corrects.each_with_index do |correct, index|
      assert_equal(correct, t[index], "line #{index.to_s}")
    end
    assert_equal(corrects.size, t.size)

    # with transmit
    results = @c00.atoms_to_povs(transmit: 0.5)
    corrects = [ "object { sphere{< 0.0000,  0.0000,  0.0000>,  0.1770} pigment {color rgbt <0.53, 0.88, 0.45, 0.50>} } // Li\n",
        "object { sphere{< 0.4000,  0.6000,  0.8000>,  0.4200} pigment {color rgbt <1.00, 0.01, 0.00, 0.50>} } // O\n"
      ]
    assert_equal(corrects, results)

  end

  def test_bond
    axes = [
      [2.0, 0.0, 0.0],
      [0.0, 2.0, 0.0],
      [0.0, 0.0, 2.0],
    ]
    atoms = [
      CrystalCell::Atom.new("Li", [0.0, 0.0, 0.0]),
      CrystalCell::Atom.new("O", [0.2, 0.3, 0.4]),
      CrystalCell::Atom.new("O", [0.3, 0.3, 0.4]),
    ]
    c00 = CrystalCell::Povray::Cell.new(axes, atoms)
    result =  c00.bond(['Li1', 'O2'])
    correct = [
      "object { cylinder{ < 0.0000,  0.0000,  0.0000>, < 0.3000,  0.3000,  0.4000>,  0.0500 } pigment { color rgb <0.53, 0.88, 0.45> } }",
      "object { cylinder{ < 0.6000,  0.6000,  0.8000>, < 0.3000,  0.3000,  0.4000>,  0.0500 } pigment { color rgb <1.00, 0.01, 0.00> } }",
    ].join("\n")
    assert_equal( correct, result)

    result =  c00.bond(['Li1-555', 'O2-555'])
    correct = [
      "object { cylinder{ < 0.0000,  0.0000,  0.0000>, < 0.3000,  0.3000,  0.4000>,  0.0500 } pigment { color rgb <0.53, 0.88, 0.45> } }",
      "object { cylinder{ < 0.6000,  0.6000,  0.8000>, < 0.3000,  0.3000,  0.4000>,  0.0500 } pigment { color rgb <1.00, 0.01, 0.00> } }",
    ].join("\n")
    assert_equal( correct, result)

    result =  c00.bond(['Li1-555', 'Li1-556'])
    correct = [
      "object { cylinder{ < 0.0000,  0.0000,  0.0000>, < 0.0000,  0.0000,  1.0000>,  0.0500 } pigment { color rgb <0.53, 0.88, 0.45> } }",
      "object { cylinder{ < 0.0000,  0.0000,  2.0000>, < 0.0000,  0.0000,  1.0000>,  0.0500 } pigment { color rgb <0.53, 0.88, 0.45> } }",
    ].join("\n")
    assert_equal( correct, result)
  end

  def test_triangle
    axes = [
      [2.0, 0.0, 0.0],
      [0.0, 2.0, 0.0],
      [0.0, 0.0, 2.0],
    ]
    atoms = [
      CrystalCell::Atom.new("Li", [0.0, 0.0, 0.0]),
      CrystalCell::Atom.new("O", [0.2, 0.3, 0.4]),
      CrystalCell::Atom.new("O", [0.3, 0.3, 0.4]),
    ]
    c00 = CrystalCell::Povray::Cell.new(axes, atoms)
    result =  c00.triangle(['Li1', 'O1', 'O2'])
    correct = [
      "triangle{ <  0.0000,  0.0000,  0.0000>,< 0.4000, 0.6000, 0.8000>,< 0.6000, 0.6000, 0.8000> pigment {color rgb< 0.5255, 0.8784, 0.4549>}}",
    ].join('')
    assert_equal( correct, result)
  end

  def test_tetrahedron
    axes = [
      [2.0, 0.0, 0.0],
      [0.0, 2.0, 0.0],
      [0.0, 0.0, 2.0],
    ]
    atoms = [
      CrystalCell::Atom.new("Li", [0.0, 0.0, 0.0]),
      CrystalCell::Atom.new("Li", [0.5, 0.5, 0.5]),
      CrystalCell::Atom.new("O", [0.2, 0.3, 0.4]),
      CrystalCell::Atom.new("O", [0.3, 0.3, 0.4]),
    ]
    c00 = CrystalCell::Povray::Cell.new(axes, atoms)
    result =  c00.tetrahedron(['Li1', 'Li2', 'O1', 'O2'])
    correct = [
      "triangle{ <  0.0000,  0.0000,  0.0000>,< 1.0000, 1.0000, 1.0000>,< 0.4000, 0.6000, 0.8000> pigment {color rgb< 0.5255, 0.8784, 0.4549>}}",
      "triangle{ <  1.0000,  1.0000,  1.0000>,< 0.4000, 0.6000, 0.8000>,< 0.6000, 0.6000, 0.8000> pigment {color rgb< 0.5255, 0.8784, 0.4549>}}",
      "triangle{ <  0.4000,  0.6000,  0.8000>,< 0.6000, 0.6000, 0.8000>,< 0.0000, 0.0000, 0.0000> pigment {color rgb< 0.5255, 0.8784, 0.4549>}}",
      "triangle{ <  0.6000,  0.6000,  0.8000>,< 0.0000, 0.0000, 0.0000>,< 1.0000, 1.0000, 1.0000> pigment {color rgb< 0.5255, 0.8784, 0.4549>}}"
    ].join("\n")
    assert_equal( correct, result)
  end

  def test_lattice_to_povs
    corrects = [
      "object { cylinder{ < 0.0000,  0.0000,  0.0000>, < 0.0000,  0.0000,  2.0000>,  0.0200 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 0.0000,  2.0000,  0.0000>, < 0.0000,  2.0000,  2.0000>,  0.0200 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 2.0000,  0.0000,  0.0000>, < 2.0000,  0.0000,  2.0000>,  0.0200 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 2.0000,  2.0000,  0.0000>, < 2.0000,  2.0000,  2.0000>,  0.0200 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 0.0000,  0.0000,  0.0000>, < 0.0000,  2.0000,  0.0000>,  0.0200 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 2.0000,  0.0000,  0.0000>, < 2.0000,  2.0000,  0.0000>,  0.0200 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 0.0000,  0.0000,  2.0000>, < 0.0000,  2.0000,  2.0000>,  0.0200 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 2.0000,  0.0000,  2.0000>, < 2.0000,  2.0000,  2.0000>,  0.0200 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 0.0000,  0.0000,  0.0000>, < 2.0000,  0.0000,  0.0000>,  0.0200 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 0.0000,  0.0000,  2.0000>, < 2.0000,  0.0000,  2.0000>,  0.0200 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 0.0000,  2.0000,  0.0000>, < 2.0000,  2.0000,  0.0000>,  0.0200 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 0.0000,  2.0000,  2.0000>, < 2.0000,  2.0000,  2.0000>,  0.0200 } pigment { color rgb <0.50, 0.50, 0.50> } }\n" ,
    ]
    t = @c00.lattice_to_povs
    corrects.each_with_index do |correct, index|
      assert_equal(correct, t[index], "line #{index.to_s}")
    end
    assert_equal(corrects.size, t.size)
  end

  def test_atom_to_pov
    assert_equal(
      "object { sphere{< 0.2000,  0.4000,  0.6000>,  0.1770} pigment {color rgb <0.53, 0.88, 0.45>} } // Li\n",
      @c00.atom_to_pov(atom: CrystalCell::Atom.new("Li", [0.1, 0.2, 0.3]))
    )

    assert_equal(
      "object { sphere{< 0.2000,  0.4000,  0.6000>,  0.1770} pigment {color rgbt <0.53, 0.88, 0.45, 0.50>} } // Li\n",
      @c00.atom_to_pov(atom: CrystalCell::Atom.new("Li", [0.1, 0.2, 0.3]), transmit: 0.5)
    )
  end

  def test_periodic_translations
    corrects = [
      Mageo::Vector3DInternal[0.0, 0.0, 0.0],
      Mageo::Vector3DInternal[1.0, 0.0, 0.0],
      Mageo::Vector3DInternal[0.0, 1.0, 0.0],
      Mageo::Vector3DInternal[1.0, 1.0, 0.0],
      Mageo::Vector3DInternal[0.0, 0.0, 1.0],
      Mageo::Vector3DInternal[1.0, 0.0, 1.0],
      Mageo::Vector3DInternal[0.0, 1.0, 1.0],
      Mageo::Vector3DInternal[1.0, 1.0, 1.0],
    ]
    t = @c00.periodic_translations([0.0, 0.0, 0.0], 0.1)
    assert_equal(corrects, t)

    corrects = [
      Mageo::Vector3DInternal[0.0, 0.0, 0.0],
      Mageo::Vector3DInternal[1.0, 0.0, 0.0],
      Mageo::Vector3DInternal[0.0, 1.0, 0.0],
      Mageo::Vector3DInternal[1.0, 1.0, 0.0],
    ]
    t = @c00.periodic_translations([0.0, 0.0, 0.5], 0.1)
    assert_equal(corrects, t)

    corrects = [
      Mageo::Vector3DInternal[0.0, 0.0, 0.0],
    ]
    t = @c00.periodic_translations([0.0, 0.0, 0.0], 0.0)
    assert_equal(corrects, t)
  end

  def test_atom_by_id
    result = @c00.atom_by_id('Li1-555')
    correct = CrystalCell::Atom.new("Li", [0.0, 0.0, 0.0])
    assert_equal(correct, result)

    result = @c00.atom_by_id('Li1-556')
    correct = CrystalCell::Atom.new("Li", [0.0, 0.0, 1.0])
    assert_equal(correct, result)

    result = @c00.atom_by_id('Li1-565')
    correct = CrystalCell::Atom.new("Li", [0.0, 1.0, 0.0])
    assert_equal(correct, result)

    result = @c00.atom_by_id('Li1-655')
    correct = CrystalCell::Atom.new("Li", [1.0, 0.0, 0.0])
    assert_equal(correct, result)

    result = @c00.atom_by_id('Li1-455')
    correct = CrystalCell::Atom.new("Li", [-1.0, 0.0, 0.0])
    assert_equal(correct, result)

  end

end

