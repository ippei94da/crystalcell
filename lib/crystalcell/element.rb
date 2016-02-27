#
# 元素(原子種)に関する情報を集めたクラス
# 基本理念として、原子番号を最もネイティブなデータとして ID 付けをする。
# 原子番号は人間がいなかったとしてもそれで区分できるが、
# 原子記号は人間がつけたものだから。
#
class CrystalCell::Element
    # 全データを生成しておく。
    def initialize
        #原子記号, 原子番号, 周期, 族, 質量数(平均), イオン半径
        #i =     1; @symbol[i], @mass[i], @radius[i] = 'H', 1.008, nil
        @symbol = [nil]
        @symbol += %w( H He
          Li Be B  C  N O F  Ne
          Na Mg Al Si P S Cl Ar
          K  Ca Sc Ti V  Cr Mn Fe Co Ni Cu Zn Ga Ge As Se Br Kr
          Rb Sr Y  Zr Nb Mo Tc Ru Rh Pd Ag Cd In Sn Sb Te I  Xe
          Cs Ba La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu
            Hf Ta W Re Os Ir Pt Au Hg Tl Pb Bi Po At Rn
          Fr Ra Ac Th Pa U Np Pu Am Cm Bk Cf Es Fm Md No Lr
        )
    end

    # 原子記号から原子番号を取得。e.g., H から 1
    # 与えられたものが原子番号ならそのまま返す、ようにしたいがまだできてない。
    # リストに存在しなければ raise する。
    def getAtomicNumber( name )
        symbol = @symbol.index( name )
        raise "Symbol #{name} not found." if (symbol == nil || symbol == 0)
        symbol
    end

    # 原子番号から原子記号を取得。e.g., 1 から H
    # 与えられたものが原子記号ならそのまま返す、ようにしたいがまだできてない。
    # リストに存在しなければ raise する。
    def getSymbol( num )
        raise "getSymbol(num) requires Fixnum, but #{num}" if (num.class != Fixnum)
        raise "Atomic number is out of range." if (num <= 0 || @symbol.size <= num)
        @symbol[num]
    end

    # 引数 id がリストに含まれているか？
    # id は原子番号でも原子記号でも可にしたいが、とりあえず symbol だけ。
    def include?( symbol )
        return false if symbol == nil
        @symbol.include?( symbol )
    end

    ##
    #def getRadius
    #end

end
