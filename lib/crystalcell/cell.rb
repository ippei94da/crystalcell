#! /usr/bin/env ruby

require "pp"
require "matrix"

require "rubygems"
gem "builtinextension"
require "array_select_indices.rb"

gem "maset"
require "maset/mapping.rb"

#Class for crystal cell with lattice axes and atoms.
#Symmetry operations are not considered in this class.
#A sub class SymmetricCell can do, which overrides equal_in_delta methods.
#
#Written by Ippei Kishida [2010-12-19].
#
##Cell
#  セル内の原子は、内部的には配列として保持するが、
#  この順序は制御できないものとする。
#  たとえば Li, Ge, O の順序にソートされているなどと思ってはいけない。
#  順序に依存するプログラムを作ってはいけない。
#
##Note:
#Cell クラスは元素情報をネイティブには持たない
#  ボツ案:
#  たとえば構成元素の情報を持ち、
#  さらに Atom クラスインスタンスも持つとする。
#  原子の追加の仕方によっては、
#  Atoms クラスの元素情報と矛盾するという状況は十分に考えられる。
#
#  構成元素として Li があっても、
#  Li 原子リストが空リストだったらその元素はあると判定されるべきか、
#  疑問が生じる。
class CrystalCell::Cell

  include Mageo

  class NoAtomError < Exception; end
  class AxesMismatchError < Exception; end
  class AxesRangeError < Exception; end
  class SameAxesError < Exception; end
  class TypeError < Exception; end
  class ArgumentError < Exception; end #その他的エラー

  attr_reader :element_names, :atoms, :axes
  attr_accessor :comment

  #Argument 'axes' must have :to_a method and expressed in 3x3 Array.
  def initialize(axes, atoms = [])
    #raise CellTypeError unless axes.is_a?(Axes)
    if axes.class == CrystalCell::LatticeAxes
      @axes = axes
    else
      @axes = CrystalCell::LatticeAxes.new( axes.to_a )
    end

    atoms.each do |atom|
      #pp atom
      unless atom.is_a?(CrystalCell::Atom)
        raise CellTypeError,
          "#{atom} is not a kind of CrystalCell::Atom."
      end
    end
    @atoms = atoms
  end

  #セルに原子を追加する。
  def add_atom(atom)
    #raise "Cell::add_atom, 2nd argument must be Array." if pos.class != Array
    raise CellTypeError unless atom.is_a?(CrystalCell::Atom)
    @atoms << atom
  end

  #Delete an atom from a cell.
  #i は Cell クラスが保持している原子の番号。
  #Cell クラスは原子を配列として保持しており、
  #その番号を指定すると考えると分かり易かろう。
  def delete_atom( i )
    #raise "CrystalCell::Atom ID[#{i}] not exist" if @atoms[i] == nil
    @atoms.delete_at( i )
  end

  #全ての原子の元素情報のリストを返す。
  #unique なものを抽出したりはしない。
  #unique なものが必要なら返り値に .uniq をつければ良い。
  #e.g., #=> ['Li', 'N', 'Li']
  #e.g., #=> [0, 1, 2, 1]
  def elements
    @atoms.collect{ |i| i.element }
  end

  #全ての原子の位置情報のリストを返す。
  def positions
    @atoms.collect{ |i| i.position }
  end

  #元素情報が elem の原子の index を配列にまとめて返す。
  #index は原子の永続的な id ではない。
  #Array#select は index ではなく要素そのものを配列にして返すので、少し違う。
  def select_indices( &block )
    return @atoms.select_indices( &block )
  end

  #Set element name to each atom in self.
  #Argument 'elems' is a list of new names, which has [] method. e.g., 
  #  1. Array, [ 'Li', 'O' ]
  #  2. Hash , { 0 => 'Li', 1 => 'O' ]
  #  3. Hash , { 'Li' => 'Na' }
  #1. and 2. of the above examples induce the same result.
  #Case 1. can be convenient for element names of array from POTCAR.
  #
  #The atoms with the name which is not included the hash key do not change their names.
  def set_elements( elems )
    @atoms.each do |atom|
      begin
        new_elem = elems[ atom.element ]
      rescue
        next
      end
      next if new_elem == nil
      atom.element = new_elem
    end
  end

  #セルを拡張したスーパーセルを考えたとき、中に含まれる原子のリストを返す。
  #引数の意味は以下の通り。
  #a_min : a 軸方向のセルの方向を整数で示したときの最小値
  #a_max : a 軸方向のセルの方向を整数で示したときの最大値
  #b_min : b 軸方向のセルの方向を整数で示したときの最小値
  #b_max : b 軸方向のセルの方向を整数で示したときの最大値
  #c_min : c 軸方向のセルの方向を整数で示したときの最小値
  #c_max : c 軸方向のセルの方向を整数で示したときの最大値
  #-1, 1, -1, 1, -1, 1 と指定すれば 3x3x3 の 27倍体積の構造になる。
  def atoms_in_supercell( a_min, a_max, b_min, b_max, c_min, c_max )
    results = []
    @atoms.each do |atom|
      a_min.upto( a_max ) do |a|
        b_min.upto( b_max ) do |b|
          c_min.upto( c_max ) do |c|
            results << CrystalCell::Atom.new( atom.element, (atom.position.to_v3di + [ a, b, c ].to_v3di).to_a )
          end
        end
      end
    end
    results
  end

  #他のセルと格子定数が等価であれば true を、そうでなければ false を返す。
  #other: 他のセル
  #length_ratio: 長さ(a, b, c) の許容値を比で指定
  #angle_tolerance: 角度(alpha, beta, gamma) の許容値を角度の値で指定
  def equal_lattice_in_delta?( other, length_ratio, angle_tolerance )
    @axes.equal_in_delta?(
      CrystalCell::LatticeAxes.new( other.axes.to_a ), length_ratio, angle_tolerance
    )
  end

  #含まれる全原子が等価比較で一対一対応が付けられれば true を返す。
  #Cell に保持される順番に関係なく、等価な原子同士が一対一に対応づけられるかで
  #チェックする。
  def equal_atoms_in_delta?( other, position_tolerance )
    return false unless Mapping::map?(@atoms, other.atoms ){ |i,j| i.equal_in_delta?( j, position_tolerance ) }
    return true
  end

  #等価判定。
  #格子定数の長さの比率の許容値、格子定数の角度の許容値、原子座標の許容値。
  def equal_in_delta?( other, length_ratio, angle_tolerance, position_tolerance )
    return false unless equal_lattice_in_delta?(other, length_ratio, angle_tolerance)
    return false unless equal_atoms_in_delta?(other, position_tolerance)
    return true
  end

  #等価判定。
  #「==」による等価判定は実数の等価判定と同じく、基本的には使うべきではない。
  #しかし、これを定義しておくとテストが楽になることが多い。
  def ==( other )
    #pp axes;
    #pp other.axes;

    return false unless self.axes == other.axes #equal_in_delta( 0.0, 0.0, 0.0 ) とすると計算誤差でうまくいかないことがある。
    equal_atoms_in_delta?( other, 0.0 )
  end

  #2つの地点間の距離を返す。
  #それぞれ、内部座標 Vector3DInternal クラスインスタンスなら絶対座標に変換される。
  #絶対座標ならばそのまま計算する。
  #Vector3D か Vector3DInternal 以外のクラスなら例外 Cell::TypeError を投げる。
  #周期性を考慮したりはしない。
  #周期性を考慮した距離は PeriodicCell#nearest_distance で行うべき。
  def distance( pos0, pos1 )
    if ((pos0.class != Vector3DInternal) && (pos0.class != Vector3D))
      raise CrystalCell::Cell::TypeError
    end
    if ((pos1.class != Vector3DInternal) && (pos1.class != Vector3D))
      raise CrystalCell::Cell::TypeError
    end

    v0 = pos0.to_v3d(@axes) if pos0.class == Vector3DInternal
    v1 = pos1.to_v3d(@axes) if pos1.class == Vector3DInternal

    (v0 - v1).r
  end

  #Dump string in POSCAR format.
  #Argument <io> can be a file handle or nil.
  #POSCAR を作るには、元素の順番を指定する必要があるので
  #それを element_order で指定している。
  #element_order の要素と == で一致する CrystalCell::Atom instance を
  #それぞれ全て出力する。
  #e.g.,
  #  cell.dump_poscar( STDOUT ) #=> output to stdout.
  #  cell.dump_poscar( fileIo ) #=> output to file.
  #  cell.dump_poscar( nil ) #=> return in String instance.
  #  cell.dump_poscar        #=> return in String instance.
  def dump_poscar( element_order, io = nil )
    if (io == nil)
      return create_poscar( element_order )
    else
      io.puts create_poscar( element_order )
    end
  end

  #Cell rotation.( Destructive method)
  #Argument 'matrix' is 3x3 Array of float.
  #This method does not modify the position to the range between 0 and 1,
  #even if it was out of range.
  def rotate!( matrix )
    @atoms.each { |atom|
      old_pos = atom.position
      new_pos = [0.0, 0.0, 0.0]
      3.times do |y|
        3.times do |x|
          new_pos[y] += (matrix[y][x] * old_pos[x])
        end
      end
      atom.set_position( new_pos )
    }
  end

  #Cell rotation.( Nondestructive method)
  #Argument 'matrix' is 3x3 Array of float.
  #This method does not modify the position to the range between 0 and 1,
  #even if it was out of range.
  def rotate( matrix )
    t = Marshal.load( Marshal.dump( self ) )
    t.rotate!( matrix )
    return t
  end

  #並進移動を行う破壊的メソッド。
  #ary は Float 3 要素の配列。
  def translate!( ary )
    @atoms.each { |atom| atom.translate!( ary ) }
  end

  #並進移動を行う非破壊的メソッド。
  #ary は Float 3 要素の配列。
  def translate( ary )
    t = Marshal.load( Marshal.dump( self ) )
    t.translate!( ary )
    return t
  end

  #Return arithmetic mean of atomic positions in an internal coordinates.
  #Raise 'Cell::NoAtomError' if no atoms included in self.
  def center_of_atoms
    raise CrystalCell::Cell::NoAtomError if @atoms.size == 0

    vec = Vector3DInternal[ 0.0, 0.0, 0.0 ]
    @atoms.each { |i|
      3.times { |j| vec[j] += i.position[j] }
    }
    vec *= 1.0/ @atoms.size
  end

  #Calculate volume.
  def calc_volume
    axes = @axes.to_a.map { |i| Vector3D[*i] }
    vA, vB, vC = axes[0..2]
    Vector3D.scalar_triple_product( vA, vB, vC ).abs
  end

  #Generate a new cell with the same lattice consants,
  #containing atoms of indicated elements.
  #Argument 'elems' must be an array of element names.
  #含まれる @atoms の順序は、保存される。元素ごとに並び換えたりしない。
  #CrystalCell::Atom.element が elems の要素のどれかと完全一致しているもののみ対象となる。
  #サブクラスのインスタンスで実行した場合には、
  #サブクラスのインスタンスとして生成する。
  def cell_of_elements( elems )
    result = self.class.new( @axes )
    @atoms.each do |atom|
      result.add_atom(atom) if elems.include?( atom.element )
    end
    return result
  end

  #格子定数の同じ2つのセルを合わせて、全ての原子が含まれる1つのセルを返す
  #非破壊的メソッド。
  #2つのセルの格子定数が異なれば例外 Cell::AxesMismatchError を発生させる。
  #内部的には @atoms はレシーバの @atoms のあとに引数の @atoms を追加した形になる。
  #comment は空文字になる。
  #原子座標の重複チェックなどは行わない。
  def unite( cell )
    #raise Cell::AxesMismatchError unless @axes == cell.axes
    result = Marshal.load( Marshal.dump( self ) )
    cell.atoms.each do |atom|
      result.add_atom(atom)
    end
    return result
  end

  #任意の格子軸のベクトルを反転する破壊的メソッド。
  #大まかなイメージとしては、
  #格子軸の原点をセルを構成する8つの頂点のどれかに移動する操作と考えれば良い。
  #  ただし厳密には、格子ベクトルは LatticeAxes.new によって triangulate されるため、
  #  b 軸を反転させた時は a 軸も反転する。( b 軸の y成分を正にするため)
  #  c 軸を反転させた時は a, b 軸も反転する。( c 軸の z成分を正にするため)
  #セルの形状、内部のモチーフは保存する。
  #原子の絶対座標は移動せず、内部座標の表現が変わる。
  #引数 axis_id は 0, 1, 2 のいずれかの値を取り、それぞれ x, y, z軸を表す。
  #x, y, z軸の関係は、右手系と左手系が入れ替わる。
  def inverse_axis!( axis_id )
    axis_id = axis_id.to_i
    raise CrystalCell::Cell::AxesRangeError if ( axis_id < 0 || 2 < axis_id )

    axes = []
    3.times do |i|
      if ( i == axis_id )
        axes << @axes[ i ] * (-1.0)
      else
        axes << @axes[ i ]
      end
    end
    @axes = CrystalCell::LatticeAxes.new( axes ) 

    atoms = []
    @atoms.each do |atom|
      position = []
      3.times do |i|
        if i == axis_id
          position[i] = atom.position[i] * (-1)
        else
          position[i] = atom.position[i]
        end
      end
      atom.position = Vector3DInternal[*position]
    end
  end

  #def inverse_axis!( axis_id )
  #axis_id = axis_id.to_i
  #raise Cell::AxesRangeError if ( axis_id < 0 || 2 < axis_id )

  #axes = []
  #3.times do |i|
  #  if ( i == axis_id )
  #    axes << @axes[ i ] * (-1.0)
  #  else
  #    axes << @axes[ i ]
  #  end
  #end
  #@axes = CrystalCell::LatticeAxes.new( axes ) 

  #atoms = []
  #@atoms.each do |atom|
  #  position = []
  #  3.times do |i|
  #    if i == axis_id
  #      position[i] = atom.position[i] * (-1)
  #    else
  #      position[i] = atom.position[i]
  #    end
  #  end
  #  atom.position
  #  atoms << CrystalCell::Atom.new( atom.element, position, atom.name, atom.movable_flags )
  #end
  #@atoms = atoms
  #end

  #inverse_axis! の非破壊版。
  def inverse_axis( axis_id )
    result = Marshal.load( Marshal.dump( self ) )
    result.inverse_axis!( axis_id )
    return result
  end

  #2つの格子ベクトルを交換する破壊的メソッド。
  #Argument 'axis_ids' must have 2 items of integer.
  #0, 1, and 2 mean x, y, and z axes, respectively.
  #この範囲の整数でなければ例外 Cell::AxesRangeError.
  #axis_ids に含まれる 2つの数字が同じならば
  #例外 Cell::SameAxesError.
  def exchange_axes!( axis_ids )
    raise ArgumentError if axis_ids.size != 2
    axis_ids.each{ |i| raise AxesRangeError if ( i < 0 || 2 < i ) }
    raise CrystalCell::Cell::SameAxesError if ( axis_ids[0] == axis_ids[1] )

    #格子定数を交換。
    axes = @axes.axes
    axes[ axis_ids[0]], axes[ axis_ids[1]] = axes[ axis_ids[1]], axes[ axis_ids[0]]
    @axes = CrystalCell::LatticeAxes.new( axes )

    #内部座標を交換。
    new_atoms = []
    @atoms.each do |atom|
      new_pos = atom.position
      new_pos[ axis_ids[0]], new_pos[ axis_ids[1]] =
        new_pos[ axis_ids[1]], new_pos[ axis_ids[0]]
      new_atoms << CrystalCell::Atom.new( atom.element, new_pos, atom.name, atom.movable_flags )
    end
  end

  #exchange_axes! の非破壊版。
  def exchange_axes( axis_ids )
    result = Marshal.load( Marshal.dump( self ) )
    result.exchange_axes!( axis_ids )
    return result
  end

  #鏡像となるセルに変換する破壊的メソッド。
  def reflect!
    axes = @axes.to_a
    axes[0][0] *= -1
    @axes = CrystalCell::LatticeAxes.new( axes )
  end

  #鏡像となるセルに変換する非破壊的メソッド。
  def reflect
    result = Marshal.load( Marshal.dump( self ) )
    result.reflect!
    return result
  end

  #rotation と translation からなる操作(e.g., 対称操作)
  #を加えたセルを返す。
  def operate(rotation, translation)
    rotation = Matrix[*rotation]
    translation = translation.to_v3d
    new_atoms = atoms.map do |atom|
      position = atom.position.to_v3d([
        [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0],
      ])
      new_pos = (rotation * position + translation).to_a.to_v3di
      CrystalCell::Atom.new(atom.element, new_pos, atom.name)
    end
    CrystalCell::Cell.new(@axes, new_atoms)
  end

  #Return information of axes symmetry.
  #E.g., 
  # [true , true , true ] when  a = b  = c, like cubic
  # [true , false, false] when  a = b != c, like hexagonal, trigonal, tetragonal
  # [false, true , false] (same as above)
  # [false, false, true ] (same as above)
  # [false, false, false] when  a != b != c, like triclinic, monoclinic, orthorhombic
  def independent_axes
    begin
      require "getspg.so"
    rescue LoadError
      raise LoadError,
        "LoadError: 'spglib' seems not to be installed into the system."
    end

  end

  private

  #POSCAR の内容の文字列を生成。
  #文字列の配列ではなく、改行文字を含む1つの文字列である点に注意。
  #
  #VASP の挙動として、Selective dynamics 指定ありの時に
  #原子に T or F 指定していなかったり 3要素に足りなかったりすれば、
  #error となって実行されない。
  #なので dump_poscar では Selective dynamics 指定が必要な時には
  #全ての原子に T/F を記述する。
  #POSCAR から生成された Cell の場合は Selective dynamics がついていれば
  #全ての原子に 3つの T/F が付いていることを前提としても良いだろう。
  #原子を追加するとかで、一部の原子の movable_flags が nil になっているときは、
  #デフォルト値として [ true, true, true ] を入れることにする。
  #nil ならば false を連想すると思うが、敢えて true で埋めている理由は、
  #Selective dynamics をつけていない状態で VASP は全方向に緩和する、
  #すなわち T T T と指定したことと同じになっているから。
  #換言すればこのデフォルト値の設定は VASP に合わせた仕様ということになる。
  #VASP に由来する仕様が Cell クラスに持ち込まれていることになるが、
  #VASP へのインターフェイスである POSCAR ファイルへの書き出しに限定されるので
  #他への影響はほとんどなく、気にしなくて良いだろう。
  def create_poscar( element_order )
    #element_order と elements が一対一対応していなければ raise 
    raise "Cell::create_poscar, element_order mismatches to elements." if (! Mapping::map?( elements.uniq, element_order ){ |i, j| i == j } )

    results = []
    results << @comment
    results << "1.0" #scale
    3.times do |i|
      results << sprintf( "%20.14f  %20.14f  %20.14f", @axes[i][0], @axes[i][1], @axes[i][2]
      )
    end

    ##collect information
    elem_list = Hash.new
    element_order.each do |elem|
      elem_list[ elem ] = @atoms.select{ |atom| atom.element == elem }
    end

    ##numbers of element atoms
    tmp = ''
    element_order.each do |elem|
      tmp += "  #{elem_list[elem].size.to_s}"
    end
    results << tmp

    ##Selective dynamics
    ##どれか1つでも getMovableFlag が真であれば Selective dynamics をオンにする
    selective_dynamics = false
    @atoms.each do |atom|
      if atom.movable_flags
        selective_dynamics = true
        results << "Selective dynamics"
        break
      end
    end

    element_order.each do |elem|
      elem_list[ elem ].each do |atom|
        if atom.movable_flags
          selective_dynamics = true
          break
        end
      end
      break if selective_dynamics
    end

    results << "Direct"  #now, Direct only

    ##positions of atoms
    element_order.each do |elem|
      elem_list[ elem ].each do |atom|
        tmp =  sprintf( "%20.14f  %20.14f  %20.14f", * atom.position )
        if selective_dynamics
          if atom.movable_flags == nil
            tmp += " T T T"
          else
            atom.movable_flags.each do |mov|
              ( mov == true ) ?  tmp += " T" : tmp += " F"
            end
          end
        end
        results << tmp
      end
    end

    results.join("\n")
  end

end
