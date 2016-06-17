#! /usr/bin/env ruby # coding: utf-8

class CrystalCell::Povray::Cell < CrystalCell::Cell
  RADIUS_RATIO = 0.3
  
  LATTICE_RADIUS = 0.1
  LATTICE_COLOR  = [0.50, 0.50, 0.50]
  BOND_RADIUS    = 0.05
  BOND_COLOR     = [0.75, 0.75, 0.75]

  # povray 形式の文字列を返す。
  def to_pov
    return atoms_to_pov + bonds_to_pov + lattice_to_pov
  end

  # indicate camera position as polar coordinate)
  def gen_image(r, theta, phi)
    
  end

  def gen_4in1_images
  end

  #private

  # 原子を描画するための pov 形式文字列を返す。
  # 周期境界近傍の原子が tolerance 未満ならば、反対側のセル境界にも描画する。
  def atoms_to_povs(tolerance = 0.0)
    results = []
    atoms.each do |atom|
      periodic_translations(atom.position, tolerance).each do |translation|
        results << atom_to_pov(atom.translate(translation))
      end
    end
    results
  end

  # 原子間の連結棒を描画するための pov 形式文字列を返す。
  # E.g.,
  #   elem0 = 'O'
  #   elem1 = 'Li'
  #   min_distance = 0.0
  #   max_distance = 1.0
  # 上記の指定の場合、O-O 間かつ距離が 0.0〜1.0 の原子間のみ
  # bond を出力する。
  def bonds_to_povs(elem0, elem1, min_distance, max_distance)
    results = []
    cell = self.to_pcell
    cell.find_bonds(elem0, elem1, min_distance, max_distance).each do |pair|
      cart0 = pair[0].to_v3d(self.axes)
      cart1 = pair[1].to_v3d(self.axes)
      midpoint = Mageo::Vector3D.midpoint(cart0, cart1)
      results << Mageo::Cylinder.new(
        [cart0, midpoint], BOND_RADIUS).to_pov(
          CrystalCell::Povray::Element.color(elem0)) + "\n"
      results << Mageo::Cylinder.new(
        [cart1, midpoint], BOND_RADIUS).to_pov(
          CrystalCell::Povray::Element.color(elem1)) + "\n"
    end
    results
  end

  # 格子の棒を描画するための pov 形式文字列を返す。
  def lattice_to_povs
    v000 = Vector3DInternal[ 0.0, 0.0, 0.0 ].to_v3d(self.axes)
    v001 = Vector3DInternal[ 0.0, 0.0, 1.0 ].to_v3d(self.axes)
    v010 = Vector3DInternal[ 0.0, 1.0, 0.0 ].to_v3d(self.axes)
    v011 = Vector3DInternal[ 0.0, 1.0, 1.0 ].to_v3d(self.axes)
    v100 = Vector3DInternal[ 1.0, 0.0, 0.0 ].to_v3d(self.axes)
    v101 = Vector3DInternal[ 1.0, 0.0, 1.0 ].to_v3d(self.axes)
    v110 = Vector3DInternal[ 1.0, 1.0, 0.0 ].to_v3d(self.axes)
    v111 = Vector3DInternal[ 1.0, 1.0, 1.0 ].to_v3d(self.axes)

    results = []
    results << Mageo::Cylinder.new([v000, v001], LATTICE_RADIUS).to_pov(LATTICE_COLOR).to_s + "\n"
    results << Mageo::Cylinder.new([v010, v011], LATTICE_RADIUS).to_pov(LATTICE_COLOR).to_s + "\n"
    results << Mageo::Cylinder.new([v100, v101], LATTICE_RADIUS).to_pov(LATTICE_COLOR).to_s + "\n"
    results << Mageo::Cylinder.new([v110, v111], LATTICE_RADIUS).to_pov(LATTICE_COLOR).to_s + "\n"
    results << Mageo::Cylinder.new([v000, v010], LATTICE_RADIUS).to_pov(LATTICE_COLOR).to_s + "\n"
    results << Mageo::Cylinder.new([v100, v110], LATTICE_RADIUS).to_pov(LATTICE_COLOR).to_s + "\n"
    results << Mageo::Cylinder.new([v001, v011], LATTICE_RADIUS).to_pov(LATTICE_COLOR).to_s + "\n"
    results << Mageo::Cylinder.new([v101, v111], LATTICE_RADIUS).to_pov(LATTICE_COLOR).to_s + "\n"
    results << Mageo::Cylinder.new([v000, v100], LATTICE_RADIUS).to_pov(LATTICE_COLOR).to_s + "\n"
    results << Mageo::Cylinder.new([v001, v101], LATTICE_RADIUS).to_pov(LATTICE_COLOR).to_s + "\n"
    results << Mageo::Cylinder.new([v010, v110], LATTICE_RADIUS).to_pov(LATTICE_COLOR).to_s + "\n"
    results << Mageo::Cylinder.new([v011, v111], LATTICE_RADIUS).to_pov(LATTICE_COLOR).to_s + "\n"
    results
  end

  private

  def atom_to_pov(atom)
    color  = CrystalCell::Povray::Element.color( atom.element)
    radius = CrystalCell::Povray::Element.draw_radius(atom.element) * RADIUS_RATIO
    Mageo::Sphere.new(atom.position.to_v3d(axes), radius).to_pov(color) +
    " // #{atom.element}" + "\n"
  end

  def periodic_translations(pos, tolerance)
    results = [Vector3DInternal[0.0, 0.0, 0.0]]

    3.times do |axis|
      tmp = Marshal.load(Marshal.dump(results))
      if (pos[axis] < tolerance)
        translation = Vector3DInternal[0.0, 0.0, 0.0]
        translation[axis] += 1.0
        tmp.each {|vec| results << vec + translation }
      end
      if (1.0 - tolerance < pos[axis])
        translation = Vector3DInternal[0.0, 0.0, 0.0]
        translation[axis] -= 1.0
        tmp.each {|vec| results << vec + translation }
      end
    end
    results
  end

end
