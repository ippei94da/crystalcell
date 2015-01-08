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
        @symbol = Array.new #; @mass = Array.new @radius = Array.new
        #i =     1; @symbol[i], @mass[i], @radius[i] = 'H', 1.008, nil
        i =     0; @symbol[i] = nil
        i =     1; @symbol[i] = 'H'
        i =     2; @symbol[i] = 'He'
        i =     3; @symbol[i] = 'Li'
        i =     4; @symbol[i] = 'Be'
        i =     5; @symbol[i] = 'B'
        i =     6; @symbol[i] = 'C'
        i =     7; @symbol[i] = 'N'
        i =     8; @symbol[i] = 'O'
        i =     9; @symbol[i] = 'F'
        i =  10; @symbol[i] = 'Ne'
        i =  11; @symbol[i] = 'Na'
        i =  12; @symbol[i] = 'Mg'
        i =  13; @symbol[i] = 'Al'
        i =  14; @symbol[i] = 'Si'
        i =  15; @symbol[i] = 'P'
        i =  16; @symbol[i] = 'S'
        i =  17; @symbol[i] = 'Cl'
        i =  18; @symbol[i] = 'Ar'
        i =  19; @symbol[i] = 'K'
        i =  20; @symbol[i] = 'Ca'
        i =  21; @symbol[i] = 'Sc'
        i =  22; @symbol[i] = 'Ti'
        i =  23; @symbol[i] = 'V'
        i =  24; @symbol[i] = 'Cr'
        i =  25; @symbol[i] = 'Mn'
        i =  26; @symbol[i] = 'Fe'
        i =  27; @symbol[i] = 'Co'
        i =  28; @symbol[i] = 'Ni'
        i =  29; @symbol[i] = 'Cu'
        i =  30; @symbol[i] = 'Zn'
        i =  31; @symbol[i] = 'Ga'
        i =  32; @symbol[i] = 'Ge'
        i =  33; @symbol[i] = 'As'
        i =  34; @symbol[i] = 'Se'
        i =  35; @symbol[i] = 'Br'
        i =  36; @symbol[i] = 'Kr'
        i =  37; @symbol[i] = 'Rb'
        i =  38; @symbol[i] = 'Sr'
        i =  39; @symbol[i] = 'Y'
        i =  40; @symbol[i] = 'Zr'
        i =  41; @symbol[i] = 'Nb'
        i =  42; @symbol[i] = 'Mo'
        i =  43; @symbol[i] = 'Tc'
        i =  44; @symbol[i] = 'Ru'
        i =  45; @symbol[i] = 'Rh'
        i =  46; @symbol[i] = 'Pd'
        i =  47; @symbol[i] = 'Ag'
        i =  48; @symbol[i] = 'Cd'
        i =  49; @symbol[i] = 'In'
        i =  50; @symbol[i] = 'Sn'
        i =  51; @symbol[i] = 'Sb'
        i =  52; @symbol[i] = 'Te'
        i =  53; @symbol[i] = 'I'
        i =  54; @symbol[i] = 'Xe'
        i =  55; @symbol[i] = 'Cs'
        i =  56; @symbol[i] = 'Ba'
        i =  57; @symbol[i] = 'La'
        i =  58; @symbol[i] = 'Ce'
        i =  59; @symbol[i] = 'Pr'
        i =  60; @symbol[i] = 'Nd'
        i =  61; @symbol[i] = 'Pm'
        i =  62; @symbol[i] = 'Sm'
        i =  63; @symbol[i] = 'Eu'
        i =  64; @symbol[i] = 'Gd'
        i =  65; @symbol[i] = 'Tb'
        i =  66; @symbol[i] = 'Dy'
        i =  67; @symbol[i] = 'Ho'
        i =  68; @symbol[i] = 'Er'
        i =  69; @symbol[i] = 'Tm'
        i =  70; @symbol[i] = 'Yb'
        i =  71; @symbol[i] = 'Lu'
        i =  72; @symbol[i] = 'Hf'
        i =  73; @symbol[i] = 'Ta'
        i =  74; @symbol[i] = 'W'
        i =  75; @symbol[i] = 'Re'
        i =  76; @symbol[i] = 'Os'
        i =  77; @symbol[i] = 'Ir'
        i =  78; @symbol[i] = 'Pt'
        i =  79; @symbol[i] = 'Au'
        i =  80; @symbol[i] = 'Hg'
        i =  81; @symbol[i] = 'Tl'
        i =  82; @symbol[i] = 'Pb'
        i =  83; @symbol[i] = 'Bi'
        i =  84; @symbol[i] = 'Po'
        i =  85; @symbol[i] = 'At'
        i =  86; @symbol[i] = 'Rn'
        i =  87; @symbol[i] = 'Fr'
        i =  88; @symbol[i] = 'Ra'
        i =  89; @symbol[i] = 'Ac'
        i =  90; @symbol[i] = 'Th'
        i =  91; @symbol[i] = 'Pa'
        i =  92; @symbol[i] = 'U'
        i =  93; @symbol[i] = 'Np'
        i =  94; @symbol[i] = 'Pu'
        i =  95; @symbol[i] = 'Am'
        i =  96; @symbol[i] = 'Cm'
        i =  97; @symbol[i] = 'Bk'
        i =  98; @symbol[i] = 'Cf'
        i =  99; @symbol[i] = 'Es'
        i = 100; @symbol[i] = 'Fm'
        i = 101; @symbol[i] = 'Md'
        i = 102; @symbol[i] = 'No'
        i = 103; @symbol[i] = 'Lr'
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
