#! /usr/bin/env ruby

# Class for crystal cell with periodic boundary.
# Coordinates of atoms are kept in the region of 0 <= x_i < 1 of internal coordinate.
class CrystalCell::PeriodicCell < CrystalCell::Cell

  class TypeError < Exception; end

  def initialize( *args )
    super( *args )
    reset_positions_inside
  end

  #ある内部座標から、別のある座標とそれと周期的に等価な座標への距離が
  #tolerance 以下のものを探し、条件を満たすセルの方向を配列にまとめて返す。
  #
  #内部的に、一度 0以上1未満の座標に変換しようかと思ったが、
  #境界付近で問題が生じうる。
  #
  #周囲 27 セルしか考慮しない。
  #美しさを求めるならば tolerance を完全に含む大きさのスーパーセルにすべきだが、
  #実装が面倒なわりに滅多に使われることがなさそうなので。
  #出力の順番は、上位の要素が小さなものから順。
  #(距離の短いものから順という考え方もなくはないが。)
  #
  #tolerance を省略( = nil を与えれば )、27セルの中にある全ての方向を返す。
  def directions_within_distance( pos0, pos1, tolerance = nil )
    if pos0.class != Vector3DInternal
      raise TypeError, "pos0 is not a Vector3DInternal class instance."
    end
    if pos1.class != Vector3DInternal
      raise TypeError, "pos1 is not a Vector3DInternal class instance."
    end

    pos0 = pos0.map{ |i| i - i.floor }.to_a.to_v3di
    pos1 = pos1.map{ |i| i - i.floor }.to_a.to_v3di

    results = []
    (-1).upto(1) do |x|
      (-1).upto(1) do |y|
        (-1).upto(1) do |z|
          shift = Vector3DInternal[ x.to_f, y.to_f, z.to_f ]
          d = distance( pos0, ( pos1 + shift))
          #tolerance が nil ならば距離判定なしで登録。
          #tolerance が非 nil ならばその値で距離判定して登録。
          if ( ( ! tolerance ) || ( d < tolerance ) )
            results << [ x, y, z]
          end
        end
      end
    end
    return results
  end

  # 周期性を考慮して、
  # 1個目の内部座標( pos0 ) から見て、
  # 一番近い 2個目の内部座標に等価なサイトの属するセルの方向を返す。
  # 返り値は Vector3DInternal で
  # 内部座標が 0.0 <= r < 1.0 になっていることを前提とする。
  # (なお、この外側であってもこの範囲に入るように周期移動する。)
  # 座標 0.0 付近の境界は計算誤差の為におかしなことになり易いので注意が必要。
  #
  # NOTE: nearest_direction というメソッド名はどうかと思う。
  # nearest_lattice_vector とか？
  # 良い名前があれば、リファクタリング対象。
  #
  # NOTE: 0〜1の外側なら内側に入れる、という処理は混乱し易い。
  # 例外にした方が良いのではないだろうか。
  def nearest_direction( pos0, pos1 )
    if pos0.class != Vector3DInternal
      raise TypeError,
      "pos0.class is not a Vector3DInternal"
    end
    if pos1.class != Vector3DInternal
      raise TypeError,
      "pos1.class is not a Vector3DInternal"
    end

    pos0 = pos0.map{ |i| i - i.floor }.to_a.to_v3di
    pos1 = pos1.map{ |i| i - i.floor }.to_a.to_v3di

    #set first value
    min = distance( pos0, pos1 )
    result = Vector3DInternal[ 0, 0, 0 ]

    #find
    (-1).upto(1) do |x|
      (-1).upto(1) do |y|
        (-1).upto(1) do |z|
          shift = Vector3DInternal[ x.to_f, y.to_f, z.to_f ]
          d = (pos0 - (pos1 + shift)).to_v3d(@axes).r

          if d < min
            result = Vector3DInternal[ x, y, z]
            min = d
          end
        end
      end
    end
    return result
  end

  #周期性を考慮し、2つの地点間の最短距離を返す。
  #pos0, pos1 には内部座標を指定する。
  #内部的には周囲 3x3x3 のセル中の27地点のうち最も近いものを得る。
  #旧 minimum_distance
  def nearest_distance( pos0, pos1 )
    [pos0, pos1].each_with_index do |pos, index|
      unless pos.class == Vector3DInternal
        raise TypeError,
        "#{index} th argument: #{pos.inspect}, #{pos.class}"
      end
    end

    pos0 = Vector3DInternal[* pos0.map{ |i| i - i.floor }]
    pos1 = Vector3DInternal[* pos1.map{ |i| i - i.floor }]
    direction = self.nearest_direction( pos0, pos1 )
    3.times do |i|
      pos1[ i ] += direction[ i ]
    end
    distance( pos0, pos1 )
  end

  #条件にマッチした原子間距離を見つけて、端点の内部座標の組を要素とする配列を返す。
  #返される配列は3重配列になる。
  #e.g.,
  # [
  #       [ [0.1, 0.1, 0.1], [0.2, 0.2, 0.2] ],
  #       [ [0.1, 0.1, 0.1], [0.3, 0.4, 0.5] ],
  #       [ [0.9, 0.9, 0.9], [0.8, 0.8, 0.8] ]
  # ]
  #@bonds への登録はしない。
  #elem0, elem1 は bond の両端の原子の組み合わせを指定。
  #elem0, elem1 はメソッド内部で反転したものもチェックするので、順序が反対でも同じ結果になる。
  #O-O のように同じ元素を指定することもでき、
  #この場合向きの異なる 2つの bond が重複したりしない。
  #d_min, d_max は距離の範囲を指定する。
  #境界値そのものが問題になることは少ないだろう。
  #d_min <= d <= d_max(以上、以下) としておくが、計算誤差のためにこれはほぼ無意味だ。
  #見つけて配列として返すだけで、登録はしない。
  #
  #以下の案は棄却。
  # - いかなる元素でもマッチ。
  # - 距離の上限を無効。
  #理由は、
  # - プログラムが煩雑になる。
  # - 引数の型が統一されない。
  # - ほとんど使用する機会がなさそう。
  #       大抵は元素を指定するし、元素を指定しない bond を描く状況は考えにくい。
  #       これが必要ならメソッドの外で組み合わせを作ってそれぞれで呼べば良い。
  # - 大抵は距離の上限を定めるし、上限なしではハリネズミになるだけ。
  #       また、プログラム上は距離の上限を 3x3x3 スーパーセルに制限したりするが、
  #       論理的に距離の上限なしってのは無限のセルを対象にすることになり、整合性がとれない。
  def find_bonds( elem0, elem1, d_min, d_max )
    results = []
    atoms.each do |inner_atom|
      atoms_in_supercell( -1, 1, -1, 1, -1, 1 ).each do |outer_atom|
        #元素の種類による判定
        ie = inner_atom.element
        oe = outer_atom.element

        next unless ( (( ie == elem0 ) && ( oe == elem1 )) || (( ie == elem1 ) && ( oe == elem0 ))) #elem0, elem1 と同じ構成
        #next unless (( ie == elem0 ) && ( oe == elem1 )) #elem0, elem1 と同じ構成

        #距離による判定
        ip = inner_atom.position
        op = outer_atom.position
        next if distance( ip, op ) < d_min.to_f
        next if distance( ip, op ) > d_max.to_f
        next if distance( ip, op ) == 0.0 ## Check identical site

        #重複判定, 正順か逆順が既に含まれていれば無視。
        next if ( results.include?( [ ip, op ] ) || results.include?( [ op, ip ] ) )
        if (ie == elem0)
          results << [ ip, op ]
        else
          results << [ op, ip ]
        end

      end
    end
    return results
  end

  #引数 distance 以下の間の距離にある原子のペアを列挙して返す。
  #この際、あくまで unique なものを返し、A-B があれば B-A はリストに含まれない。
  #
  #返す形式は以下のような形式。
  #[ [0, 1, [0, 0, 0], [0, 1, [0, 0, 1] ]
  #最初の 0, 1 はそれぞれ配列 @atoms 内の番号で、
  #0番目の原子からから同じセル内の 1番目の原子
  #0番目の原子からから[0,0,1]方向に隣接するセル内の 1番目の原子を意味する。
  #起点となる原子の番号と(上記 0 )と目的地の原子の番号(上記 1)が同じこともありうる。
  #異なる場合は起点となる原子の番号が、目的地の原子の番号より若くなる。
  #
  #自分と同じ番号の場合は、同じセルを除外する。
  #すなわち、[0, 0, [0, 0, 0] や [1, 1, [0, 0, 0] は含まれない。
  def pairs_within_distance( distance )
    results = []
    n_atom = @atoms.size
    n_atom.times do |i|
      pos_i = @atoms[i].position

      n_atom.times do |j|
        pos_j = @atoms[j].position

        directions_within_distance( pos_i, pos_j, distance ).each do |dir|
          #next if ( i==j && dir==[0,0,0] ) #距離0の自分自身。下の条件に含まれる。
          next if ( dir==[0,0,0] && i >= j ) #同じセル内は番号が若い方からのみ。
          results << [ i, j, dir ]
        end
      end
    end
    return results
  end

  # Functions as like CrystalCell::Cell.add_atom, but the coordinates are converted to the region of 0 <= x_i < 1.
  def add_atom( *args )
    super( *args )
    reset_positions_inside
  end

  # Functions as like CrystalCell::Cell.rotate!, but the coordinates are converted to the region of 0 <= x_i < 1.
  # Dependent function 'rotate' functions the same.
  def rotate!( *args )
    super( *args )
    reset_positions_inside
  end

  # Functions as like CrystalCell::Cell.translate!, but the coordinates are converted to the region of 0 <= x_i < 1.
  # Dependent function 'translate' functions the same.
  def translate!( *args )
    super( *args )
    reset_positions_inside
  end

  # Return a new instance converted to CrystalCell::Cell class.
  def to_cell
    tmp = CrystalCell::Cell.new( @axes.to_a )
    tmp.comment = self.comment
    @atoms.each do |atom|
      tmp.add_atom(atom)
    end
    return tmp
  end

  #undef center_of_atoms

  # superclass の inverse_axis! を行ったあと、
  # 原子の座標をセル内部に移す。
  def inverse_axis!( axis_id )
    #result = Marshal.load( Marshal.dump( self ) )
    super( axis_id )
    reset_positions_inside
  end

  private

  # Reset internal coordinates of all atoms inside the region of 0 <= x_i < 1.
  def reset_positions_inside
    @atoms.each do |atom|
      coords = atom.position
      atom.set_position(coords.map {|coord| coord - coord.floor}.to_a.to_v3di)
    end
  end

end

class CrystalCell::Cell
  #require "Crystal/PeriodicCell.rb"
  # Return a new instance converted to PeriodicCell class.
  def to_pcell
    atoms = Marshal.load(Marshal.dump(@atoms))
    result = CrystalCell::PeriodicCell.new( @axes.to_a, atoms )
    result.comment = self.comment
    return result
  end
end
