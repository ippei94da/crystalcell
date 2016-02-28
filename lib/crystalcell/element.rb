# Class for elements and their information.
#
class CrystalCell::Element

  class NotExistError < Exception; end

  SYMBOLS = [nil] + %w(
    H He
    Li Be B  C  N O F  Ne
    Na Mg Al Si P S Cl Ar
    K  Ca Sc Ti V  Cr Mn Fe Co Ni Cu Zn Ga Ge As Se Br Kr
    Rb Sr Y  Zr Nb Mo Tc Ru Rh Pd Ag Cd In Sn Sb Te I  Xe
    Cs Ba La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu
      Hf Ta W Re Os Ir Pt Au Hg Tl Pb Bi Po At Rn
    Fr Ra Ac Th Pa U Np Pu Am Cm Bk Cf Es Fm Md No Lr
  )

  #https://www.hulinks.co.jp/support/c-maker/qa_05.html
  ATOMIC_RADII = [nil,
    0.53, 0.31,
    1.67, 1.12, 0.87, 0.67, 0.56, 0.48, 0.42, 0.38,
    1.90, 1.45, 1.18, 1.11, 0.98, 0.88, 0.79, 0.71,
    2.43, 1.94, 1.84, 1.76, 1.71, 1.66, 1.61, 1.56,
      1.52, 1.49, 1.45, 1.42, 1.36, 1.25, 1.14, 1.03, 0.94, 0.88,
    2.65, 2.19, 2.12, 2.06, 1.98, 1.90, 1.83, 1.78,
      1.73, 1.69, 1.65, 1.61, 1.56, 1.45, 1.33, 1.23, 1.15, 1.08,
    2.98, 2.53, 1.95, 1.85, 2.47, 2.06, 2.05, 2.38,
      2.31, 2.33, 2.25, 2.28, 2.26, 2.26, 2.22, 2.22, 2.17, 2.08, 2.00,
      1.93, 1.88, 1.85, 1.80, 1.77, 1.74, 1.71, 1.56, 1.54, 1.43, 1.35, 1.27, 1.20,
    nil, nil, 1.95, 1.80, 1.80, 1.75, 1.75, 1.75, 1.75
  ]


  # Return atomic number from element symbol, e.g., H to 1.
  # If not found, raise CrystalCell::Element::NotExistError.
  def self.symbol_to_num(str)
    symbol = SYMBOLS.index( str )
    raise NotExistError, "Symbol #{str} not found." if (symbol == nil || symbol == 0)
    symbol
  end

  # Return element symbols from atomic number 'num', e.g., 1 to H
  # If not found, raise CrystalCell::Element::NotExistError.
  def self.num_to_symbol(num)
      raise NotExistError, "#{num} is not Fixnum." if (num.class != Fixnum)
      raise NotExistError, "#{num} is out of range." if (num <= 0 || SYMBOLS.size <= num)
      SYMBOLS[num]
  end

  # Return atomic radius.
  # 'id' can be indicated by number and elemet symbol.
  def self.radius(id)
    id = self.symbol_to_num(id) if id.class == String
    ATOMIC_RADII[id]
  end

end
