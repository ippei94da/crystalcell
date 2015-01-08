#! /usr/bin/ruby

require "helper"

class TC_Element < Test::Unit::TestCase
    def setup
        @e = CrystalCell::Element.new
    end

    def test_atomicNumber
        assert_equal(    1, @e.getAtomicNumber( 'H'  ))
        assert_equal(    2, @e.getAtomicNumber( 'He' ))
        assert_equal(    3, @e.getAtomicNumber( 'Li' ))
        assert_equal(    4, @e.getAtomicNumber( 'Be' ))
        assert_equal(    5, @e.getAtomicNumber( 'B'  ))
        assert_equal(    6, @e.getAtomicNumber( 'C'  ))
        assert_equal(    7, @e.getAtomicNumber( 'N'  ))
        assert_equal(    8, @e.getAtomicNumber( 'O'  ))
        assert_equal(    9, @e.getAtomicNumber( 'F'  ))
        assert_equal( 10, @e.getAtomicNumber( 'Ne' ))
        assert_equal( 11, @e.getAtomicNumber( 'Na' ))
        assert_equal( 12, @e.getAtomicNumber( 'Mg' ))
        assert_equal( 13, @e.getAtomicNumber( 'Al' ))
        assert_equal( 14, @e.getAtomicNumber( 'Si' ))
        assert_equal( 15, @e.getAtomicNumber( 'P'    ))
        assert_equal( 16, @e.getAtomicNumber( 'S'    ))
        assert_equal( 17, @e.getAtomicNumber( 'Cl' ))
        assert_equal( 18, @e.getAtomicNumber( 'Ar' ))
        assert_equal( 19, @e.getAtomicNumber( 'K'    ))
        assert_equal( 20, @e.getAtomicNumber( 'Ca' ))
        assert_equal( 21, @e.getAtomicNumber( 'Sc' ))
        assert_equal( 22, @e.getAtomicNumber( 'Ti' ))
        assert_equal( 23, @e.getAtomicNumber( 'V'    ))
        assert_equal( 24, @e.getAtomicNumber( 'Cr' ))
        assert_equal( 25, @e.getAtomicNumber( 'Mn' ))
        assert_equal( 26, @e.getAtomicNumber( 'Fe' ))
        assert_equal( 27, @e.getAtomicNumber( 'Co' ))
        assert_equal( 28, @e.getAtomicNumber( 'Ni' ))
        assert_equal( 29, @e.getAtomicNumber( 'Cu' ))
        assert_equal( 30, @e.getAtomicNumber( 'Zn' ))
        assert_equal( 31, @e.getAtomicNumber( 'Ga' ))
        assert_equal( 32, @e.getAtomicNumber( 'Ge' ))
        assert_equal( 33, @e.getAtomicNumber( 'As' ))
        assert_equal( 34, @e.getAtomicNumber( 'Se' ))
        assert_equal( 35, @e.getAtomicNumber( 'Br' ))
        assert_equal( 36, @e.getAtomicNumber( 'Kr' ))
        assert_equal( 37, @e.getAtomicNumber( 'Rb' ))
        assert_equal( 38, @e.getAtomicNumber( 'Sr' ))
        assert_equal( 39, @e.getAtomicNumber( 'Y'    ))
        assert_equal( 40, @e.getAtomicNumber( 'Zr' ))
        assert_equal( 41, @e.getAtomicNumber( 'Nb' ))
        assert_equal( 42, @e.getAtomicNumber( 'Mo' ))
        assert_equal( 43, @e.getAtomicNumber( 'Tc' ))
        assert_equal( 44, @e.getAtomicNumber( 'Ru' ))
        assert_equal( 45, @e.getAtomicNumber( 'Rh' ))
        assert_equal( 46, @e.getAtomicNumber( 'Pd' ))
        assert_equal( 47, @e.getAtomicNumber( 'Ag' ))
        assert_equal( 48, @e.getAtomicNumber( 'Cd' ))
        assert_equal( 49, @e.getAtomicNumber( 'In' ))
        assert_equal( 50, @e.getAtomicNumber( 'Sn' ))
        assert_equal( 51, @e.getAtomicNumber( 'Sb' ))
        assert_equal( 52, @e.getAtomicNumber( 'Te' ))
        assert_equal( 53, @e.getAtomicNumber( 'I'    ))
        assert_equal( 54, @e.getAtomicNumber( 'Xe' ))
        assert_equal( 55, @e.getAtomicNumber( 'Cs' ))
        assert_equal( 56, @e.getAtomicNumber( 'Ba' ))
        assert_equal( 57, @e.getAtomicNumber( 'La' ))
        assert_equal( 58, @e.getAtomicNumber( 'Ce' ))
        assert_equal( 59, @e.getAtomicNumber( 'Pr' ))
        assert_equal( 60, @e.getAtomicNumber( 'Nd' ))
        assert_equal( 61, @e.getAtomicNumber( 'Pm' ))
        assert_equal( 62, @e.getAtomicNumber( 'Sm' ))
        assert_equal( 63, @e.getAtomicNumber( 'Eu' ))
        assert_equal( 64, @e.getAtomicNumber( 'Gd' ))
        assert_equal( 65, @e.getAtomicNumber( 'Tb' ))
        assert_equal( 66, @e.getAtomicNumber( 'Dy' ))
        assert_equal( 67, @e.getAtomicNumber( 'Ho' ))
        assert_equal( 68, @e.getAtomicNumber( 'Er' ))
        assert_equal( 69, @e.getAtomicNumber( 'Tm' ))
        assert_equal( 70, @e.getAtomicNumber( 'Yb' ))
        assert_equal( 71, @e.getAtomicNumber( 'Lu' ))
        assert_equal( 72, @e.getAtomicNumber( 'Hf' ))
        assert_equal( 73, @e.getAtomicNumber( 'Ta' ))
        assert_equal( 74, @e.getAtomicNumber( 'W'    ))
        assert_equal( 75, @e.getAtomicNumber( 'Re' ))
        assert_equal( 76, @e.getAtomicNumber( 'Os' ))
        assert_equal( 77, @e.getAtomicNumber( 'Ir' ))
        assert_equal( 78, @e.getAtomicNumber( 'Pt' ))
        assert_equal( 79, @e.getAtomicNumber( 'Au' ))
        assert_equal( 80, @e.getAtomicNumber( 'Hg' ))
        assert_equal( 81, @e.getAtomicNumber( 'Tl' ))
        assert_equal( 82, @e.getAtomicNumber( 'Pb' ))
        assert_equal( 83, @e.getAtomicNumber( 'Bi' ))
        assert_equal( 84, @e.getAtomicNumber( 'Po' ))
        assert_equal( 85, @e.getAtomicNumber( 'At' ))
        assert_equal( 86, @e.getAtomicNumber( 'Rn' ))
        assert_equal( 87, @e.getAtomicNumber( 'Fr' ))
        assert_equal( 88, @e.getAtomicNumber( 'Ra' ))
        assert_equal( 89, @e.getAtomicNumber( 'Ac' ))
        assert_equal( 90, @e.getAtomicNumber( 'Th' ))
        assert_equal( 91, @e.getAtomicNumber( 'Pa' ))
        assert_equal( 92, @e.getAtomicNumber( 'U'    ))
        assert_equal( 93, @e.getAtomicNumber( 'Np' ))
        assert_equal( 94, @e.getAtomicNumber( 'Pu' ))
        assert_equal( 95, @e.getAtomicNumber( 'Am' ))
        assert_equal( 96, @e.getAtomicNumber( 'Cm' ))
        assert_equal( 97, @e.getAtomicNumber( 'Bk' ))
        assert_equal( 98, @e.getAtomicNumber( 'Cf' ))
        assert_equal( 99, @e.getAtomicNumber( 'Es' ))
        assert_equal(100, @e.getAtomicNumber( 'Fm' ))
        assert_equal(101, @e.getAtomicNumber( 'Md' ))
        assert_equal(102, @e.getAtomicNumber( 'No' ))
        assert_equal(103, @e.getAtomicNumber( 'Lr' ))
        #assert_equal(  1, @e.getAtomicNumber(   1 ))
        #assert_equal(  2, @e.getAtomicNumber(   2 ))
        #assert_equal(  3, @e.getAtomicNumber(   3 ))
        #assert_equal(  4, @e.getAtomicNumber(   4 ))
        #assert_equal(  5, @e.getAtomicNumber(   5 ))
        #assert_equal(  6, @e.getAtomicNumber(   6 ))
        #assert_equal(  7, @e.getAtomicNumber(   7 ))
        #assert_equal(  8, @e.getAtomicNumber(   8 ))
        #assert_equal(  9, @e.getAtomicNumber(   9 ))
        #assert_equal( 10, @e.getAtomicNumber(  10 ))
        #assert_equal( 11, @e.getAtomicNumber(  11 ))
        #assert_equal( 12, @e.getAtomicNumber(  12 ))
        #assert_equal( 13, @e.getAtomicNumber(  13 ))
        #assert_equal( 14, @e.getAtomicNumber(  14 ))
        #assert_equal( 15, @e.getAtomicNumber(  15 ))
        #assert_equal( 16, @e.getAtomicNumber(  16 ))
        #assert_equal( 17, @e.getAtomicNumber(  17 ))
        #assert_equal( 18, @e.getAtomicNumber(  18 ))
        #assert_equal( 19, @e.getAtomicNumber(  19 ))
        #assert_equal( 20, @e.getAtomicNumber(  20 ))
        #assert_equal( 21, @e.getAtomicNumber(  21 ))
        #assert_equal( 22, @e.getAtomicNumber(  22 ))
        #assert_equal( 23, @e.getAtomicNumber(  23 ))
        #assert_equal( 24, @e.getAtomicNumber(  24 ))
        #assert_equal( 25, @e.getAtomicNumber(  25 ))
        #assert_equal( 26, @e.getAtomicNumber(  26 ))
        #assert_equal( 27, @e.getAtomicNumber(  27 ))
        #assert_equal( 28, @e.getAtomicNumber(  28 ))
        #assert_equal( 29, @e.getAtomicNumber(  29 ))
        #assert_equal( 30, @e.getAtomicNumber(  30 ))
        #assert_equal( 31, @e.getAtomicNumber(  31 ))
        #assert_equal( 32, @e.getAtomicNumber(  32 ))
        #assert_equal( 33, @e.getAtomicNumber(  33 ))
        #assert_equal( 34, @e.getAtomicNumber(  34 ))
        #assert_equal( 35, @e.getAtomicNumber(  35 ))
        #assert_equal( 36, @e.getAtomicNumber(  36 ))
        #assert_equal( 37, @e.getAtomicNumber(  37 ))
        #assert_equal( 38, @e.getAtomicNumber(  38 ))
        #assert_equal( 39, @e.getAtomicNumber(  39 ))
        #assert_equal( 40, @e.getAtomicNumber(  40 ))
        #assert_equal( 41, @e.getAtomicNumber(  41 ))
        #assert_equal( 42, @e.getAtomicNumber(  42 ))
        #assert_equal( 43, @e.getAtomicNumber(  43 ))
        #assert_equal( 44, @e.getAtomicNumber(  44 ))
        #assert_equal( 45, @e.getAtomicNumber(  45 ))
        #assert_equal( 46, @e.getAtomicNumber(  46 ))
        #assert_equal( 47, @e.getAtomicNumber(  47 ))
        #assert_equal( 48, @e.getAtomicNumber(  48 ))
        #assert_equal( 49, @e.getAtomicNumber(  49 ))
        #assert_equal( 50, @e.getAtomicNumber(  50 ))
        #assert_equal( 51, @e.getAtomicNumber(  51 ))
        #assert_equal( 52, @e.getAtomicNumber(  52 ))
        #assert_equal( 53, @e.getAtomicNumber(  53 ))
        #assert_equal( 54, @e.getAtomicNumber(  54 ))
        #assert_equal( 55, @e.getAtomicNumber(  55 ))
        #assert_equal( 56, @e.getAtomicNumber(  56 ))
        #assert_equal( 57, @e.getAtomicNumber(  57 ))
        #assert_equal( 58, @e.getAtomicNumber(  58 ))
        #assert_equal( 59, @e.getAtomicNumber(  59 ))
        #assert_equal( 60, @e.getAtomicNumber(  60 ))
        #assert_equal( 61, @e.getAtomicNumber(  61 ))
        #assert_equal( 62, @e.getAtomicNumber(  62 ))
        #assert_equal( 63, @e.getAtomicNumber(  63 ))
        #assert_equal( 64, @e.getAtomicNumber(  64 ))
        #assert_equal( 65, @e.getAtomicNumber(  65 ))
        #assert_equal( 66, @e.getAtomicNumber(  66 ))
        #assert_equal( 67, @e.getAtomicNumber(  67 ))
        #assert_equal( 68, @e.getAtomicNumber(  68 ))
        #assert_equal( 69, @e.getAtomicNumber(  69 ))
        #assert_equal( 70, @e.getAtomicNumber(  70 ))
        #assert_equal( 71, @e.getAtomicNumber(  71 ))
        #assert_equal( 72, @e.getAtomicNumber(  72 ))
        #assert_equal( 73, @e.getAtomicNumber(  73 ))
        #assert_equal( 74, @e.getAtomicNumber(  74 ))
        #assert_equal( 75, @e.getAtomicNumber(  75 ))
        #assert_equal( 76, @e.getAtomicNumber(  76 ))
        #assert_equal( 77, @e.getAtomicNumber(  77 ))
        #assert_equal( 78, @e.getAtomicNumber(  78 ))
        #assert_equal( 79, @e.getAtomicNumber(  79 ))
        #assert_equal( 80, @e.getAtomicNumber(  80 ))
        #assert_equal( 81, @e.getAtomicNumber(  81 ))
        #assert_equal( 82, @e.getAtomicNumber(  82 ))
        #assert_equal( 83, @e.getAtomicNumber(  83 ))
        #assert_equal( 84, @e.getAtomicNumber(  84 ))
        #assert_equal( 85, @e.getAtomicNumber(  85 ))
        #assert_equal( 86, @e.getAtomicNumber(  86 ))
        #assert_equal( 87, @e.getAtomicNumber(  87 ))
        #assert_equal( 88, @e.getAtomicNumber(  88 ))
        #assert_equal( 89, @e.getAtomicNumber(  89 ))
        #assert_equal( 90, @e.getAtomicNumber(  90 ))
        #assert_equal( 91, @e.getAtomicNumber(  91 ))
        #assert_equal( 92, @e.getAtomicNumber(  92 ))
        #assert_equal( 93, @e.getAtomicNumber(  93 ))
        #assert_equal( 94, @e.getAtomicNumber(  94 ))
        #assert_equal( 95, @e.getAtomicNumber(  95 ))
        #assert_equal( 96, @e.getAtomicNumber(  96 ))
        #assert_equal( 97, @e.getAtomicNumber(  97 ))
        #assert_equal( 98, @e.getAtomicNumber(  98 ))
        #assert_equal( 99, @e.getAtomicNumber(  99 ))
        #assert_equal(100, @e.getAtomicNumber( 100 ))
        #assert_equal(101, @e.getAtomicNumber( 101 ))
        #assert_equal(102, @e.getAtomicNumber( 102 ))
        #assert_equal(103, @e.getAtomicNumber( 103 ))

        assert_raise(RuntimeError){@e.getAtomicNumber( nil  )}
        assert_raise(RuntimeError){@e.getAtomicNumber( 'A'  )}
        assert_raise(RuntimeError){@e.getAtomicNumber( -1       )}
        assert_raise(RuntimeError){@e.getAtomicNumber(  0       )}
        assert_raise(RuntimeError){@e.getAtomicNumber( 104  )}
    end

    def test_getSymbol
        #assert_equal('H' , @e.getSymbol( 'H'    ))
        #assert_equal('He', @e.getSymbol( 'He' ))
        #assert_equal('Li', @e.getSymbol( 'Li' ))
        #assert_equal('Be', @e.getSymbol( 'Be' ))
        #assert_equal('B' , @e.getSymbol( 'B'    ))
        #assert_equal('C' , @e.getSymbol( 'C'    ))
        #assert_equal('N' , @e.getSymbol( 'N'    ))
        #assert_equal('O' , @e.getSymbol( 'O'    ))
        #assert_equal('F' , @e.getSymbol( 'F'    ))
        #assert_equal('Ne', @e.getSymbol( 'Ne' ))
        #assert_equal('Na', @e.getSymbol( 'Na' ))
        #assert_equal('Mg', @e.getSymbol( 'Mg' ))
        #assert_equal('Al', @e.getSymbol( 'Al' ))
        #assert_equal('Si', @e.getSymbol( 'Si' ))
        #assert_equal('P' , @e.getSymbol( 'P'    ))
        #assert_equal('S' , @e.getSymbol( 'S'    ))
        #assert_equal('Cl', @e.getSymbol( 'Cl' ))
        #assert_equal('Ar', @e.getSymbol( 'Ar' ))
        #assert_equal('K' , @e.getSymbol( 'K'    ))
        #assert_equal('Ca', @e.getSymbol( 'Ca' ))
        #assert_equal('Sc', @e.getSymbol( 'Sc' ))
        #assert_equal('Ti', @e.getSymbol( 'Ti' ))
        #assert_equal('V' , @e.getSymbol( 'V'    ))
        #assert_equal('Cr', @e.getSymbol( 'Cr' ))
        #assert_equal('Mn', @e.getSymbol( 'Mn' ))
        #assert_equal('Fe', @e.getSymbol( 'Fe' ))
        #assert_equal('Co', @e.getSymbol( 'Co' ))
        #assert_equal('Ni', @e.getSymbol( 'Ni' ))
        #assert_equal('Cu', @e.getSymbol( 'Cu' ))
        #assert_equal('Zn', @e.getSymbol( 'Zn' ))
        #assert_equal('Ga', @e.getSymbol( 'Ga' ))
        #assert_equal('Ge', @e.getSymbol( 'Ge' ))
        #assert_equal('As', @e.getSymbol( 'As' ))
        #assert_equal('Se', @e.getSymbol( 'Se' ))
        #assert_equal('Br', @e.getSymbol( 'Br' ))
        #assert_equal('Kr', @e.getSymbol( 'Kr' ))
        #assert_equal('Rb', @e.getSymbol( 'Rb' ))
        #assert_equal('Sr', @e.getSymbol( 'Sr' ))
        #assert_equal('Y' , @e.getSymbol( 'Y'    ))
        #assert_equal('Zr', @e.getSymbol( 'Zr' ))
        #assert_equal('Nb', @e.getSymbol( 'Nb' ))
        #assert_equal('Mo', @e.getSymbol( 'Mo' ))
        #assert_equal('Tc', @e.getSymbol( 'Tc' ))
        #assert_equal('Ru', @e.getSymbol( 'Ru' ))
        #assert_equal('Rh', @e.getSymbol( 'Rh' ))
        #assert_equal('Pd', @e.getSymbol( 'Pd' ))
        #assert_equal('Ag', @e.getSymbol( 'Ag' ))
        #assert_equal('Cd', @e.getSymbol( 'Cd' ))
        #assert_equal('In', @e.getSymbol( 'In' ))
        #assert_equal('Sn', @e.getSymbol( 'Sn' ))
        #assert_equal('Sb', @e.getSymbol( 'Sb' ))
        #assert_equal('Te', @e.getSymbol( 'Te' ))
        #assert_equal('I' , @e.getSymbol( 'I'    ))
        #assert_equal('Xe', @e.getSymbol( 'Xe' ))
        #assert_equal('Cs', @e.getSymbol( 'Cs' ))
        #assert_equal('Ba', @e.getSymbol( 'Ba' ))
        #assert_equal('La', @e.getSymbol( 'La' ))
        #assert_equal('Ce', @e.getSymbol( 'Ce' ))
        #assert_equal('Pr', @e.getSymbol( 'Pr' ))
        #assert_equal('Nd', @e.getSymbol( 'Nd' ))
        #assert_equal('Pm', @e.getSymbol( 'Pm' ))
        #assert_equal('Sm', @e.getSymbol( 'Sm' ))
        #assert_equal('Eu', @e.getSymbol( 'Eu' ))
        #assert_equal('Gd', @e.getSymbol( 'Gd' ))
        #assert_equal('Tb', @e.getSymbol( 'Tb' ))
        #assert_equal('Dy', @e.getSymbol( 'Dy' ))
        #assert_equal('Ho', @e.getSymbol( 'Ho' ))
        #assert_equal('Er', @e.getSymbol( 'Er' ))
        #assert_equal('Tm', @e.getSymbol( 'Tm' ))
        #assert_equal('Yb', @e.getSymbol( 'Yb' ))
        #assert_equal('Lu', @e.getSymbol( 'Lu' ))
        #assert_equal('Hf', @e.getSymbol( 'Hf' ))
        #assert_equal('Ta', @e.getSymbol( 'Ta' ))
        #assert_equal('W' , @e.getSymbol( 'W'    ))
        #assert_equal('Re', @e.getSymbol( 'Re' ))
        #assert_equal('Os', @e.getSymbol( 'Os' ))
        #assert_equal('Ir', @e.getSymbol( 'Ir' ))
        #assert_equal('Pt', @e.getSymbol( 'Pt' ))
        #assert_equal('Au', @e.getSymbol( 'Au' ))
        #assert_equal('Hg', @e.getSymbol( 'Hg' ))
        #assert_equal('Tl', @e.getSymbol( 'Tl' ))
        #assert_equal('Pb', @e.getSymbol( 'Pb' ))
        #assert_equal('Bi', @e.getSymbol( 'Bi' ))
        #assert_equal('Po', @e.getSymbol( 'Po' ))
        #assert_equal('At', @e.getSymbol( 'At' ))
        #assert_equal('Rn', @e.getSymbol( 'Rn' ))
        #assert_equal('Fr', @e.getSymbol( 'Fr' ))
        #assert_equal('Ra', @e.getSymbol( 'Ra' ))
        #assert_equal('Ac', @e.getSymbol( 'Ac' ))
        #assert_equal('Th', @e.getSymbol( 'Th' ))
        #assert_equal('Pa', @e.getSymbol( 'Pa' ))
        #assert_equal('U' , @e.getSymbol( 'U'    ))
        #assert_equal('Np', @e.getSymbol( 'Np' ))
        #assert_equal('Pu', @e.getSymbol( 'Pu' ))
        #assert_equal('Am', @e.getSymbol( 'Am' ))
        #assert_equal('Cm', @e.getSymbol( 'Cm' ))
        #assert_equal('Bk', @e.getSymbol( 'Bk' ))
        #assert_equal('Cf', @e.getSymbol( 'Cf' ))
        #assert_equal('Es', @e.getSymbol( 'Es' ))
        #assert_equal('Fm', @e.getSymbol( 'Fm' ))
        #assert_equal('Md', @e.getSymbol( 'Md' ))
        #assert_equal('No', @e.getSymbol( 'No' ))
        #assert_equal('Lr', @e.getSymbol( 'Lr' ))
        assert_equal('H' , @e.getSymbol(     1 ))
        assert_equal('He', @e.getSymbol(     2 ))
        assert_equal('Li', @e.getSymbol(     3 ))
        assert_equal('Be', @e.getSymbol(     4 ))
        assert_equal('B' , @e.getSymbol(     5 ))
        assert_equal('C' , @e.getSymbol(     6 ))
        assert_equal('N' , @e.getSymbol(     7 ))
        assert_equal('O' , @e.getSymbol(     8 ))
        assert_equal('F' , @e.getSymbol(     9 ))
        assert_equal('Ne', @e.getSymbol(    10 ))
        assert_equal('Na', @e.getSymbol(    11 ))
        assert_equal('Mg', @e.getSymbol(    12 ))
        assert_equal('Al', @e.getSymbol(    13 ))
        assert_equal('Si', @e.getSymbol(    14 ))
        assert_equal('P' , @e.getSymbol(    15 ))
        assert_equal('S' , @e.getSymbol(    16 ))
        assert_equal('Cl', @e.getSymbol(    17 ))
        assert_equal('Ar', @e.getSymbol(    18 ))
        assert_equal('K' , @e.getSymbol(    19 ))
        assert_equal('Ca', @e.getSymbol(    20 ))
        assert_equal('Sc', @e.getSymbol(    21 ))
        assert_equal('Ti', @e.getSymbol(    22 ))
        assert_equal('V' , @e.getSymbol(    23 ))
        assert_equal('Cr', @e.getSymbol(    24 ))
        assert_equal('Mn', @e.getSymbol(    25 ))
        assert_equal('Fe', @e.getSymbol(    26 ))
        assert_equal('Co', @e.getSymbol(    27 ))
        assert_equal('Ni', @e.getSymbol(    28 ))
        assert_equal('Cu', @e.getSymbol(    29 ))
        assert_equal('Zn', @e.getSymbol(    30 ))
        assert_equal('Ga', @e.getSymbol(    31 ))
        assert_equal('Ge', @e.getSymbol(    32 ))
        assert_equal('As', @e.getSymbol(    33 ))
        assert_equal('Se', @e.getSymbol(    34 ))
        assert_equal('Br', @e.getSymbol(    35 ))
        assert_equal('Kr', @e.getSymbol(    36 ))
        assert_equal('Rb', @e.getSymbol(    37 ))
        assert_equal('Sr', @e.getSymbol(    38 ))
        assert_equal('Y' , @e.getSymbol(    39 ))
        assert_equal('Zr', @e.getSymbol(    40 ))
        assert_equal('Nb', @e.getSymbol(    41 ))
        assert_equal('Mo', @e.getSymbol(    42 ))
        assert_equal('Tc', @e.getSymbol(    43 ))
        assert_equal('Ru', @e.getSymbol(    44 ))
        assert_equal('Rh', @e.getSymbol(    45 ))
        assert_equal('Pd', @e.getSymbol(    46 ))
        assert_equal('Ag', @e.getSymbol(    47 ))
        assert_equal('Cd', @e.getSymbol(    48 ))
        assert_equal('In', @e.getSymbol(    49 ))
        assert_equal('Sn', @e.getSymbol(    50 ))
        assert_equal('Sb', @e.getSymbol(    51 ))
        assert_equal('Te', @e.getSymbol(    52 ))
        assert_equal('I' , @e.getSymbol(    53 ))
        assert_equal('Xe', @e.getSymbol(    54 ))
        assert_equal('Cs', @e.getSymbol(    55 ))
        assert_equal('Ba', @e.getSymbol(    56 ))
        assert_equal('La', @e.getSymbol(    57 ))
        assert_equal('Ce', @e.getSymbol(    58 ))
        assert_equal('Pr', @e.getSymbol(    59 ))
        assert_equal('Nd', @e.getSymbol(    60 ))
        assert_equal('Pm', @e.getSymbol(    61 ))
        assert_equal('Sm', @e.getSymbol(    62 ))
        assert_equal('Eu', @e.getSymbol(    63 ))
        assert_equal('Gd', @e.getSymbol(    64 ))
        assert_equal('Tb', @e.getSymbol(    65 ))
        assert_equal('Dy', @e.getSymbol(    66 ))
        assert_equal('Ho', @e.getSymbol(    67 ))
        assert_equal('Er', @e.getSymbol(    68 ))
        assert_equal('Tm', @e.getSymbol(    69 ))
        assert_equal('Yb', @e.getSymbol(    70 ))
        assert_equal('Lu', @e.getSymbol(    71 ))
        assert_equal('Hf', @e.getSymbol(    72 ))
        assert_equal('Ta', @e.getSymbol(    73 ))
        assert_equal('W' , @e.getSymbol(    74 ))
        assert_equal('Re', @e.getSymbol(    75 ))
        assert_equal('Os', @e.getSymbol(    76 ))
        assert_equal('Ir', @e.getSymbol(    77 ))
        assert_equal('Pt', @e.getSymbol(    78 ))
        assert_equal('Au', @e.getSymbol(    79 ))
        assert_equal('Hg', @e.getSymbol(    80 ))
        assert_equal('Tl', @e.getSymbol(    81 ))
        assert_equal('Pb', @e.getSymbol(    82 ))
        assert_equal('Bi', @e.getSymbol(    83 ))
        assert_equal('Po', @e.getSymbol(    84 ))
        assert_equal('At', @e.getSymbol(    85 ))
        assert_equal('Rn', @e.getSymbol(    86 ))
        assert_equal('Fr', @e.getSymbol(    87 ))
        assert_equal('Ra', @e.getSymbol(    88 ))
        assert_equal('Ac', @e.getSymbol(    89 ))
        assert_equal('Th', @e.getSymbol(    90 ))
        assert_equal('Pa', @e.getSymbol(    91 ))
        assert_equal('U' , @e.getSymbol(    92 ))
        assert_equal('Np', @e.getSymbol(    93 ))
        assert_equal('Pu', @e.getSymbol(    94 ))
        assert_equal('Am', @e.getSymbol(    95 ))
        assert_equal('Cm', @e.getSymbol(    96 ))
        assert_equal('Bk', @e.getSymbol(    97 ))
        assert_equal('Cf', @e.getSymbol(    98 ))
        assert_equal('Es', @e.getSymbol(    99 ))
        assert_equal('Fm', @e.getSymbol( 100 ))
        assert_equal('Md', @e.getSymbol( 101 ))
        assert_equal('No', @e.getSymbol( 102 ))
        assert_equal('Lr', @e.getSymbol( 103 ))

        assert_raise(RuntimeError){@e.getSymbol( nil    )}
        assert_raise(RuntimeError){@e.getSymbol( 'A'    )}
        assert_raise(RuntimeError){@e.getSymbol( -1     )}
        assert_raise(RuntimeError){@e.getSymbol(    0       )}
        assert_raise(RuntimeError){@e.getSymbol( 104    )}
    end

    def test_include?
        assert_equal(true, @e.include?( 'H'  ))
        assert_equal(true, @e.include?( 'He' ))
        assert_equal(true, @e.include?( 'Li' ))
        assert_equal(true, @e.include?( 'Be' ))
        assert_equal(true, @e.include?( 'B'  ))
        assert_equal(true, @e.include?( 'C'  ))
        assert_equal(true, @e.include?( 'N'  ))
        assert_equal(true, @e.include?( 'O'  ))
        assert_equal(true, @e.include?( 'F'  ))
        assert_equal(true, @e.include?( 'Ne' ))
        assert_equal(true, @e.include?( 'Na' ))
        assert_equal(true, @e.include?( 'Mg' ))
        assert_equal(true, @e.include?( 'Al' ))
        assert_equal(true, @e.include?( 'Si' ))
        assert_equal(true, @e.include?( 'P'  ))
        assert_equal(true, @e.include?( 'S'  ))
        assert_equal(true, @e.include?( 'Cl' ))
        assert_equal(true, @e.include?( 'Ar' ))
        assert_equal(true, @e.include?( 'K'  ))
        assert_equal(true, @e.include?( 'Ca' ))
        assert_equal(true, @e.include?( 'Sc' ))
        assert_equal(true, @e.include?( 'Ti' ))
        assert_equal(true, @e.include?( 'V'  ))
        assert_equal(true, @e.include?( 'Cr' ))
        assert_equal(true, @e.include?( 'Mn' ))
        assert_equal(true, @e.include?( 'Fe' ))
        assert_equal(true, @e.include?( 'Co' ))
        assert_equal(true, @e.include?( 'Ni' ))
        assert_equal(true, @e.include?( 'Cu' ))
        assert_equal(true, @e.include?( 'Zn' ))
        assert_equal(true, @e.include?( 'Ga' ))
        assert_equal(true, @e.include?( 'Ge' ))
        assert_equal(true, @e.include?( 'As' ))
        assert_equal(true, @e.include?( 'Se' ))
        assert_equal(true, @e.include?( 'Br' ))
        assert_equal(true, @e.include?( 'Kr' ))
        assert_equal(true, @e.include?( 'Rb' ))
        assert_equal(true, @e.include?( 'Sr' ))
        assert_equal(true, @e.include?( 'Y'  ))
        assert_equal(true, @e.include?( 'Zr' ))
        assert_equal(true, @e.include?( 'Nb' ))
        assert_equal(true, @e.include?( 'Mo' ))
        assert_equal(true, @e.include?( 'Tc' ))
        assert_equal(true, @e.include?( 'Ru' ))
        assert_equal(true, @e.include?( 'Rh' ))
        assert_equal(true, @e.include?( 'Pd' ))
        assert_equal(true, @e.include?( 'Ag' ))
        assert_equal(true, @e.include?( 'Cd' ))
        assert_equal(true, @e.include?( 'In' ))
        assert_equal(true, @e.include?( 'Sn' ))
        assert_equal(true, @e.include?( 'Sb' ))
        assert_equal(true, @e.include?( 'Te' ))
        assert_equal(true, @e.include?( 'I'  ))
        assert_equal(true, @e.include?( 'Xe' ))
        assert_equal(true, @e.include?( 'Cs' ))
        assert_equal(true, @e.include?( 'Ba' ))
        assert_equal(true, @e.include?( 'La' ))
        assert_equal(true, @e.include?( 'Ce' ))
        assert_equal(true, @e.include?( 'Pr' ))
        assert_equal(true, @e.include?( 'Nd' ))
        assert_equal(true, @e.include?( 'Pm' ))
        assert_equal(true, @e.include?( 'Sm' ))
        assert_equal(true, @e.include?( 'Eu' ))
        assert_equal(true, @e.include?( 'Gd' ))
        assert_equal(true, @e.include?( 'Tb' ))
        assert_equal(true, @e.include?( 'Dy' ))
        assert_equal(true, @e.include?( 'Ho' ))
        assert_equal(true, @e.include?( 'Er' ))
        assert_equal(true, @e.include?( 'Tm' ))
        assert_equal(true, @e.include?( 'Yb' ))
        assert_equal(true, @e.include?( 'Lu' ))
        assert_equal(true, @e.include?( 'Hf' ))
        assert_equal(true, @e.include?( 'Ta' ))
        assert_equal(true, @e.include?( 'W'  ))
        assert_equal(true, @e.include?( 'Re' ))
        assert_equal(true, @e.include?( 'Os' ))
        assert_equal(true, @e.include?( 'Ir' ))
        assert_equal(true, @e.include?( 'Pt' ))
        assert_equal(true, @e.include?( 'Au' ))
        assert_equal(true, @e.include?( 'Hg' ))
        assert_equal(true, @e.include?( 'Tl' ))
        assert_equal(true, @e.include?( 'Pb' ))
        assert_equal(true, @e.include?( 'Bi' ))
        assert_equal(true, @e.include?( 'Po' ))
        assert_equal(true, @e.include?( 'At' ))
        assert_equal(true, @e.include?( 'Rn' ))
        assert_equal(true, @e.include?( 'Fr' ))
        assert_equal(true, @e.include?( 'Ra' ))
        assert_equal(true, @e.include?( 'Ac' ))
        assert_equal(true, @e.include?( 'Th' ))
        assert_equal(true, @e.include?( 'Pa' ))
        assert_equal(true, @e.include?( 'U'  ))
        assert_equal(true, @e.include?( 'Np' ))
        assert_equal(true, @e.include?( 'Pu' ))
        assert_equal(true, @e.include?( 'Am' ))
        assert_equal(true, @e.include?( 'Cm' ))
        assert_equal(true, @e.include?( 'Bk' ))
        assert_equal(true, @e.include?( 'Cf' ))
        assert_equal(true, @e.include?( 'Es' ))
        assert_equal(true, @e.include?( 'Fm' ))
        assert_equal(true, @e.include?( 'Md' ))
        assert_equal(true, @e.include?( 'No' ))
        assert_equal(true, @e.include?( 'Lr' ))
    # assert_equal(true, @e.include?(       1 ))
    # assert_equal(true, @e.include?(       2 ))
    # assert_equal(true, @e.include?(       3 ))
    # assert_equal(true, @e.include?(       4 ))
    # assert_equal(true, @e.include?(       5 ))
    # assert_equal(true, @e.include?(       6 ))
    # assert_equal(true, @e.include?(       7 ))
    # assert_equal(true, @e.include?(       8 ))
    # assert_equal(true, @e.include?(       9 ))
    # assert_equal(true, @e.include?(    10 ))
    # assert_equal(true, @e.include?(    11 ))
    # assert_equal(true, @e.include?(    12 ))
    # assert_equal(true, @e.include?(    13 ))
    # assert_equal(true, @e.include?(    14 ))
    # assert_equal(true, @e.include?(    15 ))
    # assert_equal(true, @e.include?(    16 ))
    # assert_equal(true, @e.include?(    17 ))
    # assert_equal(true, @e.include?(    18 ))
    # assert_equal(true, @e.include?(    19 ))
    # assert_equal(true, @e.include?(    20 ))
    # assert_equal(true, @e.include?(    21 ))
    # assert_equal(true, @e.include?(    22 ))
    # assert_equal(true, @e.include?(    23 ))
    # assert_equal(true, @e.include?(    24 ))
    # assert_equal(true, @e.include?(    25 ))
    # assert_equal(true, @e.include?(    26 ))
    # assert_equal(true, @e.include?(    27 ))
    # assert_equal(true, @e.include?(    28 ))
    # assert_equal(true, @e.include?(    29 ))
    # assert_equal(true, @e.include?(    30 ))
    # assert_equal(true, @e.include?(    31 ))
    # assert_equal(true, @e.include?(    32 ))
    # assert_equal(true, @e.include?(    33 ))
    # assert_equal(true, @e.include?(    34 ))
    # assert_equal(true, @e.include?(    35 ))
    # assert_equal(true, @e.include?(    36 ))
    # assert_equal(true, @e.include?(    37 ))
    # assert_equal(true, @e.include?(    38 ))
    # assert_equal(true, @e.include?(    39 ))
    # assert_equal(true, @e.include?(    40 ))
    # assert_equal(true, @e.include?(    41 ))
    # assert_equal(true, @e.include?(    42 ))
    # assert_equal(true, @e.include?(    43 ))
    # assert_equal(true, @e.include?(    44 ))
    # assert_equal(true, @e.include?(    45 ))
    # assert_equal(true, @e.include?(    46 ))
    # assert_equal(true, @e.include?(    47 ))
    # assert_equal(true, @e.include?(    48 ))
    # assert_equal(true, @e.include?(    49 ))
    # assert_equal(true, @e.include?(    50 ))
    # assert_equal(true, @e.include?(    51 ))
    # assert_equal(true, @e.include?(    52 ))
    # assert_equal(true, @e.include?(    53 ))
    # assert_equal(true, @e.include?(    54 ))
    # assert_equal(true, @e.include?(    55 ))
    # assert_equal(true, @e.include?(    56 ))
    # assert_equal(true, @e.include?(    57 ))
    # assert_equal(true, @e.include?(    58 ))
    # assert_equal(true, @e.include?(    59 ))
    # assert_equal(true, @e.include?(    60 ))
    # assert_equal(true, @e.include?(    61 ))
    # assert_equal(true, @e.include?(    62 ))
    # assert_equal(true, @e.include?(    63 ))
    # assert_equal(true, @e.include?(    64 ))
    # assert_equal(true, @e.include?(    65 ))
    # assert_equal(true, @e.include?(    66 ))
    # assert_equal(true, @e.include?(    67 ))
    # assert_equal(true, @e.include?(    68 ))
    # assert_equal(true, @e.include?(    69 ))
    # assert_equal(true, @e.include?(    70 ))
    # assert_equal(true, @e.include?(    71 ))
    # assert_equal(true, @e.include?(    72 ))
    # assert_equal(true, @e.include?(    73 ))
    # assert_equal(true, @e.include?(    74 ))
    # assert_equal(true, @e.include?(    75 ))
    # assert_equal(true, @e.include?(    76 ))
    # assert_equal(true, @e.include?(    77 ))
    # assert_equal(true, @e.include?(    78 ))
    # assert_equal(true, @e.include?(    79 ))
    # assert_equal(true, @e.include?(    80 ))
    # assert_equal(true, @e.include?(    81 ))
    # assert_equal(true, @e.include?(    82 ))
    # assert_equal(true, @e.include?(    83 ))
    # assert_equal(true, @e.include?(    84 ))
    # assert_equal(true, @e.include?(    85 ))
    # assert_equal(true, @e.include?(    86 ))
    # assert_equal(true, @e.include?(    87 ))
    # assert_equal(true, @e.include?(    88 ))
    # assert_equal(true, @e.include?(    89 ))
    # assert_equal(true, @e.include?(    90 ))
    # assert_equal(true, @e.include?(    91 ))
    # assert_equal(true, @e.include?(    92 ))
    # assert_equal(true, @e.include?(    93 ))
    # assert_equal(true, @e.include?(    94 ))
    # assert_equal(true, @e.include?(    95 ))
    # assert_equal(true, @e.include?(    96 ))
    # assert_equal(true, @e.include?(    97 ))
    # assert_equal(true, @e.include?(    98 ))
    # assert_equal(true, @e.include?(    99 ))
    # assert_equal(true, @e.include?( 100 ))
    # assert_equal(true, @e.include?( 101 ))
    # assert_equal(true, @e.include?( 102 ))
    # assert_equal(true, @e.include?( 103 ))

        assert_equal(false, @e.include?( nil ))
        assert_equal(false, @e.include?( 'A' ))
        assert_equal(false, @e.include?( -1  ))
        assert_equal(false, @e.include?(    0    ))
        assert_equal(false, @e.include?( 104 ))
    end
end

