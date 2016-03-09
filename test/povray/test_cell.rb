#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "povrayutils/povrayobject.rb"
#require "crystal/atom2.rb"

class TC_Povray_Sphere < Test::Unit::TestCase
  def setup
    @s00 = Mageo::Sphere.new( [ 1.0, 2.0, 3.0 ], 2.0)
  end

  def test_to_pov
    assert_equal( 
      "object { sphere{< 1.0000,  2.0000,  3.0000>,  2.0000} pigment {color rgb <0.30, 0.60, 0.90>} }",
      @s00.to_pov([0.3, 0.6, 0.9]) )
  end
end

class TC_Povray_Cylinder < Test::Unit::TestCase
  def setup
    @c00 = Mageo::Cylinder.new([[ 1.0, 2.0, 3.0 ], [4.0, 5.0, 6.0]], 2.0)
  end

  def test_to_pov
    assert_equal(
      "object { cylinder{ < 1.0000,  2.0000,  3.0000>, < 4.0000,  5.0000,  6.0000>,  2.0000 } pigment { color rgb <0.30, 0.60, 0.90> } }",
      @c00.to_pov([0.3, 0.6, 0.9]) )
  end
end

class TC_Povray_Triangle < Test::Unit::TestCase
  def setup
    @t00 = Mageo::Triangle.new(
      [[ 1.0, 2.0, 3.0 ], [4.0, 5.0, 6.0], [0.3, 0.6, 0.9 ]]
    )
  end

  def test_to_pov
    assert_equal(
      "polygon { 4, < 1.0000,  2.0000,  3.0000>, < 4.0000,  5.0000,  6.0000>, < 0.3000,  0.6000,  0.9000>, < 1.0000,  2.0000,  3.0000> pigment { color rgb <1, 0, 0> } }",
      @t00.to_pov([0.3, 0.6, 0.9])
    )
  end
end

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
    t = @c00.atoms_to_povs(0.01)
    corrects.each_with_index do |correct, index|
      assert_equal(correct, t[index], "line #{index.to_s}")
    end
    assert_equal(corrects.size, t.size)
  end

  def test_bonds_to_povs
    ## PeriodicCell.find_bonds に依存しており、
    ## これがなんか不安な動作。 -0.0000 になるとか、誤差だろうなあ。
    ## このためテストは頑張って作らない。
    ## PeriodicCell.find_bonds をリファクタリングとかしてから
    ## テストをするかもしれん。
    
    #assert_equal( [
    #	"object { cylinder{ < 0.0000,  0.0000,  0.0000>, < 0.4000,  0.6000,  0.8000>,  0.0500 } pigment { color rgb <0.75, 0.75, 0.75> } }"
    #	],
    #	@c00.bonds_to_povs(["Li", "O"], 0.0, 1.1)
    #)

    #assert_equal( [
    #	"object { cylinder{ < 0.0000,  0.0000,  0.0000>, < 0.4000,  0.6000,  0.8000>,  0.0500 } pigment { color rgb <0.75, 0.75, 0.75> } }"
    #	],
    #	@c00.bonds_to_povs(["O", "Li"], 0, 1.1 )
    #)

    #assert_equal([
    #	"object { cylinder{ < 0.0000,  0.0000,  0.0000>, < 0.0000,  0.0000,  0.0000>,  0.0500 } pigment { color rgb <0.75, 0.75, 0.75> } }"
    #	],
    #	@c00.bonds_to_povs(["Li", "Li"], 0, 2.0 )
    #)
  end

  def test_lattice_to_povs
    corrects = [
      "object { cylinder{ < 0.0000,  0.0000,  0.0000>, < 0.0000,  0.0000,  2.0000>,  0.1000 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 0.0000,  2.0000,  0.0000>, < 0.0000,  2.0000,  2.0000>,  0.1000 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 2.0000,  0.0000,  0.0000>, < 2.0000,  0.0000,  2.0000>,  0.1000 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 2.0000,  2.0000,  0.0000>, < 2.0000,  2.0000,  2.0000>,  0.1000 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 0.0000,  0.0000,  0.0000>, < 0.0000,  2.0000,  0.0000>,  0.1000 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 2.0000,  0.0000,  0.0000>, < 2.0000,  2.0000,  0.0000>,  0.1000 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 0.0000,  0.0000,  2.0000>, < 0.0000,  2.0000,  2.0000>,  0.1000 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 2.0000,  0.0000,  2.0000>, < 2.0000,  2.0000,  2.0000>,  0.1000 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 0.0000,  0.0000,  0.0000>, < 2.0000,  0.0000,  0.0000>,  0.1000 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 0.0000,  0.0000,  2.0000>, < 2.0000,  0.0000,  2.0000>,  0.1000 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 0.0000,  2.0000,  0.0000>, < 2.0000,  2.0000,  0.0000>,  0.1000 } pigment { color rgb <0.50, 0.50, 0.50> } }\n",
      "object { cylinder{ < 0.0000,  2.0000,  2.0000>, < 2.0000,  2.0000,  2.0000>,  0.1000 } pigment { color rgb <0.50, 0.50, 0.50> } }\n" ,
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
      #pp @c00
      @c00.atom_to_pov( CrystalCell::Atom.new("Li", [0.1, 0.2, 0.3]))
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

end
