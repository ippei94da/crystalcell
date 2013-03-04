#! /usr/bin/ruby -w

require "pp"
require 'test/unit'
require 'stringio'
require "crystalcell"

class CrystalCell::PeriodicCell
  public :reset_positions_inside
end

class TC_PeriodicCell < Test::Unit::TestCase
  $tolerance = 10 ** (-10)

  V_000 = Vector3DInternal[0.0, 0.0, 0.0]
  V_666 = Vector3DInternal[0.6, 0.6, 0.6]
  V_111 = Vector3DInternal[0.1, 0.1, 0.1]
  V_119 = Vector3DInternal[0.1, 0.1, 0.9]
  V_191 = Vector3DInternal[0.1, 0.9, 0.1]
  V_199 = Vector3DInternal[0.1, 0.9, 0.9]
  V_911 = Vector3DInternal[0.9, 0.1, 0.1]
  V_919 = Vector3DInternal[0.9, 0.1, 0.9]
  V_991 = Vector3DInternal[0.9, 0.9, 0.1]
  V_999 = Vector3DInternal[0.9, 0.9, 0.9]

  def setup
    #原子のないセル。
    vectors00 = [ [2.0, 2.0, 2.0], [0.0, 2.0, 2.0], [0.0, 0.0, 2.0] ]
    @c00 = CrystalCell::PeriodicCell.new(vectors00)
    @c00.comment = 'c00'

    #元素の識別子を数字にしたもの。
    atoms = [
      CrystalCell::Atom.new(0, [0.0, 0.0, 0.0]),
      CrystalCell::Atom.new(1, [0.1, 0.2, 0.3]),
    ]
    @c01 = CrystalCell::PeriodicCell.new(vectors00, atoms)
    @c01.comment = 'c01'

    #Li と O を1つずつ入れたセル。
    atoms = [
      CrystalCell::Atom.new('Li', [0.0, 0.0, 0.0]),
      CrystalCell::Atom.new('O' , [0.2, 0.2, 0.2]),
    ]
    @c02 = CrystalCell::PeriodicCell.new(vectors00, atoms)
    @c02.comment = 'c02'

    #原子を追加する順序を逆にしたもの。
    atoms = [
      CrystalCell::Atom.new('O' , [0.2, 0.2, 0.2]),
      CrystalCell::Atom.new('Li', [0.0, 0.0, 0.0]),
    ]
    @c03 = CrystalCell::PeriodicCell.new(vectors00, atoms)
    @c03.comment = 'c03'

    #原子を add したもの。
    atoms = [
      CrystalCell::Atom.new('Li', [0.0, 0.0, 0.0]),
      CrystalCell::Atom.new('O' , [0.2, 0.2, 0.2]),
      CrystalCell::Atom.new('Li', [0.1, 0.2, 0.3]),
    ]
    @c04 = CrystalCell::PeriodicCell.new(vectors00, atoms)
    @c04.comment = 'c04'

    #原子を remove したもの。
    atoms = [
      CrystalCell::Atom.new('Li', [0.0, 0.0, 0.0])
    ]
    @c05 = CrystalCell::PeriodicCell.new(vectors00, atoms)
    @c05.comment = 'c05'

    #Selective dynamics をいれたもの。
    atoms = [
      CrystalCell::Atom.new('Li', [0.0, 0.0, 0.0], nil,  [true, false, false ]),
      CrystalCell::Atom.new('O' , [0.2, 0.2, 0.2]),
    ]
    @c06 = CrystalCell::PeriodicCell.new(vectors00, atoms)
    @c06.comment = 'c06'

    #元素の識別子を数字にしたもの。
    atoms = [
      CrystalCell::Atom.new(0, [0.0, 0.0, 0.0]),
      CrystalCell::Atom.new(1, [0.2, 0.2, 0.2]),
    ]
    @c07 = CrystalCell::PeriodicCell.new(vectors00, atoms)
    @c07.comment = 'c01'

    # セル外の座標の原子を追加。
    atoms = [
      CrystalCell::Atom.new('Li', [ 1.2,  3.4,  5.6], "atom0", [ false, false, true]),
      CrystalCell::Atom.new('O', [-1.2, -3.4, -5.6]),
    ]
    @c08 = CrystalCell::PeriodicCell.new(vectors00, atoms)
    @c08.comment = 'c08'
  end

  def test_directions_within_distance
    #A点 (0.1, 0.1, 0.1)_internal
    #cartesian で、
    #  0.1(2, 2, 2)
    #+ 0.1(0, 2, 2)
    #+ 0.1(0, 0, 2)
    #==============
    #  0.1(2, 4, 6) = (0.2, 0.4, 0.6)_cartesian
    #
    #B点 (0.1, 0.1, 0.1)_internal
    #cartesian で、
    #  0.9(2, 2, 2)
    #+ 0.9(0, 2, 2)
    #+ 0.9(0, 0, 2)
    #==============
    #  0.9(2, 4, 6) = (1.8, 3.6, 5.4)_cartesian
    #詳細は test/directions_within_distance.rb を参照。
    #p distance([ (1.8 - 2.0), (3.6 - 4.0), (5.4 - 4.0) ], A) #[-1,-1, 0]  1.2               
    #p distance([ (1.8 - 2.0), (3.6 - 2.0), (5.4 - 4.0) ], A) #[-1, 0,-1]  1.49666295470958  
    #p distance([ (1.8 - 2.0), (3.6 - 4.0), (5.4 - 6.0) ], A) #[-1,-1,-1]  1.49666295470958  
    #p distance([ (1.8 - 0.0), (3.6 - 2.0), (5.4 - 4.0) ], A) #[ 0,-1,-1]  2.1540659228538   
    #p distance([ (1.8 - 2.0), (3.6 - 4.0), (5.4 - 2.0) ], A) #[-1,-1,+1]  2.93938769133981  
    #p distance([ (1.8 - 2.0), (3.6 - 2.0), (5.4 - 2.0) ], A) #[-1, 0, 0]  3.07245829914744  
    #p distance([ (1.8 - 0.0), (3.6 - 2.0), (5.4 - 2.0) ], A) #[ 0,-1, 0]  3.44093010681705  
    #p distance([ (1.8 - 2.0), (3.6 - 0.0), (5.4 - 2.0) ], A) #[-1,+1,-1]  4.27083130081252  
    #p distance([ (1.8 - 0.0), (3.6 - 0.0), (5.4 - 2.0) ], A) #[ 0, 0,-1]  4.54312667664022  
    #p distance([ (1.8 - 2.0), (3.6 - 2.0), (5.4 - 0.0) ], A) #[-1, 0,+1]  4.96386945839634  
    #p distance([ (1.8 - 0.0), (3.6 - 2.0), (5.4 + 0.0) ], A) #[ 0,-1,+1]  5.2               
    #p distance([ (1.8 + 2.0), (3.6 + 0.0), (5.4 - 2.0) ], A) #[+1,-1,-1]  5.57135531087365  
    #p distance([ (1.8 - 2.0), (3.6 - 0.0), (5.4 - 0.0) ], A) #[-1,+1, 0]  5.78273291792039  
    #p distance([ (1.8 - 0.0), (3.6 - 0.0), (5.4 + 0.0) ], A) #[ 0, 0, 0]  5.98665181883831  
    #p distance([ (1.8 + 2.0), (3.6 + 0.0), (5.4 + 0.0) ], A) #[+1,-1, 0]  6.8               
    #p distance([ (1.8 - 0.0), (3.6 + 2.0), (5.4 + 0.0) ], A) #[ 0,+1,-1]  7.25534285888682  
    #p distance([ (1.8 - 2.0), (3.6 - 0.0), (5.4 + 2.0) ], A) #[-1,+1,+1]  7.52595508889071  
    #p distance([ (1.8 - 0.0), (3.6 - 0.0), (5.4 + 2.0) ], A) #[ 0, 0,+1]  7.68374908491942  
    #p distance([ (1.8 + 2.0), (3.6 + 2.0), (5.4 + 0.0) ], A) #[+1, 0,-1]  7.93977329651168  
    #p distance([ (1.8 + 2.0), (3.6 + 0.0), (5.4 + 2.0) ], A) #[+1,-1,+1]  8.33306666239986  
    #p distance([ (1.8 - 0.0), (3.6 + 2.0), (5.4 + 2.0) ], A) #[ 0,+1, 0]  8.7086164228309   
    #p distance([ (1.8 + 2.0), (3.6 + 2.0), (5.4 + 2.0) ], A) #[+1, 0, 0]  9.28654941299512  
    #p distance([ (1.8 - 0.0), (3.6 + 2.0), (5.4 + 4.0) ], A) #[ 0,+1,+1] 10.3460137251021  
    #p distance([ (1.8 + 2.0), (3.6 + 4.0), (5.4 + 2.0) ], A) #[+1,+1,-1] 10.5375518978556  
    #p distance([ (1.8 + 2.0), (3.6 + 2.0), (5.4 + 4.0) ], A) #[+1, 0,+1] 10.8369737473153  
    #p distance([ (1.8 + 2.0), (3.6 + 4.0), (5.4 + 4.0) ], A) #[+1,+1, 0] 11.9264412127005  
    #p distance([ (1.8 + 2.0), (3.6 + 4.0), (5.4 + 6.0) ], A) #[+1,+1,+1] 13.4699665923862  

    assert_equal([],                                                                          @c00.directions_within_distance(V_111, V_999, 1.19))
    assert_equal([[-1,-1,0]],                                                                 @c00.directions_within_distance(V_111, V_999, 1.21))
    assert_equal([[-1,-1,0]],                                                                 @c00.directions_within_distance(V_111, V_999, 1.49))
    assert_equal([[-1,-1,-1],[-1,-1,0],[-1,0,-1]],                                            @c00.directions_within_distance(V_111, V_999, 1.50))
    assert_equal([[-1,-1,-1],[-1,-1,0],[-1,0,-1]],                                            @c00.directions_within_distance(V_111, V_999, 2.15))
    assert_equal([[-1,-1,-1],[-1,-1,0],[-1,0,-1],[0,-1,-1]],                                  @c00.directions_within_distance(V_111, V_999, 2.16))
    assert_equal([[-1,-1,-1],[-1,-1,0],[-1,0,-1],[0,-1,-1]],                                  @c00.directions_within_distance(V_111, V_999, 2.93))
    assert_equal([[-1,-1,-1],[-1,-1,0],[-1,-1,+1],[-1,0,-1],[0,-1,-1]],                       @c00.directions_within_distance(V_111, V_999, 2.94))
    assert_equal([[-1,-1,-1],[-1,-1,0],[-1,-1,+1],[-1,0,-1],[0,-1,-1]],                       @c00.directions_within_distance(V_111, V_999, 3.07))
    assert_equal([[-1,-1,-1],[-1,-1,0],[-1,-1,+1],[-1,0,-1],[-1,0,0],[0,-1,-1]],              @c00.directions_within_distance(V_111, V_999, 3.08))
    assert_equal([[-1,-1,-1],[-1,-1,0],[-1,-1,+1],[-1,0,-1],[-1,0,0],[0,-1,-1]],              @c00.directions_within_distance(V_111, V_999, 3.44))
    assert_equal([[-1,-1,-1],[-1,-1,0],[-1,-1,+1],[-1,0,-1],[-1,0,0],[0,-1,-1],[0,-1,0]],     @c00.directions_within_distance(V_111, V_999, 3.45))
    #あとは省略。

  end

  def test_nearest_direction
    assert_equal(
      Vector3DInternal[ 0,  0,  0],
      @c00.nearest_direction(Vector3DInternal[-0.9, -0.9, -0.9],  V_111)
    )

    assert_equal(Vector3DInternal[-1, -1,  0], @c00.nearest_direction(V_111, V_999))
    assert_equal(Vector3DInternal[-1, -1,  0], @c00.nearest_direction(V_119, V_999))
    assert_equal(Vector3DInternal[-1,  0, -1], @c00.nearest_direction(V_191, V_999))
    assert_equal(Vector3DInternal[-1,  0,  0], @c00.nearest_direction(V_199, V_999))
    assert_equal(Vector3DInternal[ 0, -1, -1], @c00.nearest_direction(V_911, V_999))
    assert_equal(Vector3DInternal[ 0, -1,  0], @c00.nearest_direction(V_919, V_999))
    assert_equal(Vector3DInternal[ 0,  0, -1], @c00.nearest_direction(V_991, V_999))
    assert_equal(Vector3DInternal[ 0,  0,  0], @c00.nearest_direction(V_999, V_999))
    assert_equal(Vector3DInternal[ 1,  1,  0], @c00.nearest_direction(V_999, V_111))
    assert_equal(Vector3DInternal[ 1,  1,  0], @c00.nearest_direction(V_999, V_119))
    assert_equal(Vector3DInternal[ 1,  0,  1], @c00.nearest_direction(V_999, V_191))
    assert_equal(Vector3DInternal[ 1,  0,  0], @c00.nearest_direction(V_999, V_199))
    assert_equal(Vector3DInternal[ 0,  1,  1], @c00.nearest_direction(V_999, V_911))
    assert_equal(Vector3DInternal[ 0,  1,  0], @c00.nearest_direction(V_999, V_919))
    assert_equal(Vector3DInternal[ 0,  0,  1], @c00.nearest_direction(V_999, V_991))
    assert_equal(Vector3DInternal[ 0,  0,  0], @c00.nearest_direction(V_999, V_999))

    assert_equal(Vector3DInternal[ 1,  0,  1], @c00.nearest_direction(V_666, V_000))
    assert_equal(Vector3DInternal[-1,  0, -1], @c00.nearest_direction(V_000, V_666))

    assert_raise(CrystalCell::PeriodicCell::TypeError){
      @c00.nearest_direction([ 0.1, 0.1, 0.1 ], [ 0.9, 0.9, 0.9 ])
    }
  end

  def test_nearest_distance
    assert_in_delta(Math::sqrt(0.56), @c00.nearest_distance(V_000, Vector3DInternal[0.1, 0.1, 0.1]), $tolerance)
    assert_in_delta(Math::sqrt(0.88), @c00.nearest_distance(V_000, Vector3DInternal[0.8, 0.9, 1.0]), $tolerance)

    assert_raise(CrystalCell::PeriodicCell::TypeError){@c00.nearest_distance([0.0, 0.0, 0.0], [0.1, 0.1, 0.1])}
    assert_raise(CrystalCell::PeriodicCell::TypeError){@c00.nearest_distance([0.0, 0.0, 0.0], [0.8, 0.9, 1.0])}
  end


  def test_find_bonds
    atoms = [
      CrystalCell::Atom.new('Li', [ 0.1, 0.1, 0.1 ]),
      CrystalCell::Atom.new('O',  [ 0.9, 0.9, 0.9 ]),
    ]
    pc00 = CrystalCell::PeriodicCell.new([ [2.0, 2.0, 2.0], [0.0, 2.0, 2.0], [0.0, 0.0, 2.0] ] , atoms)

    assert_equal([],
      pc00.find_bonds('Li', 'O' , 0.0, 0.00)
    )

    #境界を越えて見つけられる。
    t = pc00.find_bonds('Li', 'O' , 0.0, 1.21)
    assert_equal(2, t.size)
    assert_in_delta(0.1, t[0][0][0], $tolerance)
    assert_in_delta(0.1, t[0][0][1], $tolerance)
    assert_in_delta(0.1, t[0][0][2], $tolerance)
    assert_in_delta(-0.1, t[0][1][0], $tolerance)
    assert_in_delta(-0.1, t[0][1][1], $tolerance)
    assert_in_delta(0.9, t[0][1][2], $tolerance)
    assert_in_delta(0.9, t[1][0][0], $tolerance)
    assert_in_delta(0.9, t[1][0][1], $tolerance)
    assert_in_delta(0.9, t[1][0][2], $tolerance)
    assert_in_delta(1.1, t[1][1][0], $tolerance)
    assert_in_delta(1.1, t[1][1][1], $tolerance)
    assert_in_delta(0.1, t[1][1][2], $tolerance)

    #元素の順序を変えても等価な結果が返る。
    t = pc00.find_bonds('O' , 'Li', 0.0, 1.21)
    assert_equal(2, t.size)
    assert_in_delta(0.1, t[0][0][0], $tolerance)
    assert_in_delta(0.1, t[0][0][1], $tolerance)
    assert_in_delta(0.1, t[0][0][2], $tolerance)
    assert_in_delta(-0.1, t[0][1][0], $tolerance)
    assert_in_delta(-0.1, t[0][1][1], $tolerance)
    assert_in_delta(0.9, t[0][1][2], $tolerance)
    assert_in_delta(0.9, t[1][0][0], $tolerance)
    assert_in_delta(0.9, t[1][0][1], $tolerance)
    assert_in_delta(0.9, t[1][0][2], $tolerance)
    assert_in_delta(1.1, t[1][1][0], $tolerance)
    assert_in_delta(1.1, t[1][1][1], $tolerance)
    assert_in_delta(0.1, t[1][1][2], $tolerance)


    pc01 = CrystalCell::PeriodicCell.new([ [2.0, 2.0, 2.0], [0.0, 2.0, 2.0], [0.0, 0.0, 2.0] ])
    pc01.add_atom(CrystalCell::Atom.new('Li', [ 0.5, 0.5, 0.4 ]))
    pc01.add_atom(CrystalCell::Atom.new('Li', [ 0.5, 0.5, 0.5 ]))
    pc01.add_atom(CrystalCell::Atom.new('O',  [ 0.5, 0.5, 0.6 ]))
    pc01.add_atom(CrystalCell::Atom.new('O',  [ 0.5, 0.5, 0.7 ]))

    t = pc01.find_bonds('Li', 'Li' , 0.0, 0.10)
    assert_equal([], t)

    #Li-Li、元素の区別
    t = pc01.find_bonds('Li', 'Li' , 0.0, 0.30)
    assert_equal(
      [ [Vector3DInternal[0.5, 0.5, 0.4], Vector3DInternal[0.5, 0.5, 0.5 ] ] ],
      t
    )

    #O-O、元素の区別
    t = pc01.find_bonds('O', 'O' , 0.0, 0.30)
    assert_equal(
      [ [ Vector3DInternal[0.5, 0.5, 0.6], Vector3DInternal[0.5, 0.5, 0.7]]],
      t
    )

    #Li-O、元素の区別
    t = pc01.find_bonds('Li', 'O' , 0.0, 0.30)
    assert_equal(
      [ [ Vector3DInternal[0.5, 0.5, 0.5], Vector3DInternal[0.5, 0.5, 0.6] ] ],
      t
    )

    #O-Li, 逆順でも等価
    t = pc01.find_bonds('O' , 'Li', 0.0, 0.30)
    assert_equal(
      [[ Vector3DInternal[0.5, 0.5, 0.5], Vector3DInternal[0.5, 0.5, 0.6]]],
      t
    )

    #距離の下限
    t = pc01.find_bonds('Li', 'O' , 0.5, 0.7)
    assert_equal(
      [ [ Vector3DInternal[0.5, 0.5, 0.4], Vector3DInternal[0.5, 0.5, 0.7]]],
      t
    )

    #距離の上限は pc00 で。

  end

  def test_pairs_within_distance
    pc00 = CrystalCell::PeriodicCell.new([ [2.0, 2.0, 2.0], [0.0, 2.0, 2.0], [0.0, 0.0, 2.0] ])
    pc00.add_atom(CrystalCell::Atom.new('Li', [ 0.1, 0.1, 0.1 ]))
    pc00.add_atom(CrystalCell::Atom.new('O',  [ 0.9, 0.9, 0.9 ]))

    #0-1 間
    # [-1,-1, 0]  1.2
    # [-1, 0,-1]  1.49666295470958
    # [-1,-1,-1]  1.49666295470958
    # [ 0,-1,-1]  2.1540659228538
    # [-1,-1,+1]  2.93938769133981
    # [-1, 0, 0]  3.07245829914744

    ##0-0, 1-1
    #[ 0, 0, 1] 2.0
    #[ 0, 0,-1] 2.0
    #[ 0,-1, 1] 2.0
    #[ 0, 1,-1] 2.0
    #[-1, 1, 0] 2.0
    #[ 1,-1, 0] 2.0

    assert_equal([], pc00.pairs_within_distance(0.0))
    assert_equal([], pc00.pairs_within_distance(1.19))
    assert_equal(
      [ [0,1,[-1,-1, 0]], [1,0,[ 1, 1, 0]] ],
      pc00.pairs_within_distance(1.21))
    assert_equal(
      [ [0,1,[-1,-1, 0]], [1,0,[ 1, 1, 0]] ],
      pc00.pairs_within_distance(1.49))
    assert_equal(
      [
        [0,1,[-1,-1,-1]],
        [0,1,[-1,-1, 0]],
        [0,1,[-1, 0,-1]],
        [1,0,[ 1, 0, 1]],
        [1,0,[ 1, 1, 0]],
        [1,0,[ 1, 1, 1]]
      ], pc00.pairs_within_distance(1.50)
    )
    assert_equal(
      [
        [0,1,[-1,-1,-1]],
        [0,1,[-1,-1, 0]],
        [0,1,[-1, 0,-1]],
        [1,0,[ 1, 0, 1]],
        [1,0,[ 1, 1, 0]],
        [1,0,[ 1, 1, 1]]
      ], pc00.pairs_within_distance(1.99)
    )

    t = pc00.pairs_within_distance(2.01)
    assert_equal(18, t.size)
    assert_equal([0,0,[-1, 1, 0]], t[ 0])
    assert_equal([0,0,[ 0,-1, 1]], t[ 1])
    assert_equal([0,0,[ 0, 0,-1]], t[ 2])
    assert_equal([0,0,[ 0, 0, 1]], t[ 3])
    assert_equal([0,0,[ 0, 1,-1]], t[ 4])
    assert_equal([0,0,[ 1,-1, 0]], t[ 5])
    assert_equal([0,1,[-1,-1,-1]], t[ 6])
    assert_equal([0,1,[-1,-1, 0]], t[ 7])
    assert_equal([0,1,[-1, 0,-1]], t[ 8])
    assert_equal([1,0,[ 1, 0, 1]], t[ 9])
    assert_equal([1,0,[ 1, 1, 0]], t[10])
    assert_equal([1,0,[ 1, 1, 1]], t[11])
    assert_equal([1,1,[-1, 1, 0]], t[12])
    assert_equal([1,1,[ 0,-1, 1]], t[13])
    assert_equal([1,1,[ 0, 0,-1]], t[14])
    assert_equal([1,1,[ 0, 0, 1]], t[15])
    assert_equal([1,1,[ 0, 1,-1]], t[16])
    assert_equal([1,1,[ 1,-1, 0]], t[17])

    t = pc00.pairs_within_distance(2.15)
    assert_equal(18, t.size)
    assert_equal([0,0,[-1, 1, 0]], t[ 0])
    assert_equal([0,0,[ 0,-1, 1]], t[ 1])
    assert_equal([0,0,[ 0, 0,-1]], t[ 2])
    assert_equal([0,0,[ 0, 0, 1]], t[ 3])
    assert_equal([0,0,[ 0, 1,-1]], t[ 4])
    assert_equal([0,0,[ 1,-1, 0]], t[ 5])
    assert_equal([0,1,[-1,-1,-1]], t[ 6])
    assert_equal([0,1,[-1,-1, 0]], t[ 7])
    assert_equal([0,1,[-1, 0,-1]], t[ 8])
    assert_equal([1,0,[ 1, 0, 1]], t[ 9])
    assert_equal([1,0,[ 1, 1, 0]], t[10])
    assert_equal([1,0,[ 1, 1, 1]], t[11])
    assert_equal([1,1,[-1, 1, 0]], t[12])
    assert_equal([1,1,[ 0,-1, 1]], t[13])
    assert_equal([1,1,[ 0, 0,-1]], t[14])
    assert_equal([1,1,[ 0, 0, 1]], t[15])
    assert_equal([1,1,[ 0, 1,-1]], t[16])
    assert_equal([1,1,[ 1,-1, 0]], t[17])

    t = pc00.pairs_within_distance(2.16)
    assert_equal(20, t.size)
    assert_equal([0,0,[-1, 1, 0]], t[ 0])
    assert_equal([0,0,[ 0,-1, 1]], t[ 1])
    assert_equal([0,0,[ 0, 0,-1]], t[ 2])
    assert_equal([0,0,[ 0, 0, 1]], t[ 3])
    assert_equal([0,0,[ 0, 1,-1]], t[ 4])
    assert_equal([0,0,[ 1,-1, 0]], t[ 5])
    assert_equal([0,1,[-1,-1,-1]], t[ 6])
    assert_equal([0,1,[-1,-1, 0]], t[ 7])
    assert_equal([0,1,[-1, 0,-1]], t[ 8])
    assert_equal([0,1,[ 0,-1,-1]], t[ 9])
    assert_equal([1,0,[ 0, 1, 1]], t[10])
    assert_equal([1,0,[ 1, 0, 1]], t[11])
    assert_equal([1,0,[ 1, 1, 0]], t[12])
    assert_equal([1,0,[ 1, 1, 1]], t[13])
    assert_equal([1,1,[-1, 1, 0]], t[14])
    assert_equal([1,1,[ 0,-1, 1]], t[15])
    assert_equal([1,1,[ 0, 0,-1]], t[16])
    assert_equal([1,1,[ 0, 0, 1]], t[17])
    assert_equal([1,1,[ 0, 1,-1]], t[18])
    assert_equal([1,1,[ 1,-1, 0]], t[19])

    t = pc00.pairs_within_distance(2.82)
    assert_equal(20, t.size)
    assert_equal([0,0,[-1, 1, 0]], t[ 0])
    assert_equal([0,0,[ 0,-1, 1]], t[ 1])
    assert_equal([0,0,[ 0, 0,-1]], t[ 2])
    assert_equal([0,0,[ 0, 0, 1]], t[ 3])
    assert_equal([0,0,[ 0, 1,-1]], t[ 4])
    assert_equal([0,0,[ 1,-1, 0]], t[ 5])
    assert_equal([0,1,[-1,-1,-1]], t[ 6])
    assert_equal([0,1,[-1,-1, 0]], t[ 7])
    assert_equal([0,1,[-1, 0,-1]], t[ 8])
    assert_equal([0,1,[ 0,-1,-1]], t[ 9])
    assert_equal([1,0,[ 0, 1, 1]], t[10])
    assert_equal([1,0,[ 1, 0, 1]], t[11])
    assert_equal([1,0,[ 1, 1, 0]], t[12])
    assert_equal([1,0,[ 1, 1, 1]], t[13])
    assert_equal([1,1,[-1, 1, 0]], t[14])
    assert_equal([1,1,[ 0,-1, 1]], t[15])
    assert_equal([1,1,[ 0, 0,-1]], t[16])
    assert_equal([1,1,[ 0, 0, 1]], t[17])
    assert_equal([1,1,[ 0, 1,-1]], t[18])
    assert_equal([1,1,[ 1,-1, 0]], t[19])

    t = pc00.pairs_within_distance(2.83)
    assert_equal(36, t.size)
    assert_equal([0,0,[-1, 0, 1]], t[ 0])
    assert_equal([0,0,[-1, 1,-1]], t[ 1])
    assert_equal([0,0,[-1, 1, 0]], t[ 2])
    assert_equal([0,0,[-1, 1, 1]], t[ 3])
    assert_equal([0,0,[ 0,-1, 0]], t[ 4])
    assert_equal([0,0,[ 0,-1, 1]], t[ 5])
    assert_equal([0,0,[ 0, 0,-1]], t[ 6])
    assert_equal([0,0,[ 0, 0, 1]], t[ 7])
    assert_equal([0,0,[ 0, 1,-1]], t[ 8])
    assert_equal([0,0,[ 0, 1, 0]], t[ 9])
    assert_equal([0,0,[ 1,-1,-1]], t[10])
    assert_equal([0,0,[ 1,-1, 0]], t[11])
    assert_equal([0,0,[ 1,-1, 1]], t[12])
    assert_equal([0,0,[ 1, 0,-1]], t[13])
    assert_equal([0,1,[-1,-1,-1]], t[14])
    assert_equal([0,1,[-1,-1, 0]], t[15])
    assert_equal([0,1,[-1, 0,-1]], t[16])
    assert_equal([0,1,[ 0,-1,-1]], t[17])
    assert_equal([1,0,[ 0, 1, 1]], t[18])
    assert_equal([1,0,[ 1, 0, 1]], t[19])
    assert_equal([1,0,[ 1, 1, 0]], t[20])
    assert_equal([1,0,[ 1, 1, 1]], t[21])
    assert_equal([1,1,[-1, 0, 1]], t[22])
    assert_equal([1,1,[-1, 1,-1]], t[23])
    assert_equal([1,1,[-1, 1, 0]], t[24])
    assert_equal([1,1,[-1, 1, 1]], t[25])
    assert_equal([1,1,[ 0,-1, 0]], t[26])
    assert_equal([1,1,[ 0,-1, 1]], t[27])
    assert_equal([1,1,[ 0, 0,-1]], t[28])
    assert_equal([1,1,[ 0, 0, 1]], t[29])
    assert_equal([1,1,[ 0, 1,-1]], t[30])
    assert_equal([1,1,[ 0, 1, 0]], t[31])
    assert_equal([1,1,[ 1,-1,-1]], t[32])
    assert_equal([1,1,[ 1,-1, 0]], t[33])
    assert_equal([1,1,[ 1,-1, 1]], t[34])
    assert_equal([1,1,[ 1, 0,-1]], t[35])
  end

  def test_add_atom
    tmp = Marshal.load(Marshal.dump(@c00))
    tmp.add_atom(CrystalCell::Atom.new(0, [1.0, 2.3, -2.3]))
    assert_equal(1, tmp.positions.size)
    assert_equal(Vector3DInternal, tmp.positions[0].class)
    assert_in_delta(0.0, tmp.positions[0][0], $tolerance)
    assert_in_delta(0.3, tmp.positions[0][1], $tolerance)
    assert_in_delta(0.7, tmp.positions[0][2], $tolerance)
  end

  def test_rotate
    @c02.add_atom(CrystalCell::Atom.new('Li', [1.1, 1.2, 1.3]))

    # Check new instance.
    assert_equal(3, @c02.rotate([[-1, 0, 0],[0, -1, 0],[0, 0, -1]]).positions.size)
    assert_equal(Vector3DInternal, @c02.rotate([[-1, 0, 0],[0, -1, 0],[0, 0, -1]]).positions[0].class)
    assert_equal(Vector3DInternal, @c02.rotate([[-1, 0, 0],[0, -1, 0],[0, 0, -1]]).positions[1].class)
    assert_equal(Vector3DInternal, @c02.rotate([[-1, 0, 0],[0, -1, 0],[0, 0, -1]]).positions[2].class)
    assert_in_delta(0.0,  @c02.rotate([[-1, 0, 0],[0, -1, 0],[0, 0, -1]]).positions[0][0], $tolerance)
    assert_in_delta(0.0,  @c02.rotate([[-1, 0, 0],[0, -1, 0],[0, 0, -1]]).positions[0][1], $tolerance)
    assert_in_delta(0.0,  @c02.rotate([[-1, 0, 0],[0, -1, 0],[0, 0, -1]]).positions[0][2], $tolerance)
    assert_in_delta(0.8,  @c02.rotate([[-1, 0, 0],[0, -1, 0],[0, 0, -1]]).positions[1][0], $tolerance)
    assert_in_delta(0.8,  @c02.rotate([[-1, 0, 0],[0, -1, 0],[0, 0, -1]]).positions[1][1], $tolerance)
    assert_in_delta(0.8,  @c02.rotate([[-1, 0, 0],[0, -1, 0],[0, 0, -1]]).positions[1][2], $tolerance)
    assert_in_delta(0.9,  @c02.rotate([[-1, 0, 0],[0, -1, 0],[0, 0, -1]]).positions[2][0], $tolerance)
    assert_in_delta(0.8,  @c02.rotate([[-1, 0, 0],[0, -1, 0],[0, 0, -1]]).positions[2][1], $tolerance)
    assert_in_delta(0.7,  @c02.rotate([[-1, 0, 0],[0, -1, 0],[0, 0, -1]]).positions[2][2], $tolerance)

    # Check not destructed.
    assert_equal(3, @c02.positions.size)
    assert_equal(Vector3DInternal, @c02.positions[0].class)
    assert_equal(Vector3DInternal, @c02.positions[1].class)
    assert_equal(Vector3DInternal, @c02.positions[2].class)
    assert_in_delta(0.0          , @c02.positions[0][0], $tolerance)
    assert_in_delta(0.0          , @c02.positions[0][1], $tolerance)
    assert_in_delta(0.0          , @c02.positions[0][2], $tolerance)
    assert_in_delta(0.2          , @c02.positions[1][0], $tolerance)
    assert_in_delta(0.2          , @c02.positions[1][1], $tolerance)
    assert_in_delta(0.2          , @c02.positions[1][2], $tolerance)
    assert_in_delta(0.1          , @c02.positions[2][0], $tolerance)
    assert_in_delta(0.2          , @c02.positions[2][1], $tolerance)
    assert_in_delta(0.3          , @c02.positions[2][2], $tolerance)
  end

  def test_rotate!
    @c02.add_atom(CrystalCell::Atom.new('Li', [0.1, 0.2, 0.3]))
    @c02.rotate!([[-1, 0, 0],[0, -1, 0],[0, 0, -1]])
    assert_equal(
      [ Vector3DInternal[  0.0,  0.0,  0.0 ],
        Vector3DInternal[  0.8,  0.8,  0.8 ],
        Vector3DInternal[  0.9,  0.8,  0.7 ]
      ],
      @c02.positions
    )
  end

  def test_translate
    poss = @c02.translate([1.1, 1.2, 1.3]).positions
    assert_in_delta(0.1, poss[0][0], $tolerance)
    assert_in_delta(0.2, poss[0][1], $tolerance)
    assert_in_delta(0.3, poss[0][2], $tolerance)
    assert_in_delta(0.3, poss[1][0], $tolerance)
    assert_in_delta(0.4, poss[1][1], $tolerance)
    assert_in_delta(0.5, poss[1][2], $tolerance)

    poss = @c02.translate([-0.3,-0.3,-0.3]).positions
    assert_in_delta( 0.7, poss[0][0], $tolerance)
    assert_in_delta( 0.7, poss[0][1], $tolerance)
    assert_in_delta( 0.7, poss[0][2], $tolerance)
    assert_in_delta( 0.9, poss[1][0], $tolerance)
    assert_in_delta( 0.9, poss[1][1], $tolerance)
    assert_in_delta( 0.9, poss[1][2], $tolerance)

    # Check not destructed.
    assert_equal(
      [ Vector3DInternal[ 0.0, 0.0, 0.0 ],
        Vector3DInternal[ 0.2, 0.2, 0.2 ]
      ],
      @c02.positions
    )
  end

  def test_translate!
    @c02.translate!([1.1, 1.2, 1.3])
    poss = @c02.positions

    assert_in_delta(0.1, poss[0][0], $tolerance)
    assert_in_delta(0.2, poss[0][1], $tolerance)
    assert_in_delta(0.3, poss[0][2], $tolerance)
    assert_in_delta(0.3, poss[1][0], $tolerance)
    assert_in_delta(0.4, poss[1][1], $tolerance)
    assert_in_delta(0.5, poss[1][2], $tolerance)
  end

  def test_to_cell
    t = @c01.to_cell
    assert_equal(CrystalCell::Cell, t.class)
    assert_equal(CrystalCell::LatticeAxes, t.axes.class)
    assert_in_delta(2.0, t.axes[0][0], $tolerance)
    assert_in_delta(2.0, t.axes[0][1], $tolerance)
    assert_in_delta(2.0, t.axes[0][2], $tolerance)
    assert_in_delta(0.0, t.axes[1][0], $tolerance)
    assert_in_delta(2.0, t.axes[1][1], $tolerance)
    assert_in_delta(2.0, t.axes[1][2], $tolerance)
    assert_in_delta(0.0, t.axes[2][0], $tolerance)
    assert_in_delta(0.0, t.axes[2][1], $tolerance)
    assert_in_delta(2.0, t.axes[2][2], $tolerance)

    assert_equal(2, t.atoms.size)
    assert_equal(CrystalCell::Atom.new(0, [0.0, 0.0, 0.0]), t.atoms[0])
    assert_equal(CrystalCell::Atom.new(1, [0.1, 0.2, 0.3]), t.atoms[1])
    assert_equal("c01", t.comment)
  end

  def test_center_of_atoms
    # No atoms
    assert_raise(NoMethodError){ @c00.center_of_atoms }

    # Including atoms
    assert_raise(NoMethodError){ @c01.center_of_atoms }
  end

  def test_inverse_axis!
    @c02.inverse_axis!(0)
    t = @c02
    assert_equal(CrystalCell::PeriodicCell, t.class)
    assert_in_delta(t.axes[0][0],-2.0, $tolerance)
    assert_in_delta(t.axes[0][1],-2.0, $tolerance)
    assert_in_delta(t.axes[0][2],-2.0, $tolerance)
    assert_in_delta(t.axes[1][0], 0.0, $tolerance)
    assert_in_delta(t.axes[1][1], 2.0, $tolerance)
    assert_in_delta(t.axes[1][2], 2.0, $tolerance)
    assert_in_delta(t.axes[2][0], 0.0, $tolerance)
    assert_in_delta(t.axes[2][1], 0.0, $tolerance)
    assert_in_delta(t.axes[2][2], 2.0, $tolerance)
    assert_equal(2, t.atoms.size)
    # checking atom 0
    assert_equal('Li'           , t.atoms[0].element)
    assert_equal(Vector3DInternal[0.0, 0.0, 0.0], t.atoms[0].position)
    assert_equal(nil            , t.atoms[0].name)
    # checking atom 1
    assert_equal('O'            , t.atoms[1].element)
    assert_equal(Vector3DInternal[ 0.8, 0.2, 0.2], t.atoms[1].position)
    assert_equal(nil            , t.atoms[1].name)
  end


  def test_inverse_axis
    # x 軸反転
    t = @c02.inverse_axis(0)
    assert_equal(CrystalCell::PeriodicCell, t.class)
    assert_in_delta(t.axes[0][0],-2.0, $tolerance)
    assert_in_delta(t.axes[0][1],-2.0, $tolerance)
    assert_in_delta(t.axes[0][2],-2.0, $tolerance)
    assert_in_delta(t.axes[1][0], 0.0, $tolerance)
    assert_in_delta(t.axes[1][1], 2.0, $tolerance)
    assert_in_delta(t.axes[1][2], 2.0, $tolerance)
    assert_in_delta(t.axes[2][0], 0.0, $tolerance)
    assert_in_delta(t.axes[2][1], 0.0, $tolerance)
    assert_in_delta(t.axes[2][2], 2.0, $tolerance)
    assert_equal(2, t.atoms.size)
    # checking atom 0
    assert_equal('Li'           , t.atoms[0].element)
    assert_equal(Vector3DInternal[0.0, 0.0, 0.0], t.atoms[0].position)
    assert_equal(nil            , t.atoms[0].name)
    # checking atom 1
    assert_equal('O'            , t.atoms[1].element)
    assert_equal(Vector3DInternal[ 0.8, 0.2, 0.2], t.atoms[1].position)
    assert_equal(nil            , t.atoms[1].name)

    # y 軸反転
    # [ [ ax, ay, az], [  0, by, bz], [  0,  0, cz] ]
    # ↓  y 軸反転
    # [ [ ax, ay, az], [  0,-by,-bz], [  0,  0, cz] ]
    # ↓ b vector の y 成分が正になるようにする。
    #   すなわち z 軸回りに半回転し、全ての x, y 成分が反転する。
    # [ [-ax,-ay, az], [  0, by,-bz], [  0,  0, cz] ]
    t = @c02.inverse_axis(1)
    assert_equal(CrystalCell::PeriodicCell, t.class)
    assert_in_delta(t.axes[0][0],-2.0, $tolerance)
    assert_in_delta(t.axes[0][1],-2.0, $tolerance)
    assert_in_delta(t.axes[0][2], 2.0, $tolerance)
    assert_in_delta(t.axes[1][0], 0.0, $tolerance)
    assert_in_delta(t.axes[1][1], 2.0, $tolerance)
    assert_in_delta(t.axes[1][2],-2.0, $tolerance)
    assert_in_delta(t.axes[2][0], 0.0, $tolerance)
    assert_in_delta(t.axes[2][1], 0.0, $tolerance)
    assert_in_delta(t.axes[2][2], 2.0, $tolerance)
    assert_equal(2, t.atoms.size)
    # checking atom 0
    assert_equal('Li'           , t.atoms[0].element)
    assert_equal(Vector3DInternal[0.0, 0.0, 0.0], t.atoms[0].position)
    assert_equal(nil            , t.atoms[0].name)
    # checking atom 1
    assert_equal('O'            , t.atoms[1].element)
    assert_equal(Vector3DInternal[ 0.2, 0.8, 0.2], t.atoms[1].position)
    assert_equal(nil            , t.atoms[1].name)

    # z 軸反転
    # [ [ ax, ay, az], [  0, by, bz], [  0,  0, cz] ]
    # ↓ z 軸反転
    # [ [ ax, ay, az], [  0, by, bz], [  0,  0,-cz] ]
    # ↓ c vector の z 成分が正になるようにする。
    #   b vector の y 成分も正であることを保存する回転は、
    #   y 軸回りに半回転し、全ての x, z 成分が反転する。
    # [ [-ax, ay,-az], [  0, by,-bz], [  0,  0, cz] ]
    t = @c02.inverse_axis(2)
    assert_equal(CrystalCell::PeriodicCell, t.class)
    assert_in_delta(t.axes[0][0],-2.0, $tolerance)
    assert_in_delta(t.axes[0][1], 2.0, $tolerance)
    assert_in_delta(t.axes[0][2],-2.0, $tolerance)
    assert_in_delta(t.axes[1][0], 0.0, $tolerance)
    assert_in_delta(t.axes[1][1], 2.0, $tolerance)
    assert_in_delta(t.axes[1][2],-2.0, $tolerance)
    assert_in_delta(t.axes[2][0], 0.0, $tolerance)
    assert_in_delta(t.axes[2][1], 0.0, $tolerance)
    assert_in_delta(t.axes[2][2], 2.0, $tolerance)
    assert_equal(2, t.atoms.size)
    # checking atom 0
    assert_equal('Li'           , t.atoms[0].element)
    assert_equal(Vector3DInternal[0.0, 0.0, 0.0], t.atoms[0].position)
    assert_equal(nil            , t.atoms[0].name)
    # checking atom 1
    assert_equal('O'            , t.atoms[1].element)
    assert_equal(Vector3DInternal[ 0.2, 0.2, 0.8], t.atoms[1].position)
    assert_equal(nil            , t.atoms[1].name)
  end

  def test_exchange_axes!
    # b, c の交換。
    @c08.exchange_axes!([ 1, 2 ])
    t = @c08
    assert_equal(CrystalCell::PeriodicCell, t.class)
    lc = t.axes.get_lattice_constants
    assert_in_delta(2.0 * Math::sqrt(3.0) , lc[0], $tolerance)
    assert_in_delta(2.0                     , lc[1], $tolerance)
    assert_in_delta(2.0 * Math::sqrt(2.0) , lc[2], $tolerance)
    assert_in_delta(45.0000000000000, lc[3], $tolerance)
    assert_in_delta(35.2643896827547, lc[4], $tolerance)
    assert_in_delta(54.7356103172453, lc[5], $tolerance)
    assert_equal(true, t.axes.lefthand?)
    assert_equal(2, t.atoms.size)
    # checking atom 0
    assert_equal('Li'           , t.atoms[0].element)
    assert_equal(Vector3DInternal, t.atoms[0].position.class)
    assert_in_delta(0.2, t.atoms[0].position[0], $tolerance)
    assert_in_delta(0.6, t.atoms[0].position[1], $tolerance)
    assert_in_delta(0.4, t.atoms[0].position[2], $tolerance)
    assert_equal('atom0'        , t.atoms[0].name)
    assert_equal([ false, false, true] , t.atoms[0].movable_flags)
    # checking atom 1
    assert_equal('O'            , t.atoms[1].element)
    assert_equal(Vector3DInternal, t.atoms[1].position.class)
    assert_in_delta(0.8, t.atoms[1].position[0], $tolerance)
    assert_in_delta(0.4, t.atoms[1].position[1], $tolerance)
    assert_in_delta(0.6, t.atoms[1].position[2], $tolerance)
    assert_equal(nil            , t.atoms[1].name)
  end

  def test_exchange_axes
    assert_raise(CrystalCell::Cell::ArgumentError){ @c02.exchange_axes([ 0 ]) }
    assert_raise(CrystalCell::Cell::ArgumentError){ @c02.exchange_axes([ 0, 1, 2]) }
    assert_raise(CrystalCell::Cell::AxesRangeError){ @c02.exchange_axes([0, 3]) }
    assert_raise(CrystalCell::Cell::AxesRangeError){ @c02.exchange_axes([-1, 2]) }
    assert_raise(CrystalCell::Cell::SameAxesError){ @c02.exchange_axes([ 1,1]) }

    # b, c の交換。
    t = @c08.exchange_axes([ 1, 2 ])
    assert_equal(CrystalCell::PeriodicCell, t.class)
    lc = t.axes.get_lattice_constants
    assert_in_delta(2.0 * Math::sqrt(3.0) , lc[0], $tolerance)
    assert_in_delta(2.0                     , lc[1], $tolerance)
    assert_in_delta(2.0 * Math::sqrt(2.0) , lc[2], $tolerance)
    assert_in_delta(45.0000000000000, lc[3], $tolerance)
    assert_in_delta(35.2643896827547, lc[4], $tolerance)
    assert_in_delta(54.7356103172453, lc[5], $tolerance)
    assert_equal(true, t.axes.lefthand?)
    assert_equal(2, t.atoms.size)
    # checking atom 0
    assert_equal('Li'           , t.atoms[0].element)
    assert_equal(Vector3DInternal, t.atoms[0].position.class)
    assert_in_delta(0.2, t.atoms[0].position[0], $tolerance)
    assert_in_delta(0.6, t.atoms[0].position[1], $tolerance)
    assert_in_delta(0.4, t.atoms[0].position[2], $tolerance)
    assert_equal('atom0'        , t.atoms[0].name)
    # checking atom 1
    assert_equal('O'            , t.atoms[1].element)
    assert_equal(Vector3DInternal, t.atoms[1].position.class)
    assert_in_delta(0.8, t.atoms[1].position[0], $tolerance)
    assert_in_delta(0.4, t.atoms[1].position[1], $tolerance)
    assert_in_delta(0.6, t.atoms[1].position[2], $tolerance)
    assert_equal(nil            , t.atoms[1].name)

    # b, c の交換によって非破壊であることを確認。
    t = @c08
    assert_equal(CrystalCell::PeriodicCell, t.class)
    lc = t.axes.get_lattice_constants
    assert_in_delta(2.0 * Math::sqrt(3.0) , lc[0], $tolerance)
    assert_in_delta(2.0 * Math::sqrt(2.0) , lc[1], $tolerance)
    assert_in_delta(2.0                     , lc[2], $tolerance)
    assert_in_delta(45.0000000000000, lc[3], $tolerance)
    assert_in_delta(54.7356103172453, lc[4], $tolerance)
    assert_in_delta(35.2643896827547, lc[5], $tolerance)
    assert_equal(false, t.axes.lefthand?)
    assert_equal(2, t.atoms.size)
    # checking atom 0
    assert_equal('Li'           , t.atoms[0].element)
    assert_equal(Vector3DInternal, t.atoms[0].position.class)
    assert_in_delta(0.2, t.atoms[0].position[0], $tolerance)
    assert_in_delta(0.4, t.atoms[0].position[1], $tolerance)
    assert_in_delta(0.6, t.atoms[0].position[2], $tolerance)
    assert_equal('atom0'        , t.atoms[0].name)
    # checking atom 1
    assert_equal('O'            , t.atoms[1].element)
    assert_equal(Vector3DInternal, t.atoms[1].position.class)
    assert_in_delta(0.8, t.atoms[1].position[0], $tolerance)
    assert_in_delta(0.6, t.atoms[1].position[1], $tolerance)
    assert_in_delta(0.4, t.atoms[1].position[2], $tolerance)
    assert_equal(nil            , t.atoms[1].name)
  end

  def test_reflect!
    @c08.reflect!
    t = @c08
    assert_equal(CrystalCell::PeriodicCell, t.class)
    lc = t.axes.get_lattice_constants
    assert_in_delta(2.0 * Math::sqrt(3.0) , lc[0], $tolerance)
    assert_in_delta(2.0 * Math::sqrt(2.0) , lc[1], $tolerance)
    assert_in_delta(2.0                     , lc[2], $tolerance)
    assert_in_delta(45.0000000000000, lc[3], $tolerance)
    assert_in_delta(54.7356103172453, lc[4], $tolerance)
    assert_in_delta(35.2643896827547, lc[5], $tolerance)
    assert_equal(true, t.axes.lefthand?)
    assert_equal(2, t.atoms.size)
    # checking atom 0
    assert_equal('Li'           , t.atoms[0].element)
    assert_equal(Vector3DInternal, t.atoms[0].position.class)
    assert_in_delta(0.2, t.atoms[0].position[0], $tolerance)
    assert_in_delta(0.4, t.atoms[0].position[1], $tolerance)
    assert_in_delta(0.6, t.atoms[0].position[2], $tolerance)
    assert_equal('atom0'        , t.atoms[0].name)
    # checking atom 1
    assert_equal('O'            , t.atoms[1].element)
    assert_equal(Vector3DInternal, t.atoms[1].position.class)
    assert_in_delta(0.8, t.atoms[1].position[0], $tolerance)
    assert_in_delta(0.6, t.atoms[1].position[1], $tolerance)
    assert_in_delta(0.4, t.atoms[1].position[2], $tolerance)
    assert_equal(nil            , t.atoms[1].name)
  end

  def test_reflect
    t = @c08.reflect
    assert_equal(CrystalCell::PeriodicCell, t.class)
    lc = t.axes.get_lattice_constants
    assert_in_delta(2.0 * Math::sqrt(3.0) , lc[0], $tolerance)
    assert_in_delta(2.0 * Math::sqrt(2.0) , lc[1], $tolerance)
    assert_in_delta(2.0                     , lc[2], $tolerance)
    assert_in_delta(45.0000000000000, lc[3], $tolerance)
    assert_in_delta(54.7356103172453, lc[4], $tolerance)
    assert_in_delta(35.2643896827547, lc[5], $tolerance)
    assert_equal(true, t.axes.lefthand?)
    assert_equal(2, t.atoms.size)
    # checking atom 0
    assert_equal('Li'           , t.atoms[0].element)
    assert_equal(Vector3DInternal, t.atoms[0].position.class)
    assert_in_delta(0.2, t.atoms[0].position[0], $tolerance)
    assert_in_delta(0.4, t.atoms[0].position[1], $tolerance)
    assert_in_delta(0.6, t.atoms[0].position[2], $tolerance)
    assert_equal('atom0'        , t.atoms[0].name)
    # checking atom 1
    assert_equal('O'            , t.atoms[1].element)
    assert_equal(Vector3DInternal, t.atoms[1].position.class)
    assert_in_delta(0.8, t.atoms[1].position[0], $tolerance)
    assert_in_delta(0.6, t.atoms[1].position[1], $tolerance)
    assert_in_delta(0.4, t.atoms[1].position[2], $tolerance)
    assert_equal(nil            , t.atoms[1].name)

    # 非破壊であることを確認。
    t = @c08
    assert_equal(CrystalCell::PeriodicCell, t.class)
    lc = t.axes.get_lattice_constants
    assert_in_delta(2.0 * Math::sqrt(3.0) , lc[0], $tolerance)
    assert_in_delta(2.0 * Math::sqrt(2.0) , lc[1], $tolerance)
    assert_in_delta(2.0                     , lc[2], $tolerance)
    assert_in_delta(45.0000000000000, lc[3], $tolerance)
    assert_in_delta(54.7356103172453, lc[4], $tolerance)
    assert_in_delta(35.2643896827547, lc[5], $tolerance)
    assert_equal(true, t.axes.righthand?)
    assert_equal(2, t.atoms.size)
    # checking atom 0
    assert_equal('Li'           , t.atoms[0].element)
    assert_equal(Vector3DInternal, t.atoms[0].position.class)
    assert_in_delta(0.2, t.atoms[0].position[0], $tolerance)
    assert_in_delta(0.4, t.atoms[0].position[1], $tolerance)
    assert_in_delta(0.6, t.atoms[0].position[2], $tolerance)
    assert_equal('atom0'        , t.atoms[0].name)
    # checking atom 1
    assert_equal('O'            , t.atoms[1].element)
    assert_equal(Vector3DInternal, t.atoms[1].position.class)
    assert_in_delta(0.8, t.atoms[1].position[0], $tolerance)
    assert_in_delta(0.6, t.atoms[1].position[1], $tolerance)
    assert_in_delta(0.4, t.atoms[1].position[2], $tolerance)
    assert_equal(nil            , t.atoms[1].name)

  end

  # private

  def test_reset_positions_inside
    tmp = Marshal.load(Marshal.dump(@c00))
    tmp.add_atom(CrystalCell::Atom.new(0, [1.0, 2.3, -2.3]))
    tmp.atoms[0].set_position([1.0, 2.3, -2.3])
    tmp.reset_positions_inside
    assert_equal(1, tmp.positions.size)
    assert_equal(Vector3DInternal, tmp.positions[0].class)
    assert_in_delta(0.0, tmp.positions[0][0], $tolerance)
    assert_in_delta(0.3, tmp.positions[0][1], $tolerance)
    assert_in_delta(0.7, tmp.positions[0][2], $tolerance)
  end

  #undef test_directions_within_distance
  #undef test_nearest_direction
  #undef test_nearest_distance
  #undef test_find_bonds
  #undef test_pairs_within_distance
  #undef test_add_atom
  #undef test_rotate
  #undef test_rotate!
  #undef test_translate
  #undef test_translate!
  #undef test_to_cell
  #undef test_center_of_atoms
  #undef test_inverse_axis!
  #undef test_inverse_axis
  #undef test_exchange_axes!
  #undef test_exchange_axes
  #undef test_reflect!
  #undef test_reflect
  #undef test_reset_positions_inside

end

class TC_Cell_EXTENSION < Test::Unit::TestCase
  $tolerance = 10 ** (-10)

  def test_to_pcell
    c08 = CrystalCell::Cell.new([ [2.0, 2.0, 2.0], [0.0, 2.0, 2.0], [0.0, 0.0, 2.0] ])
    c08.add_atom(CrystalCell::Atom.new('Li', [ 1.2,  3.4,  5.6], "atom0", [ false, false, true]))
    c08.add_atom(CrystalCell::Atom.new('O', [-1.2, -3.4, -5.6]))
    c08.comment = 'c08'
    #
    t = c08.to_pcell
    assert_equal(CrystalCell::PeriodicCell, t.class)
    assert_equal(CrystalCell::LatticeAxes, t.axes.class)
    assert_in_delta(2.0, t.axes[0][0], $tolerance)
    assert_in_delta(2.0, t.axes[0][1], $tolerance)
    assert_in_delta(2.0, t.axes[0][2], $tolerance)
    assert_in_delta(0.0, t.axes[1][0], $tolerance)
    assert_in_delta(2.0, t.axes[1][1], $tolerance)
    assert_in_delta(2.0, t.axes[1][2], $tolerance)
    assert_in_delta(0.0, t.axes[2][0], $tolerance)
    assert_in_delta(0.0, t.axes[2][1], $tolerance)
    assert_in_delta(2.0, t.axes[2][2], $tolerance)
    #
    assert_equal(2, t.atoms.size)
    assert_equal(CrystalCell::Atom, t.atoms[0].class)
    assert_equal(CrystalCell::Atom, t.atoms[1].class)
    assert_in_delta(0.2, t.atoms[0].position[0], $tolerance)
    assert_in_delta(0.4, t.atoms[0].position[1], $tolerance)
    assert_in_delta(0.6, t.atoms[0].position[2], $tolerance)
    assert_in_delta(0.8, t.atoms[1].position[0], $tolerance)
    assert_in_delta(0.6, t.atoms[1].position[1], $tolerance)
    assert_in_delta(0.4, t.atoms[1].position[2], $tolerance)
    #
    assert_equal("atom0", t.atoms[0].name)
    assert_equal(nil    , t.atoms[1].name)
    #
    assert_equal([ false, false, true  ], t.atoms[0].movable_flags)
    assert_equal(nil, t.atoms[1].movable_flags)
    #
    assert_equal("c08", t.comment)

    # 破壊的でないことを確認。
    t = c08
    assert_equal(2, t.atoms.size)
    assert_equal(CrystalCell::Atom, t.atoms[0].class)
    assert_equal(CrystalCell::Atom, t.atoms[1].class)
    assert_in_delta( 1.2, t.atoms[0].position[0], $tolerance)
    assert_in_delta( 3.4, t.atoms[0].position[1], $tolerance)
    assert_in_delta( 5.6, t.atoms[0].position[2], $tolerance)
    assert_in_delta(-1.2, t.atoms[1].position[0], $tolerance)
    assert_in_delta(-3.4, t.atoms[1].position[1], $tolerance)
    assert_in_delta(-5.6, t.atoms[1].position[2], $tolerance)
  end

end
