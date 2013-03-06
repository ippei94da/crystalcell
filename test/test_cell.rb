#! /usr/bin/ruby1.9 -W

require 'test/unit'
require 'stringio'
require 'crystalcell/cell.rb'
require "rubygems"
#gem "mageo"
#require "mageo/vector3dinternal.rb"
require "mageo"

class FooCell < CrystalCell::Cell; end

class TC_Cell < Test::Unit::TestCase
  $tolerance = 10 ** (-10)

  def setup
    # 原子のないセル。
    vectors00 = [[2.0, 2.0, 2.0], [0.0, 2.0, 2.0], [0.0, 0.0, 2.0]]
    #@c00 = CrystalCell::Cell.new(vectors00)
    #
    axes00 = CrystalCell::LatticeAxes.new([[2.0, 2.0, 2.0], [0.0, 2.0, 2.0], [0.0, 0.0, 2.0]])
    @c00 = CrystalCell::Cell.new(axes00)
    @c00.comment = 'c00'

    # 元素の識別子を数字にしたもの。
    atoms = [
      CrystalCell::Atom.new( 0, [0.0, 0.0, 0.0] ),
      CrystalCell::Atom.new( 1, [0.1, 0.2, 0.3] ),
    ]
    @c01 = CrystalCell::Cell.new(axes00, atoms)
    @c01.comment = 'c01'

    # Li と O を1つずつ入れたセル。
    # @c02 = CrystalCell::Cell.new( [ [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0] ] )
    atoms = [
      CrystalCell::Atom.new( 'Li', [0.0, 0.0, 0.0] ),
      CrystalCell::Atom.new( 'O' , [0.2, 0.2, 0.2] ),
    ]
    @c02 = CrystalCell::Cell.new(vectors00, atoms)
    @c02.comment = 'c02'

    # 原子の順序を逆にしたもの。
    atoms = [
      CrystalCell::Atom.new( 'O' , [0.2, 0.2, 0.2] ),
      CrystalCell::Atom.new( 'Li', [0.0, 0.0, 0.0] ),
    ]
    @c03 = CrystalCell::Cell.new(vectors00, atoms)
    @c03.comment = 'c03'

    # 原子の順序がいりまじったもの
    atoms = [
      CrystalCell::Atom.new( 'Li', [0.0, 0.0, 0.0] ),
      CrystalCell::Atom.new( 'O' , [0.2, 0.2, 0.2] ),
      CrystalCell::Atom.new( 'Li', [0.1, 0.2, 0.3] ),
    ]
    @c04 = CrystalCell::Cell.new(vectors00, atoms)
    @c04.comment = 'c04'

    # 原子が不足しているもの。
    atoms = [
      CrystalCell::Atom.new( 'Li', [0.0, 0.0, 0.0] ),
    ]
    @c05 = CrystalCell::Cell.new(vectors00, atoms)
    @c05.comment = 'c05'

    # Selective dynamics をいれたもの。
    atoms = [
      CrystalCell::Atom.new( 'Li', [0.0, 0.0, 0.0], nil,  [true, false, false ] ),
      CrystalCell::Atom.new( 'O' , [0.2, 0.2, 0.2] ),
    ]
    @c06 = CrystalCell::Cell.new(vectors00, atoms)
    @c06.comment = 'c06'

    # 元素の識別子を数字にしたもの。
    atoms = [
      CrystalCell::Atom.new( 0, Vector3DInternal[0.0, 0.0, 0.0] ),
      CrystalCell::Atom.new( 1, Vector3DInternal[0.2, 0.2, 0.2] ),
    ]
    @c07 = CrystalCell::Cell.new(vectors00, atoms)
    @c07.comment = 'c07'

    # セル外の座標の原子を追加。
    atoms = [
      CrystalCell::Atom.new( 'Li', [ 1.2,  3.4,  5.6], "atom0", [ false, false, true] ),
      CrystalCell::Atom.new( 'O', [-1.2, -3.4, -5.6] ),
    ]
    @c08 = CrystalCell::Cell.new(vectors00, atoms)
    @c08.comment = 'c08'
  end

  def test_initialize
    la = CrystalCell::LatticeAxes.new( [ [2.0, 2.0, 2.0], [0.0, 2.0, 2.0], [0.0, 0.0, 2.0] ] )
    c10 = CrystalCell::Cell.new( la )
    c10.comment = 'c00'
    assert_equal( CrystalCell::Cell, c10.class )
    assert_in_delta( 2.0, c10.axes[0][0], $tolerance )
    assert_in_delta( 2.0, c10.axes[0][1], $tolerance )
    assert_in_delta( 2.0, c10.axes[0][2], $tolerance )
    assert_in_delta( 0.0, c10.axes[1][0], $tolerance )
    assert_in_delta( 2.0, c10.axes[1][1], $tolerance )
    assert_in_delta( 2.0, c10.axes[1][2], $tolerance )
    assert_in_delta( 0.0, c10.axes[2][0], $tolerance )
    assert_in_delta( 0.0, c10.axes[2][1], $tolerance )
    assert_in_delta( 2.0, c10.axes[2][2], $tolerance )


  end

  def test_positions
    assert_equal( [], @c00.positions)
    assert_equal( [ Vector3DInternal[0.0, 0.0, 0.0], Vector3DInternal[0.2, 0.2, 0.2] ], @c02.positions )
    assert_equal( [ Vector3DInternal[0.0, 0.0, 0.0], Vector3DInternal[0.1, 0.2, 0.3] ], @c01.positions )
  end

  def test_select_indices
    assert_equal( [], @c00.select_indices{ |i| i.element == "" } )
    assert_equal( [], @c00.select_indices{ |i| i.element == "Li" } )

    assert_equal( [] , @c01.select_indices{ |i| i.element == "" } )
    assert_equal( [] , @c01.select_indices{ |i| i.element == "Li" } )
    #@c01.select_indices{ |i| p i.element }
    assert_equal( [0], @c01.select_indices{ |i| i.element == 0 } )

    assert_equal( [1], @c01.select_indices{ |i| i.element == 1 } )

    assert_equal( [] , @c04.select_indices{ |i| i.element == "" } )
    assert_equal( [0, 2], @c04.select_indices{ |i| i.element == "Li" } )
    assert_equal( [1], @c04.select_indices{ |i| i.element == "O" } )
    assert_equal( [ ], @c04.select_indices{ |i| i.element == 0 } )
    assert_equal( [ ], @c04.select_indices{ |i| i.element == 1 } )

    assert_equal( [1, 2], @c04.select_indices{ |i| i.position[0] > 0.05 } )
  end

  def test_atoms_in_supercell
    t = @c02.atoms_in_supercell( 0, 0, 0, 0, 0, 1 )
    assert_equal( 'Li', t[0].element )
    assert_equal( 'Li', t[1].element )
    assert_equal( 'O' , t[2].element )
    assert_equal( 'O' , t[3].element )

    assert_equal( Vector3DInternal[0.0, 0.0, 0.0], t[0].position )
    assert_equal( Vector3DInternal[0.0, 0.0, 1.0], t[1].position )
    assert_equal( Vector3DInternal[0.2, 0.2, 0.2], t[2].position )
    assert_equal( Vector3DInternal[0.2, 0.2, 1.2], t[3].position )

    t = @c02.atoms_in_supercell(-1, 1,-1, 1,-1, 1 )
    assert_equal( ['Li']*27 + ['O'] * 27 , t.map{|i| i.element} )
    assert_equal( Vector3DInternal[-1.0, -1.0, -1.0], t[ 0].position )
    assert_equal( Vector3DInternal[-1.0, -1.0,  0.0], t[ 1].position )
    assert_equal( Vector3DInternal[-1.0, -1.0,  1.0], t[ 2].position )
    assert_equal( Vector3DInternal[-1.0,  0.0, -1.0], t[ 3].position )
    assert_equal( Vector3DInternal[-1.0,  0.0,  0.0], t[ 4].position )
    assert_equal( Vector3DInternal[-1.0,  0.0,  1.0], t[ 5].position )
    assert_equal( Vector3DInternal[-1.0,  1.0, -1.0], t[ 6].position )
    assert_equal( Vector3DInternal[-1.0,  1.0,  0.0], t[ 7].position )
    assert_equal( Vector3DInternal[-1.0,  1.0,  1.0], t[ 8].position )
    assert_equal( Vector3DInternal[ 0.0, -1.0, -1.0], t[ 9].position )
    assert_equal( Vector3DInternal[ 0.0, -1.0,  0.0], t[10].position )
    assert_equal( Vector3DInternal[ 0.0, -1.0,  1.0], t[11].position )
    assert_equal( Vector3DInternal[ 0.0,  0.0, -1.0], t[12].position )
    assert_equal( Vector3DInternal[ 0.0,  0.0,  0.0], t[13].position )
    assert_equal( Vector3DInternal[ 0.0,  0.0,  1.0], t[14].position )
    assert_equal( Vector3DInternal[ 0.0,  1.0, -1.0], t[15].position )
    assert_equal( Vector3DInternal[ 0.0,  1.0,  0.0], t[16].position )
    assert_equal( Vector3DInternal[ 0.0,  1.0,  1.0], t[17].position )
    assert_equal( Vector3DInternal[ 1.0, -1.0, -1.0], t[18].position )
    assert_equal( Vector3DInternal[ 1.0, -1.0,  0.0], t[19].position )
    assert_equal( Vector3DInternal[ 1.0, -1.0,  1.0], t[20].position )
    assert_equal( Vector3DInternal[ 1.0,  0.0, -1.0], t[21].position )
    assert_equal( Vector3DInternal[ 1.0,  0.0,  0.0], t[22].position )
    assert_equal( Vector3DInternal[ 1.0,  0.0,  1.0], t[23].position )
    assert_equal( Vector3DInternal[ 1.0,  1.0, -1.0], t[24].position )
    assert_equal( Vector3DInternal[ 1.0,  1.0,  0.0], t[25].position )
    assert_equal( Vector3DInternal[ 1.0,  1.0,  1.0], t[26].position )
    assert_equal( Vector3DInternal[-0.8, -0.8, -0.8], t[27].position )
    assert_equal( Vector3DInternal[-0.8, -0.8,  0.2], t[28].position )
    assert_equal( Vector3DInternal[-0.8, -0.8,  1.2], t[29].position )
    assert_equal( Vector3DInternal[-0.8,  0.2, -0.8], t[30].position )
    assert_equal( Vector3DInternal[-0.8,  0.2,  0.2], t[31].position )
    assert_equal( Vector3DInternal[-0.8,  0.2,  1.2], t[32].position )
    assert_equal( Vector3DInternal[-0.8,  1.2, -0.8], t[33].position )
    assert_equal( Vector3DInternal[-0.8,  1.2,  0.2], t[34].position )
    assert_equal( Vector3DInternal[-0.8,  1.2,  1.2], t[35].position )
    assert_equal( Vector3DInternal[ 0.2, -0.8, -0.8], t[36].position )
    assert_equal( Vector3DInternal[ 0.2, -0.8,  0.2], t[37].position )
    assert_equal( Vector3DInternal[ 0.2, -0.8,  1.2], t[38].position )
    assert_equal( Vector3DInternal[ 0.2,  0.2, -0.8], t[39].position )
    assert_equal( Vector3DInternal[ 0.2,  0.2,  0.2], t[40].position )
    assert_equal( Vector3DInternal[ 0.2,  0.2,  1.2], t[41].position )
    assert_equal( Vector3DInternal[ 0.2,  1.2, -0.8], t[42].position )
    assert_equal( Vector3DInternal[ 0.2,  1.2,  0.2], t[43].position )
    assert_equal( Vector3DInternal[ 0.2,  1.2,  1.2], t[44].position )
    assert_equal( Vector3DInternal[ 1.2, -0.8, -0.8], t[45].position )
    assert_equal( Vector3DInternal[ 1.2, -0.8,  0.2], t[46].position )
    assert_equal( Vector3DInternal[ 1.2, -0.8,  1.2], t[47].position )
    assert_equal( Vector3DInternal[ 1.2,  0.2, -0.8], t[48].position )
    assert_equal( Vector3DInternal[ 1.2,  0.2,  0.2], t[49].position )
    assert_equal( Vector3DInternal[ 1.2,  0.2,  1.2], t[50].position )
    assert_equal( Vector3DInternal[ 1.2,  1.2, -0.8], t[51].position )
    assert_equal( Vector3DInternal[ 1.2,  1.2,  0.2], t[52].position )
    assert_equal( Vector3DInternal[ 1.2,  1.2,  1.2], t[53].position )
  end

  def test_elements
    assert_equal( [], @c00.elements)
    assert_equal( [ 'Li', 'O' ], @c02.elements )
    assert_equal( [ 0, 1 ], @c01.elements )
  end

  def test_add_atom
    assert_raise(ArgumentError){
      @c00.add_atom('Li', [0.5, 0.5, 0.5] )
    }

    @c00.add_atom(CrystalCell::Atom.new( 'Li', [0.5, 0.5, 0.5] ))
    assert_equal( 1              , @c00.atoms.size)
    assert_equal( 'Li'           , @c00.atoms[0].element)
    assert_equal( Vector3DInternal[0.5, 0.5, 0.5], @c00.atoms[0].position)
    assert_equal( nil            , @c00.atoms[0].name )

    @c00.add_atom(CrystalCell::Atom.new( nil , [0.5, 0.5, 0.5], 'A' ))
    assert_equal( 2              , @c00.atoms.size)
    assert_equal( nil            , @c00.atoms[1].element)
    assert_equal( Vector3DInternal[0.5, 0.5, 0.5], @c00.atoms[1].position)
    assert_equal( 'A'            , @c00.atoms[1].name )

    @c02.add_atom(CrystalCell::Atom.new( 'Li', [0.5, 0.5, 0.5] ))
    assert_equal( 3              , @c02.atoms.size)
    assert_equal( 'Li'           , @c02.atoms[0].element)
    assert_equal( Vector3DInternal[0.0, 0.0, 0.0], @c02.atoms[0].position)
    assert_equal( 'O'            , @c02.atoms[1].element)
    assert_equal( Vector3DInternal[0.2, 0.2, 0.2], @c02.atoms[1].position)
    assert_equal( 'Li'           , @c02.atoms[2].element)
    assert_equal( Vector3DInternal[0.5, 0.5, 0.5], @c02.atoms[2].position)

    @c01.add_atom(CrystalCell::Atom.new( 'Li', [0.5, 0.5, 0.5] ))
    assert_equal( 3              , @c01.atoms.size)
    assert_equal( 0              , @c01.atoms[0].element)
    assert_equal( Vector3DInternal[0.0, 0.0, 0.0], @c01.atoms[0].position)
    assert_equal( 1              , @c01.atoms[1].element)
    assert_equal( Vector3DInternal[0.1, 0.2, 0.3], @c01.atoms[1].position)
    assert_equal( 'Li'           , @c01.atoms[2].element)
    assert_equal( Vector3DInternal[0.5, 0.5, 0.5], @c01.atoms[2].position)

  end

  def test_delete_atom
    # assert_raise(RuntimeError ) {@c00.delete_atom( 0 ) }
    assert_equal(nil, @c00.delete_atom( 0 ) )
    assert_equal([], @c00.positions )
    assert_equal([], @c00.elements )

    @c02.delete_atom( 0 )
    assert_equal( [ Vector3DInternal[0.2, 0.2, 0.2] ], @c02.positions)
    assert_equal( [ 'O' ], @c02.elements )
    @c02.delete_atom( 0 )
    assert_equal( [], @c02.positions)
    assert_equal( [], @c02.elements )

    @c01.delete_atom( 0 )
    assert_equal( [ Vector3DInternal[0.1, 0.2, 0.3] ], @c01.positions)
    assert_equal( [ 1 ], @c01.elements )
  end

  def test_set_elements
    # 原子がないので変更されない。
    @c00.set_elements( [] )
    assert_equal( [], @c00.atoms )

    # 0 -> 'Li、 1 -> 'O' に変更。
    tmp = Marshal.load( Marshal.dump( @c01 ))
    tmp.set_elements( [ 'Li', 'O' ] )
    assert_equal( 'Li', tmp.atoms[0].element )
    assert_equal( 'O',  tmp.atoms[1].element )

    # 0 -> 'Li, 片方だけ変更。
    tmp = Marshal.load( Marshal.dump( @c01 ))
    tmp.set_elements( [ 'Li' ] )
    assert_equal( 'Li', tmp.atoms[0].element )
    assert_equal( 1,  tmp.atoms[1].element )

    # 元々整数値以外にセットされているのでマッチせず変更されない。
    tmp = Marshal.load( Marshal.dump( @c02 ))
    tmp.set_elements( [ 'O', 'Li' ] )
    assert_equal( 'Li', tmp.atoms[0].element )
    assert_equal( 'O',  tmp.atoms[1].element )

    # Hash argument.
    # 0 -> 'Li、 1 -> 'O' に変更。
    tmp = Marshal.load( Marshal.dump( @c01 ))
    tmp.set_elements( { 0 => 'Li', 1 => 'O' } )
    assert_equal( 'Li', tmp.atoms[0].element )
    assert_equal( 'O',  tmp.atoms[1].element )

    # 'Li' -> 'Na', 'O' -> 'S' に変更。
    tmp = Marshal.load( Marshal.dump( @c02 ))
    tmp.set_elements( { 'Li' => 'Na', 'O' => 'S' } )
    assert_equal( 'Na', tmp.atoms[0].element )
    assert_equal( 'S',  tmp.atoms[1].element )

    # 'Li' -> 'Na'、 片方だけ変更。
    tmp = Marshal.load( Marshal.dump( @c02 ))
    tmp.set_elements( { 'Li' => 'Na' } )
    assert_equal( 'Na', tmp.atoms[0].element )
    assert_equal( 'O',  tmp.atoms[1].element )
  end

  def test_equal_lattice_in_delta?
    assert_equal( true , @c00.equal_lattice_in_delta?(@c00, 0.001, 0.1) )
    assert_equal( true , @c00.equal_lattice_in_delta?(@c02, 0.001, 0.1) )
    assert_equal( true , @c00.equal_lattice_in_delta?(@c01, 0.001, 0.1) )
    assert_equal( true , @c02.equal_lattice_in_delta?(@c00, 0.001, 0.1) )
    assert_equal( true , @c02.equal_lattice_in_delta?(@c02, 0.001, 0.1) )
    assert_equal( true , @c02.equal_lattice_in_delta?(@c01, 0.001, 0.1) )
    assert_equal( true , @c01.equal_lattice_in_delta?(@c00, 0.001, 0.1) )
    assert_equal( true , @c01.equal_lattice_in_delta?(@c02, 0.001, 0.1) )
    assert_equal( true , @c01.equal_lattice_in_delta?(@c01, 0.001, 0.1) )

  end

  def test_equal_atoms_in_delta?
    assert_equal( true , @c00.equal_atoms_in_delta?( @c00, 0.01 ) )
    assert_equal( false, @c00.equal_atoms_in_delta?( @c02, 0.01 ) )
    assert_equal( false, @c00.equal_atoms_in_delta?( @c01, 0.01 ) )
    assert_equal( false, @c00.equal_atoms_in_delta?( @c03, 0.01 ) )
    assert_equal( false, @c00.equal_atoms_in_delta?( @c04, 0.01 ) )
    assert_equal( false, @c00.equal_atoms_in_delta?( @c05, 0.01 ) )
    assert_equal( false, @c02.equal_atoms_in_delta?( @c00, 0.01 ) )
    assert_equal( true , @c02.equal_atoms_in_delta?( @c02, 0.01 ) )
    assert_equal( false, @c02.equal_atoms_in_delta?( @c01, 0.01 ) )
    assert_equal( true , @c02.equal_atoms_in_delta?( @c03, 0.01 ) )
    assert_equal( false, @c02.equal_atoms_in_delta?( @c04, 0.01 ) )
    assert_equal( false, @c02.equal_atoms_in_delta?( @c05, 0.01 ) )
    assert_equal( false, @c01.equal_atoms_in_delta?( @c00, 0.01 ) )
    assert_equal( false, @c01.equal_atoms_in_delta?( @c02, 0.01 ) )
    assert_equal( true , @c01.equal_atoms_in_delta?( @c01, 0.01 ) )
    assert_equal( false, @c01.equal_atoms_in_delta?( @c03, 0.01 ) )
    assert_equal( false, @c01.equal_atoms_in_delta?( @c04, 0.01 ) )
    assert_equal( false, @c01.equal_atoms_in_delta?( @c05, 0.01 ) )
    assert_equal( false, @c03.equal_atoms_in_delta?( @c00, 0.01 ) )
    assert_equal( true , @c03.equal_atoms_in_delta?( @c02, 0.01 ) )
    assert_equal( false, @c03.equal_atoms_in_delta?( @c01, 0.01 ) )
    assert_equal( true , @c03.equal_atoms_in_delta?( @c03, 0.01 ) )
    assert_equal( false, @c03.equal_atoms_in_delta?( @c04, 0.01 ) )
    assert_equal( false, @c03.equal_atoms_in_delta?( @c05, 0.01 ) )
    assert_equal( false, @c04.equal_atoms_in_delta?( @c00, 0.01 ) )
    assert_equal( false, @c04.equal_atoms_in_delta?( @c02, 0.01 ) )
    assert_equal( false, @c04.equal_atoms_in_delta?( @c01, 0.01 ) )
    assert_equal( false, @c04.equal_atoms_in_delta?( @c03, 0.01 ) )
    assert_equal( true , @c04.equal_atoms_in_delta?( @c04, 0.01 ) )
    assert_equal( false, @c04.equal_atoms_in_delta?( @c05, 0.01 ) )
    assert_equal( false, @c05.equal_atoms_in_delta?( @c00, 0.01 ) )
    assert_equal( false, @c05.equal_atoms_in_delta?( @c02, 0.01 ) )
    assert_equal( false, @c05.equal_atoms_in_delta?( @c01, 0.01 ) )
    assert_equal( false, @c05.equal_atoms_in_delta?( @c03, 0.01 ) )
    assert_equal( false, @c05.equal_atoms_in_delta?( @c04, 0.01 ) )
    assert_equal( true , @c05.equal_atoms_in_delta?( @c05, 0.01 ) )
  end

  def test_equal_in_delta?
    assert_equal(true , @c00.equal_in_delta?( @c00, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c00.equal_in_delta?( @c01, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c00.equal_in_delta?( @c02, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c00.equal_in_delta?( @c03, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c00.equal_in_delta?( @c04, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c00.equal_in_delta?( @c05, 0.001, 0.1, 0.01 ) )

    assert_equal(false, @c02.equal_in_delta?( @c00, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c02.equal_in_delta?( @c01, 0.001, 0.1, 0.01 ) )
    assert_equal(true , @c02.equal_in_delta?( @c02, 0.001, 0.1, 0.01 ) )
    assert_equal(true , @c02.equal_in_delta?( @c03, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c02.equal_in_delta?( @c04, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c02.equal_in_delta?( @c05, 0.001, 0.1, 0.01 ) )

    assert_equal(false, @c01.equal_in_delta?( @c00, 0.001, 0.1, 0.01 ) )
    assert_equal(true , @c01.equal_in_delta?( @c01, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c01.equal_in_delta?( @c02, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c01.equal_in_delta?( @c03, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c01.equal_in_delta?( @c04, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c01.equal_in_delta?( @c05, 0.001, 0.1, 0.01 ) )

    assert_equal(false, @c03.equal_in_delta?( @c00, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c03.equal_in_delta?( @c01, 0.001, 0.1, 0.01 ) )
    assert_equal(true , @c03.equal_in_delta?( @c02, 0.001, 0.1, 0.01 ) )
    assert_equal(true , @c03.equal_in_delta?( @c03, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c03.equal_in_delta?( @c04, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c03.equal_in_delta?( @c05, 0.001, 0.1, 0.01 ) )

    assert_equal(false, @c04.equal_in_delta?( @c00, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c04.equal_in_delta?( @c01, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c04.equal_in_delta?( @c02, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c04.equal_in_delta?( @c03, 0.001, 0.1, 0.01 ) )
    assert_equal(true , @c04.equal_in_delta?( @c04, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c04.equal_in_delta?( @c05, 0.001, 0.1, 0.01 ) )

    assert_equal(false, @c05.equal_in_delta?( @c00, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c05.equal_in_delta?( @c01, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c05.equal_in_delta?( @c02, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c05.equal_in_delta?( @c03, 0.001, 0.1, 0.01 ) )
    assert_equal(false, @c05.equal_in_delta?( @c04, 0.001, 0.1, 0.01 ) )
    assert_equal(true , @c05.equal_in_delta?( @c05, 0.001, 0.1, 0.01 ) )
  end

  def test_equal
    cell = CrystalCell::Cell.new( CrystalCell::LatticeAxes.new([ [2.0, 2.0, 2.0], [0.0, 2.0, 2.0], [0.0, 0.0, 2.0]]))
    assert_equal( true , @c00 == cell )
    assert_equal( false, @c01 == cell )
    
    cell = CrystalCell::Cell.new( CrystalCell::LatticeAxes.new([ [2.0, 2.0, 2.0], [0.0, 2.0, 2.0], [0.0, 0.0, 2.0]]))
    cell.add_atom(CrystalCell::Atom.new( 0, [0.0, 0.0, 0.0] ))
    cell.add_atom(CrystalCell::Atom.new( 1, [0.1, 0.2, 0.3] ))
    assert_equal( false, @c00 == cell )
    assert_equal( true , @c01 == cell )
  end

  def test_distance
    assert_raise(CrystalCell::Cell::TypeError){@c00.distance([0,0,0], [1,1,1])}
    assert_raise(CrystalCell::Cell::TypeError){@c00.distance([0,0,0], Vector3DInternal[1,1,1])}
    assert_raise(CrystalCell::Cell::TypeError){@c00.distance([0,0,0], Vector3D[1,1,1])}

    assert_in_delta(
      Math::sqrt(0.56),
      @c00.distance(Vector3DInternal[0.0, 0.0, 0.0], Vector3DInternal[0.1, 0.1, 0.1] ),
      $tolerance
    )
    assert_in_delta( Math::sqrt( 1.6**2 + 3.4**2 + 5.4**2),
      @c00.distance( Vector3DInternal[0.0, 0.0, 0.0], Vector3DInternal[0.8, 0.9, 1.0] ), $tolerance
    )

    assert_in_delta( Math::sqrt(0.56), @c00.distance( Vector3DInternal[0.0, 0.0, 0.0], Vector3DInternal[0.1, 0.1, 0.1] ), $tolerance )
    assert_in_delta( Math::sqrt( 1.6**2 + 3.4**2 + 5.4**2),
      @c00.distance( Vector3DInternal[0.0, 0.0, 0.0], Vector3DInternal[0.8, 0.9, 1.0] ), $tolerance
    )
  end

  def test_dump_poscar
    c00_str = [
      'c00',
      '1.0',
      '    2.00000000000000      2.00000000000000      2.00000000000000',
      '    0.00000000000000      2.00000000000000      2.00000000000000',
      '    0.00000000000000      0.00000000000000      2.00000000000000',
      '',
      'Direct'
    ].join("\n")

    c02_str = [
      'c02',
      '1.0',
      '    2.00000000000000      2.00000000000000      2.00000000000000',
      '    0.00000000000000      2.00000000000000      2.00000000000000',
      '    0.00000000000000      0.00000000000000      2.00000000000000',
      '  1  1',
      'Direct',
      '    0.00000000000000      0.00000000000000      0.00000000000000',
      '    0.20000000000000      0.20000000000000      0.20000000000000'
    ].join("\n")

    c01_str = [
      'c01',
      '1.0',
      '    2.00000000000000      2.00000000000000      2.00000000000000',
      '    0.00000000000000      2.00000000000000      2.00000000000000',
      '    0.00000000000000      0.00000000000000      2.00000000000000',
      '  1  1',
      'Direct',
      '    0.00000000000000      0.00000000000000      0.00000000000000',
      '    0.10000000000000      0.20000000000000      0.30000000000000'
    ].join("\n")

    c03_str = [
      'c03',
      '1.0',
      '    2.00000000000000      2.00000000000000      2.00000000000000',
      '    0.00000000000000      2.00000000000000      2.00000000000000',
      '    0.00000000000000      0.00000000000000      2.00000000000000',
      '  1  1',
      'Direct',
      '    0.00000000000000      0.00000000000000      0.00000000000000',
      '    0.20000000000000      0.20000000000000      0.20000000000000'
    ].join("\n")

    c04_str = [
      'c04',
      '1.0',
      '    2.00000000000000      2.00000000000000      2.00000000000000',
      '    0.00000000000000      2.00000000000000      2.00000000000000',
      '    0.00000000000000      0.00000000000000      2.00000000000000',
      '  2  1',
      'Direct',
      '    0.00000000000000      0.00000000000000      0.00000000000000',
      '    0.10000000000000      0.20000000000000      0.30000000000000',
      '    0.20000000000000      0.20000000000000      0.20000000000000'
    ].join("\n")

    c05_str = [
      'c05',
      '1.0',
      '    2.00000000000000      2.00000000000000      2.00000000000000',
      '    0.00000000000000      2.00000000000000      2.00000000000000',
      '    0.00000000000000      0.00000000000000      2.00000000000000',
      '  1',
      'Direct',
      '    0.00000000000000      0.00000000000000      0.00000000000000'
    ].join("\n")

    c06_str = [
      'c06',
      '1.0',
      '    2.00000000000000      2.00000000000000      2.00000000000000',
      '    0.00000000000000      2.00000000000000      2.00000000000000',
      '    0.00000000000000      0.00000000000000      2.00000000000000',
      '  1  1',
      'Selective dynamics',
      'Direct',
      '    0.00000000000000      0.00000000000000      0.00000000000000 T F F',
      '    0.20000000000000      0.20000000000000      0.20000000000000 T T T'
    ].join("\n")

    # Raise exception
      # assert_raise( RuntimeError ){ @c00.dump_poscar( [], io ) }
      assert_raise( RuntimeError ){ @c00.dump_poscar( [0]         ) }
      assert_raise( RuntimeError ){ @c00.dump_poscar( [0, 1]      ) }
      assert_raise( RuntimeError ){ @c00.dump_poscar( ['Li']      ) }
      assert_raise( RuntimeError ){ @c00.dump_poscar( ['Li', 'O'] ) }
      assert_raise( RuntimeError ){ @c02.dump_poscar( []          ) }
      assert_raise( RuntimeError ){ @c02.dump_poscar( [0]         ) }
      assert_raise( RuntimeError ){ @c02.dump_poscar( [0, 1]      ) }
      assert_raise( RuntimeError ){ @c02.dump_poscar( ['Li']      ) }
      assert_raise( RuntimeError ){ @c01.dump_poscar( []          ) }
      assert_raise( RuntimeError ){ @c01.dump_poscar( [0]         ) }
      assert_raise( RuntimeError ){ @c01.dump_poscar( ['Li']      ) }
      assert_raise( RuntimeError ){ @c01.dump_poscar( ['Li', 'O'] ) }
      assert_raise( RuntimeError ){ @c04.dump_poscar( []          ) }
      assert_raise( RuntimeError ){ @c04.dump_poscar( [0]         ) }
      assert_raise( RuntimeError ){ @c04.dump_poscar( [0, 1]      ) }
      assert_raise( RuntimeError ){ @c04.dump_poscar( ['Li']      ) }
      assert_raise( RuntimeError ){ @c05.dump_poscar( []          ) }
      assert_raise( RuntimeError ){ @c05.dump_poscar( [0]         ) }
      assert_raise( RuntimeError ){ @c05.dump_poscar( [0, 1]      ) }
      assert_raise( RuntimeError ){ @c05.dump_poscar( ['Li', 'O'] ) }
      assert_raise( RuntimeError ){ @c03.dump_poscar( []          ) }
      assert_raise( RuntimeError ){ @c03.dump_poscar( [0]         ) }
      assert_raise( RuntimeError ){ @c03.dump_poscar( [0, 1]      ) }
      assert_raise( RuntimeError ){ @c03.dump_poscar( ['Li']      ) }

    #
    StringIO.new do |io|
      @c00.dump_poscar( [], io ) 
      assert_equal( c00_str, io.read )
    end

    StringIO.new do |io|
      @c02.dump_poscar( [ 'Li', 'O' ], io ) 
      assert_equal( c02, io.read )
    end

    StringIO.new do |io|
      @c01.dump_poscar( [ 0, 1 ], io ) 
      assert_equal( c01, io.read )
    end

    StringIO.new do |io|
      @c03.dump_poscar( [ 'Li', 'O' ], io ) 
      assert_equal( c03, io.read )
    end

    StringIO.new do |io|
      @c04.dump_poscar( [ 'Li', 'O' ], io ) 
      assert_equal( c04, io.read )
    end

    StringIO.new do |io|
      @c05.dump_poscar( [ 'Li', 'O' ], io ) 
      assert_equal( c05, io.read )
    end

    assert_equal( c00_str, @c00.dump_poscar( [           ], nil ) )
    assert_equal( c01_str, @c01.dump_poscar( [ 0   , 1   ], nil ) )
    assert_equal( c02_str, @c02.dump_poscar( [ 'Li', 'O' ], nil ) )
    assert_equal( c03_str, @c03.dump_poscar( [ 'Li', 'O' ], nil ) )
    assert_equal( c04_str, @c04.dump_poscar( [ 'Li', 'O' ], nil ) )
    assert_equal( c05_str, @c05.dump_poscar( [ 'Li'      ], nil ) )

    assert_equal( c00_str, @c00.dump_poscar( [           ] ) )
    assert_equal( c01_str, @c01.dump_poscar( [ 0   , 1   ] ) )
    assert_equal( c02_str, @c02.dump_poscar( [ 'Li', 'O' ] ) )
    assert_equal( c03_str, @c03.dump_poscar( [ 'Li', 'O' ] ) )
    assert_equal( c04_str, @c04.dump_poscar( [ 'Li', 'O' ] ) )
    assert_equal( c05_str, @c05.dump_poscar( [ 'Li'      ] ) )

    assert_equal( c06_str, @c06 .dump_poscar( [ 'Li', 'O' ] ) )

  end

  def test_rotate
    @c02.add_atom(CrystalCell::Atom.new( 'Li', [1.1, 1.2, 1.3] ))
    assert_equal(
      [ Vector3DInternal[  0.0,  0.0,  0.0 ],
        Vector3DInternal[ -0.2, -0.2, -0.2 ],
        Vector3DInternal[ -1.1, -1.2, -1.3 ]
      ],
      @c02.rotate( [[-1, 0, 0],[0, -1, 0],[0, 0, -1]] ).positions
    )

    # Check not destructed.
    assert_equal(
      [ Vector3DInternal[ 0.0, 0.0, 0.0 ],
        Vector3DInternal[ 0.2, 0.2, 0.2 ],
        Vector3DInternal[ 1.1, 1.2, 1.3 ]
      ],
      @c02.positions
    )
  end

  def test_rotate!
    @c02.add_atom(CrystalCell::Atom.new( 'Li', [0.1, 0.2, 0.3] ))
    @c02.rotate!( [[-1, 0, 0],[0, -1, 0],[0, 0, -1]] )
    assert_equal(
      [ Vector3DInternal[  0.0,  0.0,  0.0 ],
        Vector3DInternal[ -0.2, -0.2, -0.2 ],
        Vector3DInternal[ -0.1, -0.2, -0.3 ]
      ],
      @c02.positions
    )
  end

  def test_translate
    poss = @c02.translate( [1.1, 1.2, 1.3] ).positions
    assert_in_delta( 1.1, poss[0][0], $tolerance )
    assert_in_delta( 1.2, poss[0][1], $tolerance )
    assert_in_delta( 1.3, poss[0][2], $tolerance )
    assert_in_delta( 1.3, poss[1][0], $tolerance )
    assert_in_delta( 1.4, poss[1][1], $tolerance )
    assert_in_delta( 1.5, poss[1][2], $tolerance )

    poss = @c02.translate( [-0.3,-0.3,-0.3] ).positions
    assert_in_delta( -0.3, poss[0][0], $tolerance )
    assert_in_delta( -0.3, poss[0][1], $tolerance )
    assert_in_delta( -0.3, poss[0][2], $tolerance )
    assert_in_delta( -0.1, poss[1][0], $tolerance )
    assert_in_delta( -0.1, poss[1][1], $tolerance )
    assert_in_delta( -0.1, poss[1][2], $tolerance )

    # Check not destructed.
    assert_equal(
      [ Vector3DInternal[ 0.0, 0.0, 0.0 ],
        Vector3DInternal[ 0.2, 0.2, 0.2 ]
      ],
      @c02.positions
    )
  end

  def test_translate!
    @c02.translate!( [1.1, 1.2, 1.3] )
    poss = @c02.positions

    assert_in_delta( 1.1, poss[0][0], $tolerance )
    assert_in_delta( 1.2, poss[0][1], $tolerance )
    assert_in_delta( 1.3, poss[0][2], $tolerance )
    assert_in_delta( 1.3, poss[1][0], $tolerance )
    assert_in_delta( 1.4, poss[1][1], $tolerance )
    assert_in_delta( 1.5, poss[1][2], $tolerance )
  end

  def test_center_of_atoms
    # No atom in the cell.
    assert_raise( CrystalCell::Cell::NoAtomError ){ @c00.center_of_atoms }

    assert_equal( Vector3DInternal[0.05, 0.1, 0.15], @c01.center_of_atoms )
    assert_equal( Vector3DInternal[0.1, 0.1, 0.1], @c02.center_of_atoms )
    assert_equal( Vector3DInternal[0.1, 0.1, 0.1], @c03.center_of_atoms )
    assert_equal( Vector3DInternal[0.1, 4.0/30.0, 5.0/30.0], @c04.center_of_atoms )
    assert_equal( Vector3DInternal[0.0, 0.0, 0.0], @c05.center_of_atoms )
    assert_equal( Vector3DInternal[0.1, 0.1, 0.1], @c06.center_of_atoms )
    assert_equal( Vector3DInternal[0.1, 0.1, 0.1], @c07.center_of_atoms )
  end

  def test_calc_volume
    # @c00 = CrystalCell::Cell.new( [ [2.0, 2.0, 2.0], [0.0, 2.0, 2.0], [0.0, 0.0, 2.0] ] )
    assert_in_delta( 8.00, @c00.calc_volume, $tolerance)

    c10 = CrystalCell::Cell.new( [ [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0] ] )
    c11 = CrystalCell::Cell.new( [ [0.5, 0.5, 0.0], [0.5, 0.0, 0.5], [0.0, 0.5, 0.5] ] )
    assert_in_delta( 1.00, c10.calc_volume, $tolerance)
    assert_in_delta( 0.25, c11.calc_volume, $tolerance)
  end

  def test_cell_of_elements
    t = @c04.cell_of_elements( [ 'Li' ] )
    assert_equal( CrystalCell::Cell, t.class )
    assert_in_delta( 2.0, t.axes[0][0], $tolerance )
    assert_in_delta( 2.0, t.axes[0][1], $tolerance )
    assert_in_delta( 2.0, t.axes[0][2], $tolerance )
    assert_in_delta( 0.0, t.axes[1][0], $tolerance )
    assert_in_delta( 2.0, t.axes[1][1], $tolerance )
    assert_in_delta( 2.0, t.axes[1][2], $tolerance )
    assert_in_delta( 0.0, t.axes[2][0], $tolerance )
    assert_in_delta( 0.0, t.axes[2][1], $tolerance )
    assert_in_delta( 2.0, t.axes[2][2], $tolerance )
    assert_equal( 2, t.atoms.size )
    # checking atom 0
    assert_equal( 'Li'           , t.atoms[0].element)
    assert_equal( Vector3DInternal[0.0, 0.0, 0.0], t.atoms[0].position)
    assert_equal( nil            , t.atoms[0].name )
    # checking atom 1
    assert_equal( 'Li'           , t.atoms[1].element)
    assert_equal( Vector3DInternal[0.1, 0.2, 0.3], t.atoms[1].position)
    assert_equal( nil            , t.atoms[1].name )

    t = @c04.cell_of_elements( [ 'Li', 'O' ] )
    assert_equal( CrystalCell::Cell, t.class )
    assert_in_delta( 2.0, t.axes[0][0], $tolerance )
    assert_in_delta( 2.0, t.axes[0][1], $tolerance )
    assert_in_delta( 2.0, t.axes[0][2], $tolerance )
    assert_in_delta( 0.0, t.axes[1][0], $tolerance )
    assert_in_delta( 2.0, t.axes[1][1], $tolerance )
    assert_in_delta( 2.0, t.axes[1][2], $tolerance )
    assert_in_delta( 0.0, t.axes[2][0], $tolerance )
    assert_in_delta( 0.0, t.axes[2][1], $tolerance )
    assert_in_delta( 2.0, t.axes[2][2], $tolerance )
    assert_equal( 3, t.atoms.size )
    # checking atom 0
    assert_equal( 'Li'           , t.atoms[0].element)
    assert_equal( Vector3DInternal[0.0, 0.0, 0.0], t.atoms[0].position)
    assert_equal( nil            , t.atoms[0].name )
    # checking atom 1
    assert_equal( 'O'           , t.atoms[1].element)
    assert_equal( Vector3DInternal[0.2, 0.2, 0.2], t.atoms[1].position)
    assert_equal( nil            , t.atoms[1].name )
    # checking atom 2
    assert_equal( 'Li'           , t.atoms[2].element)
    assert_equal( Vector3DInternal[0.1, 0.2, 0.3], t.atoms[2].position)
    assert_equal( nil            , t.atoms[2].name )

    t = @c04.cell_of_elements( [ 'O' ] )
    assert_equal( CrystalCell::Cell, t.class )
    assert_in_delta( 2.0, t.axes[0][0], $tolerance )
    assert_in_delta( 2.0, t.axes[0][1], $tolerance )
    assert_in_delta( 2.0, t.axes[0][2], $tolerance )
    assert_in_delta( 0.0, t.axes[1][0], $tolerance )
    assert_in_delta( 2.0, t.axes[1][1], $tolerance )
    assert_in_delta( 2.0, t.axes[1][2], $tolerance )
    assert_in_delta( 0.0, t.axes[2][0], $tolerance )
    assert_in_delta( 0.0, t.axes[2][1], $tolerance )
    assert_in_delta( 2.0, t.axes[2][2], $tolerance )
    assert_equal( 1, t.atoms.size )
    # checking atom 0
    assert_equal( 'O'           , t.atoms[0].element)
    assert_equal( Vector3DInternal[0.2, 0.2, 0.2], t.atoms[0].position)
    assert_equal( nil            , t.atoms[0].name )

    t = @c04.cell_of_elements( [ 'F' ] )
    assert_equal( CrystalCell::Cell, t.class )
    assert_in_delta( 2.0, t.axes[0][0], $tolerance )
    assert_in_delta( 2.0, t.axes[0][1], $tolerance )
    assert_in_delta( 2.0, t.axes[0][2], $tolerance )
    assert_in_delta( 0.0, t.axes[1][0], $tolerance )
    assert_in_delta( 2.0, t.axes[1][1], $tolerance )
    assert_in_delta( 2.0, t.axes[1][2], $tolerance )
    assert_in_delta( 0.0, t.axes[2][0], $tolerance )
    assert_in_delta( 0.0, t.axes[2][1], $tolerance )
    assert_in_delta( 2.0, t.axes[2][2], $tolerance )
    assert_equal( 0, t.atoms.size )


    # サブクラスで使用したときに、サブクラスで作られるか？
    fc04 = FooCell.new( [ [2.0, 2.0, 2.0], [0.0, 2.0, 2.0], [0.0, 0.0, 2.0] ] )
    fc04.add_atom(CrystalCell::Atom.new( 'Li', [0.0, 0.0, 0.0] ))
    fc04.add_atom(CrystalCell::Atom.new( 'O' , [0.2, 0.2, 0.2] ))
    fc04.add_atom(CrystalCell::Atom.new( 'Li', [0.1, 0.2, 0.3] ))
    fc04.comment = 'fc04'
    t = fc04.cell_of_elements( [ 'Li' ] )
    assert_equal( FooCell, t.class )
    assert_in_delta( 2.0, t.axes[0][0], $tolerance )
    assert_in_delta( 2.0, t.axes[0][1], $tolerance )
    assert_in_delta( 2.0, t.axes[0][2], $tolerance )
    assert_in_delta( 0.0, t.axes[1][0], $tolerance )
    assert_in_delta( 2.0, t.axes[1][1], $tolerance )
    assert_in_delta( 2.0, t.axes[1][2], $tolerance )
    assert_in_delta( 0.0, t.axes[2][0], $tolerance )
    assert_in_delta( 0.0, t.axes[2][1], $tolerance )
    assert_in_delta( 2.0, t.axes[2][2], $tolerance )
    assert_equal( 2, t.atoms.size )
    # checking atom 0
    assert_equal( 'Li'           , t.atoms[0].element)
    assert_equal( Vector3DInternal[0.0, 0.0, 0.0], t.atoms[0].position)
    assert_equal( nil            , t.atoms[0].name )
    # checking atom 1
    assert_equal( 'Li'           , t.atoms[1].element)
    assert_equal( Vector3DInternal[0.1, 0.2, 0.3], t.atoms[1].position)
    assert_equal( nil            , t.atoms[1].name )
  end

  def test_unite
    ## 格子定数が違えば例外。将来的な feature.
    #t = CrystalCell::Cell.new( [ [2.0, 0.0, 0.0], [0.0, 2.0, 0.0], [0.0, 0.0, 2.0] ] )
    #t.add_atom(CrystalCell::Atom.new( 'Li', [0.0, 0.0, 0.0] ))
    #t.comment = 't'
    #assert_raise( CrystalCell::Cell::AxesMismatchError ){ @c05.unite( t ) }
    t = CrystalCell::Cell.new( [ [2.0, 0.0, 0.0], [0.0, 2.0, 0.0], [0.0, 0.0, 2.0] ] )
    t.add_atom(CrystalCell::Atom.new( 'Li', [0.0, 0.0, 0.0] ))
    t.comment = 't'
    assert_nothing_raised{ @c05.unite( t ) }

    # unite
    # 同じ座標のものがあっても気にせず統合する。
    t = @c05.unite( @c06 )
    assert_equal( CrystalCell::Cell, t.class )
    assert_in_delta( 2.0, t.axes[0][0], $tolerance )
    assert_in_delta( 2.0, t.axes[0][1], $tolerance )
    assert_in_delta( 2.0, t.axes[0][2], $tolerance )
    assert_in_delta( 0.0, t.axes[1][0], $tolerance )
    assert_in_delta( 2.0, t.axes[1][1], $tolerance )
    assert_in_delta( 2.0, t.axes[1][2], $tolerance )
    assert_in_delta( 0.0, t.axes[2][0], $tolerance )
    assert_in_delta( 0.0, t.axes[2][1], $tolerance )
    assert_in_delta( 2.0, t.axes[2][2], $tolerance )
    assert_equal( 3, t.atoms.size )
    # checking atom 0
    assert_equal( 'Li'           , t.atoms[0].element)
    assert_equal( Vector3DInternal[0.0, 0.0, 0.0], t.atoms[0].position)
    assert_equal( nil            , t.atoms[0].name )
    # checking atom 1
    assert_equal( 'Li'           , t.atoms[1].element)
    assert_equal( Vector3DInternal[0.0, 0.0, 0.0], t.atoms[1].position)
    assert_equal( nil            , t.atoms[1].name )
    # checking atom 2
    assert_equal( 'O'            , t.atoms[2].element)
    assert_equal( Vector3DInternal[0.2, 0.2, 0.2], t.atoms[2].position)
    assert_equal( nil            , t.atoms[2].name )
  end

  def test_inverse_axis!
    @c02.inverse_axis!( 0 )
    t = @c02
    assert_equal( CrystalCell::Cell, t.class )
    assert_in_delta(-2.0, t.axes[0][0], $tolerance )
    assert_in_delta(-2.0, t.axes[0][1], $tolerance )
    assert_in_delta(-2.0, t.axes[0][2], $tolerance )
    assert_in_delta( 0.0, t.axes[1][0], $tolerance )
    assert_in_delta( 2.0, t.axes[1][1], $tolerance )
    assert_in_delta( 2.0, t.axes[1][2], $tolerance )
    assert_in_delta( 0.0, t.axes[2][0], $tolerance )
    assert_in_delta( 0.0, t.axes[2][1], $tolerance )
    assert_in_delta( 2.0, t.axes[2][2], $tolerance )
    assert_equal( 2, t.atoms.size )
    # checking atom 0
    assert_equal( 'Li'           , t.atoms[0].element)
    assert_equal( Vector3DInternal[0.0, 0.0, 0.0], t.atoms[0].position)
    assert_equal( nil            , t.atoms[0].name )
    # checking atom 1
    assert_equal( 'O'            , t.atoms[1].element)
    assert_equal( Vector3DInternal[-0.2, 0.2, 0.2], t.atoms[1].position)
    assert_equal( nil            , t.atoms[1].name )
  end

  def test_inverse_axis
    assert_raise( CrystalCell::Cell::AxesRangeError ){ @c02.inverse_axis( -1 ) }
    assert_raise( CrystalCell::Cell::AxesRangeError ){ @c02.inverse_axis( 3 ) }

    # x 軸反転
    t = @c02.inverse_axis( 0 )
    assert_equal( CrystalCell::Cell, t.class )
    assert_in_delta( -2.0, t.axes[0][0], $tolerance )
    assert_in_delta( -2.0, t.axes[0][1], $tolerance )
    assert_in_delta( -2.0, t.axes[0][2], $tolerance )
    assert_in_delta(  0.0, t.axes[1][0], $tolerance )
    assert_in_delta(  2.0, t.axes[1][1], $tolerance )
    assert_in_delta(  2.0, t.axes[1][2], $tolerance )
    assert_in_delta(  0.0, t.axes[2][0], $tolerance )
    assert_in_delta(  0.0, t.axes[2][1], $tolerance )
    assert_in_delta(  2.0, t.axes[2][2], $tolerance )
    assert_equal( 2, t.atoms.size )
    # checking atom 0
    assert_equal( 'Li'           , t.atoms[0].element)
    assert_equal( Vector3DInternal[0.0, 0.0, 0.0], t.atoms[0].position)
    assert_equal( nil            , t.atoms[0].name )
    # checking atom 1
    assert_equal( 'O'            , t.atoms[1].element)
    assert_equal( Vector3DInternal[-0.2, 0.2, 0.2], t.atoms[1].position)
    assert_equal( nil            , t.atoms[1].name )
    # checking non-destructive
    assert_equal( CrystalCell::Cell, t.class )
    assert_in_delta( 2.0, @c02.axes[0][0], $tolerance )
    assert_in_delta( 2.0, @c02.axes[0][1], $tolerance )
    assert_in_delta( 2.0, @c02.axes[0][2], $tolerance )
    assert_in_delta( 0.0, @c02.axes[1][0], $tolerance )
    assert_in_delta( 2.0, @c02.axes[1][1], $tolerance )
    assert_in_delta( 2.0, @c02.axes[1][2], $tolerance )
    assert_in_delta( 0.0, @c02.axes[2][0], $tolerance )
    assert_in_delta( 0.0, @c02.axes[2][1], $tolerance )
    assert_in_delta( 2.0, @c02.axes[2][2], $tolerance )
    assert_equal( 2, @c02.atoms.size )
    # checking atom 0
    assert_equal( 'Li'           , @c02.atoms[0].element)
    assert_equal( Vector3DInternal[0.0, 0.0, 0.0], @c02.atoms[0].position)
    assert_equal( nil            , @c02.atoms[0].name )
    # checking atom 1
    assert_equal( 'O'            , @c02.atoms[1].element)
    assert_equal( Vector3DInternal[ 0.2, 0.2, 0.2], @c02.atoms[1].position)
    assert_equal( nil            , @c02.atoms[1].name )

    # y 軸反転
    # [ [ ax, ay, az], [  0, by, bz], [  0,  0, cz] ]
    # ↓  y 軸反転
    # [ [ ax, ay, az], [  0,-by,-bz], [  0,  0, cz] ]
    # ↓ b vector の y 成分が正になるようにする。
    #   すなわち z 軸回りに半回転し、全ての x, y 成分が反転する。
    # [ [-ax,-ay, az], [  0, by,-bz], [  0,  0, cz] ]
    t = @c02.inverse_axis( 1 )
    assert_equal( CrystalCell::Cell, t.class )
    assert_in_delta( -2.0, t.axes[0][0], $tolerance )
    assert_in_delta( -2.0, t.axes[0][1], $tolerance )
    assert_in_delta(  2.0, t.axes[0][2], $tolerance )
    assert_in_delta(  0.0, t.axes[1][0], $tolerance )
    assert_in_delta(  2.0, t.axes[1][1], $tolerance )
    assert_in_delta( -2.0, t.axes[1][2], $tolerance )
    assert_in_delta(  0.0, t.axes[2][0], $tolerance )
    assert_in_delta(  0.0, t.axes[2][1], $tolerance )
    assert_in_delta(  2.0, t.axes[2][2], $tolerance )
    assert_equal( 2, t.atoms.size )
    # checking atom 0
    assert_equal( 'Li'           , t.atoms[0].element)
    assert_equal( Vector3DInternal[0.0, 0.0, 0.0], t.atoms[0].position)
    assert_equal( nil            , t.atoms[0].name )
    # checking atom 1
    assert_equal( 'O'            , t.atoms[1].element)
    assert_equal( Vector3DInternal[ 0.2,-0.2, 0.2], t.atoms[1].position)
    assert_equal( nil            , t.atoms[1].name )

    # z 軸反転
    # [ [ ax, ay, az], [  0, by, bz], [  0,  0, cz] ]
    # ↓ z 軸反転
    # [ [ ax, ay, az], [  0, by, bz], [  0,  0,-cz] ]
    # ↓ c vector の z 成分が正になるようにする。
    #   b vector の y 成分も正であることを保存する回転は、
    #   y 軸回りに半回転し、全ての x, z 成分が反転する。
    # [ [-ax, ay,-az], [  0, by,-bz], [  0,  0, cz] ]
    t = @c02.inverse_axis( 2 )
    assert_equal( CrystalCell::Cell, t.class )
    assert_in_delta(-2.0, t.axes[0][0], $tolerance )
    assert_in_delta( 2.0, t.axes[0][1], $tolerance )
    assert_in_delta(-2.0, t.axes[0][2], $tolerance )
    assert_in_delta( 0.0, t.axes[1][0], $tolerance )
    assert_in_delta( 2.0, t.axes[1][1], $tolerance )
    assert_in_delta(-2.0, t.axes[1][2], $tolerance )
    assert_in_delta( 0.0, t.axes[2][0], $tolerance )
    assert_in_delta( 0.0, t.axes[2][1], $tolerance )
    assert_in_delta( 2.0, t.axes[2][2], $tolerance )
    assert_equal( 2, t.atoms.size )
    # checking atom 0
    assert_equal( 'Li'           , t.atoms[0].element)
    assert_equal( Vector3DInternal[0.0, 0.0, 0.0], t.atoms[0].position)
    assert_equal( nil            , t.atoms[0].name )
    # checking atom 1
    assert_equal( 'O'            , t.atoms[1].element)
    assert_equal( Vector3DInternal[ 0.2, 0.2,-0.2], t.atoms[1].position)
    assert_equal( nil            , t.atoms[1].name )

  end

  def test_exchange_axes!
    # b, c の交換。
    @c08.exchange_axes!( [ 1, 2 ] )
    t = @c08
    assert_equal( CrystalCell::Cell, t.class )
    lc = t.axes.get_lattice_constants
    assert_in_delta( 2.0 * Math::sqrt( 3.0 ) , lc[0], $tolerance )
    assert_in_delta( 2.0                     , lc[1], $tolerance )
    assert_in_delta( 2.0 * Math::sqrt( 2.0 ) , lc[2], $tolerance )
    assert_in_delta( 45.0000000000000, lc[3], $tolerance )
    assert_in_delta( 35.2643896827547, lc[4], $tolerance )
    assert_in_delta( 54.7356103172453, lc[5], $tolerance )
    assert_equal( true, t.axes.lefthand? )
    assert_equal( 2, t.atoms.size )
    # checking atom 0
    assert_equal( 'Li'           , t.atoms[0].element)
    assert_equal( Vector3DInternal[ 1.2,  5.6,  3.4], t.atoms[0].position)
    assert_equal( 'atom0'        , t.atoms[0].name )
    assert_equal( [ false, false, true] , t.atoms[0].movable_flags )
    # checking atom 1
    assert_equal( 'O'            , t.atoms[1].element)
    assert_equal( Vector3DInternal[-1.2, -5.6, -3.4], t.atoms[1].position)
    assert_equal( nil            , t.atoms[1].name )
  end

  def test_exchange_axes
    assert_raise( CrystalCell::Cell::ArgumentError ){ @c02.exchange_axes( [ 0 ] ) }
    assert_raise( CrystalCell::Cell::ArgumentError ){ @c02.exchange_axes( [ 0, 1, 2] ) }
    assert_raise( CrystalCell::Cell::AxesRangeError ){ @c02.exchange_axes( [0, 3] ) }
    assert_raise( CrystalCell::Cell::AxesRangeError ){ @c02.exchange_axes( [-1, 2] ) }
    assert_raise( CrystalCell::Cell::SameAxesError ){ @c02.exchange_axes( [ 1,1] ) }

    # b, c の交換。
    t = @c08.exchange_axes( [ 1, 2 ] )
    assert_equal( CrystalCell::Cell, t.class )
    lc = t.axes.get_lattice_constants
    assert_in_delta( 2.0 * Math::sqrt( 3.0 ) , lc[0], $tolerance )
    assert_in_delta( 2.0                     , lc[1], $tolerance )
    assert_in_delta( 2.0 * Math::sqrt( 2.0 ) , lc[2], $tolerance )
    assert_in_delta( 45.0000000000000, lc[3], $tolerance )
    assert_in_delta( 35.2643896827547, lc[4], $tolerance )
    assert_in_delta( 54.7356103172453, lc[5], $tolerance )
    assert_equal( true, t.axes.lefthand? )
    assert_equal( 2, t.atoms.size )
    # checking atom 0
    assert_equal( 'Li'           , t.atoms[0].element)
    assert_equal( Vector3DInternal[ 1.2,  5.6,  3.4], t.atoms[0].position)
    assert_equal( 'atom0'        , t.atoms[0].name )
    # checking atom 1
    assert_equal( 'O'            , t.atoms[1].element)
    assert_equal( Vector3DInternal[-1.2, -5.6, -3.4], t.atoms[1].position)
    assert_equal( nil            , t.atoms[1].name )

    # b, c の交換によって非破壊であることを確認。
    t = @c08
    assert_equal( CrystalCell::Cell, t.class )
    lc = t.axes.get_lattice_constants
    assert_in_delta( 2.0 * Math::sqrt( 3.0 ) , lc[0], $tolerance )
    assert_in_delta( 2.0 * Math::sqrt( 2.0 ) , lc[1], $tolerance )
    assert_in_delta( 2.0                     , lc[2], $tolerance )
    assert_in_delta( 45.0000000000000, lc[3], $tolerance )
    assert_in_delta( 54.7356103172453, lc[4], $tolerance )
    assert_in_delta( 35.2643896827547, lc[5], $tolerance )
    assert_equal( true, t.axes.righthand? )
    assert_equal( 2, t.atoms.size )
    # checking atom 0
    assert_equal( 'Li'           , t.atoms[0].element)
    assert_equal( Vector3DInternal[ 1.2,  3.4,  5.6], t.atoms[0].position)
    assert_equal( 'atom0'        , t.atoms[0].name )
    # checking atom 1
    assert_equal( 'O'            , t.atoms[1].element)
    assert_equal( Vector3DInternal[-1.2, -3.4,  -5.6], t.atoms[1].position)
    assert_equal( nil            , t.atoms[1].name )

  end

  def test_reflect!
    @c08.reflect!
    t = @c08
    assert_equal( CrystalCell::Cell, t.class )
    lc = t.axes.get_lattice_constants
    assert_in_delta( 2.0 * Math::sqrt( 3.0 ) , lc[0], $tolerance )
    assert_in_delta( 2.0 * Math::sqrt( 2.0 ) , lc[1], $tolerance )
    assert_in_delta( 2.0                     , lc[2], $tolerance )
    assert_in_delta( 45.0000000000000, lc[3], $tolerance )
    assert_in_delta( 54.7356103172453, lc[4], $tolerance )
    assert_in_delta( 35.2643896827547, lc[5], $tolerance )
    assert_equal( true, t.axes.lefthand? )
    assert_equal( 2, t.atoms.size )
    # checking atom 0
    assert_equal( 'Li'           , t.atoms[0].element)
    assert_equal( Vector3DInternal[ 1.2,  3.4,  5.6], t.atoms[0].position)
    assert_equal( 'atom0'        , t.atoms[0].name )
    # checking atom 1
    assert_equal( 'O'            , t.atoms[1].element)
    assert_equal( Vector3DInternal[-1.2, -3.4,  -5.6], t.atoms[1].position)
    assert_equal( nil            , t.atoms[1].name )
  end

  def test_reflect
    t = @c08.reflect
    assert_equal( CrystalCell::Cell, t.class )
    lc = t.axes.get_lattice_constants
    assert_in_delta( 2.0 * Math::sqrt( 3.0 ) , lc[0], $tolerance )
    assert_in_delta( 2.0 * Math::sqrt( 2.0 ) , lc[1], $tolerance )
    assert_in_delta( 2.0                     , lc[2], $tolerance )
    assert_in_delta( 45.0000000000000, lc[3], $tolerance )
    assert_in_delta( 54.7356103172453, lc[4], $tolerance )
    assert_in_delta( 35.2643896827547, lc[5], $tolerance )
    assert_equal( true, t.axes.lefthand? )
    assert_equal( 2, t.atoms.size )
    # checking atom 0
    assert_equal( 'Li'           , t.atoms[0].element)
    assert_equal( Vector3DInternal[ 1.2,  3.4,  5.6], t.atoms[0].position)
    assert_equal( 'atom0'        , t.atoms[0].name )
    # checking atom 1
    assert_equal( 'O'            , t.atoms[1].element)
    assert_equal( Vector3DInternal[-1.2, -3.4,  -5.6], t.atoms[1].position)
    assert_equal( nil            , t.atoms[1].name )

    # 非破壊であることを確認。
    t = @c08
    assert_equal( CrystalCell::Cell, t.class )
    lc = t.axes.get_lattice_constants
    assert_in_delta( 2.0 * Math::sqrt( 3.0 ) , lc[0], $tolerance )
    assert_in_delta( 2.0 * Math::sqrt( 2.0 ) , lc[1], $tolerance )
    assert_in_delta( 2.0                     , lc[2], $tolerance )
    assert_in_delta( 45.0000000000000, lc[3], $tolerance )
    assert_in_delta( 54.7356103172453, lc[4], $tolerance )
    assert_in_delta( 35.2643896827547, lc[5], $tolerance )
    assert_equal( true, t.axes.righthand? )
    assert_equal( 2, t.atoms.size )
    # checking atom 0
    assert_equal( 'Li'           , t.atoms[0].element)
    assert_equal( Vector3DInternal[ 1.2,  3.4,  5.6], t.atoms[0].position)
    assert_equal( 'atom0'        , t.atoms[0].name )
    # checking atom 1
    assert_equal( 'O'            , t.atoms[1].element)
    assert_equal( Vector3DInternal[-1.2, -3.4,  -5.6], t.atoms[1].position)
    assert_equal( nil            , t.atoms[1].name )
  end

  def test_operate
    # identity operation
    rotation = [
      [1, 0, 0],
      [0, 1, 0],
      [0, 0, 1],
    ]
    translation = [0.0, 0.0, 0.0]
    result = @c01.operate(rotation, translation)
    assert_in_delta( 0.0, result.atoms[0].position[0], $tolerance)
    assert_in_delta( 0.0, result.atoms[0].position[1], $tolerance)
    assert_in_delta( 0.0, result.atoms[0].position[2], $tolerance)
    assert_in_delta( 0.1, result.atoms[1].position[0], $tolerance)
    assert_in_delta( 0.2, result.atoms[1].position[1], $tolerance)
    assert_in_delta( 0.3, result.atoms[1].position[2], $tolerance)

    # rotation
    rotation = [
      [1, 0, 0],
      [0, 1, 0],
      [0, 0,-1],
    ]
    translation = [0.0, 0.0, 0.0]
    result = @c01.operate(rotation, translation)
    assert_in_delta( 0.0, result.atoms[0].position[0], $tolerance)
    assert_in_delta( 0.0, result.atoms[0].position[1], $tolerance)
    assert_in_delta( 0.0, result.atoms[0].position[2], $tolerance)
    assert_in_delta( 0.1, result.atoms[1].position[0], $tolerance)
    assert_in_delta( 0.2, result.atoms[1].position[1], $tolerance)
    assert_in_delta(-0.3, result.atoms[1].position[2], $tolerance)

    # translation
    rotation = [
      [1, 0, 0],
      [0, 1, 0],
      [0, 0, 1],
    ]
    translation = [0.1, 0.2, 0.3]
    result = @c01.operate(rotation, translation)
    assert_in_delta(0.1, result.atoms[0].position[0], $tolerance)
    assert_in_delta(0.2, result.atoms[0].position[1], $tolerance)
    assert_in_delta(0.3, result.atoms[0].position[2], $tolerance)
    assert_in_delta(0.2, result.atoms[1].position[0], $tolerance)
    assert_in_delta(0.4, result.atoms[1].position[1], $tolerance)
    assert_in_delta(0.6, result.atoms[1].position[2], $tolerance)

    # rotation & translation
    rotation = [
      [1, 0, 0],
      [0, 1, 0],
      [0, 0,-1],
    ]
    translation = [0.1, 0.2, 0.3]
    result = @c01.operate(rotation, translation)
    assert_in_delta(0.1, result.atoms[0].position[0], $tolerance)
    assert_in_delta(0.2, result.atoms[0].position[1], $tolerance)
    assert_in_delta(0.3, result.atoms[0].position[2], $tolerance)
    assert_in_delta(0.2, result.atoms[1].position[0], $tolerance)
    assert_in_delta(0.4, result.atoms[1].position[1], $tolerance)
    assert_in_delta(0.0, result.atoms[1].position[2], $tolerance)
  end

  def test_independent_axes
    TODO
  end

end
