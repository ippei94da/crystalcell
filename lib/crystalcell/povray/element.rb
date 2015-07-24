# VESTA で使われている描画色、 ionic radii をまとめたもの。
# 描画を主眼にしているので厳密な計算には用いるべきではない。
# VESTA は未知のものは ]    76 76 76 0.8 とするようだ。

module CrystalCell::Povray::Element
  COLOR = {
    'H'  => [ 255, 204, 204], 
    'He' => [ 252, 232, 206], 
    'Li' => [ 134, 224, 116], 
    'Be' => [  94, 215, 123], 
    'B'  => [  31, 162,  15], 
    'C'  => [ 128,  73,  41], 
    'N'  => [ 176, 185, 230], 
    'O'  => [ 254,   3,   0], 
    'F'  => [ 176, 185, 230], 
    'Ne' => [ 254,  55, 181], 
    'Na' => [ 249, 220,  60], 
    'Mg' => [ 251, 123,  21], 
    'Al' => [ 129, 178, 214], 
    'Si' => [  27,  59, 250], 
    'P'  => [ 192, 156, 194], 
    'S'  => [ 255, 250,   0], 
    'Cl' => [  49, 252,   2], 
    'Ar' => [ 207, 254, 196], 
    'K'  => [ 161,  33, 246], 
    'Ca' => [  90, 150, 189], 
    'Sc' => [ 181,  99, 171], 
    'Ti' => [ 120, 202, 255], 
    'V'  => [ 229,  25,   0], 
    'Cr' => [   0,   0, 158], 
    'Mn' => [ 168,   8, 158], 
    'Fe' => [ 181, 113,   0], 
    'Co' => [   0,   0, 175], 
    'Ni' => [ 183, 187, 189], 
    'Cu' => [  34,  71, 220], 
    'Zn' => [ 143, 143, 129], 
    'Ga' => [ 158, 227, 115], 
    'Ge' => [ 126, 110, 166], 
    'As' => [ 116, 208,  87], 
    'Se' => [ 154, 239,  15], 
    'Br' => [ 126,  49,   2], 
    'Kr' => [ 250, 193, 243], 
    'Rb' => [ 255,   0, 153], 
    'Sr' => [   0, 255,  38], 
    'Y'  => [ 102, 152, 142], 
    'Zr' => [   0, 255,   0], 
    'Nb' => [  76, 178, 118], 
    'Mo' => [ 179, 134, 175], 
    'Tc' => [ 205, 175, 202], 
    'Ru' => [ 207, 183, 173], 
    'Rh' => [ 205, 209, 171], 
    'Pd' => [ 193, 195, 184], 
    'Ag' => [ 183, 187, 189], 
    'Cd' => [ 242,  30, 220], 
    'In' => [ 215, 128, 187], 
    'Sn' => [ 154, 142, 185], 
    'Sb' => [ 215, 131,  79], 
    'Te' => [ 173, 162,  81], 
    'I'  => [ 142,  31, 138], 
    'Xe' => [ 154, 161, 248], 
    'Cs' => [  14, 254, 185], 
    'Ba' => [  30, 239,  44], 
    'Hf' => [ 180, 179,  89], 
    'Ta' => [ 183, 154,  86], 
    'W'  => [ 141, 138, 127], 
    'Re' => [ 179, 176, 142], 
    'Os' => [ 200, 177, 120], 
    'Ir' => [ 201, 206, 114], 
    'Pt' => [ 203, 197, 191], 
    'Au' => [ 254, 178,  56], 
    'Hg' => [ 211, 183, 203], 
    'Tl' => [ 149, 137, 108], 
    'Pb' => [  82,  83,  91], 
    'Bi' => [ 210,  47, 247], 
    'Po' => [   0,   0, 255], 
    'At' => [   0,   0, 255], 
    'Rn' => [ 255, 255,   0], 
    'Fr' => [   0,   0,   0], 
    'Ra' => [ 109, 169,  88], 
    'La' => [  90, 196,  73], 
    'Ce' => [ 209, 252,   6], 
    'Pr' => [ 252, 225,   5], 
    'Nd' => [ 251, 141,   6], 
    'Pm' => [   0,   0, 244], 
    'Sm' => [ 252,   6, 125], 
    'Eu' => [ 250,   7, 213], 
    'Gd' => [ 192,   3, 255], 
    'Tb' => [ 113,   4, 254], 
    'Dy' => [  49,   6, 252], 
    'Ho' => [   7,  65, 251], 
    'Er' => [  73, 114,  58], 
    'Tm' => [   0,   0, 224], 
    'Yb' => [  39, 252, 244], 
    'Lu' => [  38, 253, 181], 
    'Ac' => [ 100, 158, 114], 
    'Th' => [  37, 253, 120], 
    'Pa' => [  41, 250,  53], 
    'U'  => [ 121, 161, 170], 
    'Np' => [  76,  76,  76], 
    'Pu' => [  76,  76,  76], 
    'Am' => [  76,  76,  76], 
    'Cm' => [  76,  76,  76], 
    'Bk' => [  76,  76,  76], 
    'Cf' => [  76,  76,  76], 
    'Es' => [  76,  76,  76], 
    'Fm' => [  76,  76,  76], 
    'Md' => [  76,  76,  76], 
    'No' => [  76,  76,  76], 
    'Lr' => [  76,  76,  76], 
  }


  #radii
  RADIUS = {
    'H'  =>  0.2  ,
    'He' =>  1.22 ,
    'Li' =>  0.59 ,
    'Be' =>  0.27 ,
    'B'  =>  0.11 ,
    'C'  =>  0.15 ,
    'N'  =>  1.46 ,
    'O'  =>  1.4  ,
    'F'  =>  1.33 ,
    'Ne' =>  1.6  ,
    'Na' =>  1.02 ,
    'Mg' =>  0.72 ,
    'Al' =>  0.39 ,
    'Si' =>  0.26 ,
    'P'  =>  0.17 ,
    'S'  =>  1.84 ,
    'Cl' =>  1.81 ,
    'Ar' =>  1.92 ,
    'K'  =>  1.51 ,
    'Ca' =>  1.12 ,
    'Sc' =>  0.745,
    'Ti' =>  0.605,
    'V'  =>  0.58 ,
    'Cr' =>  0.615,
    'Mn' =>  0.83 ,
    'Fe' =>  0.78 ,
    'Co' =>  0.745,
    'Ni' =>  0.69 ,
    'Cu' =>  0.73 ,
    'Zn' =>  0.74 ,
    'Ga' =>  0.62 ,
    'Ge' =>  0.53 ,
    'As' =>  0.335,
    'Se' =>  1.98 ,
    'Br' =>  1.96 ,
    'Kr' =>  1.98 ,
    'Rb' =>  1.61 ,
    'Sr' =>  1.26 ,
    'Y'  =>  1.019,
    'Zr' =>  0.72 ,
    'Nb' =>  0.64 ,
    'Mo' =>  0.59 ,
    'Tc' =>  0.56 ,
    'Ru' =>  0.62 ,
    'Rh' =>  0.665,
    'Pd' =>  0.86 ,
    'Ag' =>  1.15 ,
    'Cd' =>  0.95 ,
    'In' =>  0.8  ,
    'Sn' =>  0.69 ,
    'Sb' =>  0.76 ,
    'Te' =>  2.21 ,
    'I'  =>  2.2  ,
    'Xe' =>  0.48 ,
    'Cs' =>  1.74 ,
    'Ba' =>  1.42 ,
    'Hf' =>  0.71 ,
    'Ta' =>  0.64 ,
    'W'  =>  0.6  ,
    'Re' =>  0.53 ,
    'Os' =>  0.63 ,
    'Ir' =>  0.625,
    'Pt' =>  0.625,
    'Au' =>  1.37 ,
    'Hg' =>  1.02 ,
    'Tl' =>  0.885,
    'Pb' =>  1.19 ,
    'Bi' =>  1.03 ,
    'Po' =>  0.94 ,
    'At' =>  0.62 ,
    'Rn' =>  0.8  ,
    'Fr' =>  1.8  ,
    'Ra' =>  1.48 ,
    'La' =>  1.16 ,
    'Ce' =>  0.97 ,
    'Pr' =>  1.126,
    'Nd' =>  1.109,
    'Pm' =>  1.093,
    'Sm' =>  1.27 ,
    'Eu' =>  1.066,
    'Gd' =>  1.053,
    'Tb' =>  1.04 ,
    'Dy' =>  1.027,
    'Ho' =>  1.015,
    'Er' =>  1.004,
    'Tm' =>  0.994,
    'Yb' =>  0.985,
    'Lu' =>  0.977,
    'Ac' =>  1.12 ,
    'Th' =>  1.05 ,
    'Pa' =>  0.78 ,
    'U'  =>  0.73 ,
    'Np' =>  0.75 ,
    'Pu' =>  0.86 ,
    'Am' =>  0.975,
    'Cm' =>  0.8  ,
    'Bk' =>  0.8  ,
    'Cf' =>  0.8  ,
    'Es' =>  0.8  ,
    'Fm' =>  0.8  ,
    'Md' =>  0.8  ,
    'No' =>  0.8  ,
    'Lr' =>  0.8  ,
  }

  def self.radius(element)
    RADIUS[element]
  end

  def self.color(element)
    COLOR[element].map {|i| i.to_f / 255.0}
  end

end
