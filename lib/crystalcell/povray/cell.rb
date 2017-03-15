#! /usr/bin/env ruby # coding: utf-8

class CrystalCell::Povray::Cell < CrystalCell::Cell
  RADIUS_RATIO = 0.3
  
  LATTICE_RADIUS = 0.02
  LATTICE_COLOR  = [0.50, 0.50, 0.50]
  BOND_RADIUS    = 0.05
  #BOND_COLOR     = [0.75, 0.75, 0.75]


  class SizeError < StandardError; end
  class AtomNotFoundError < StandardError; end

  # povray 形式の文字列を返す。
  def to_pov
    #return atoms_to_povs + bonds_to_povs + lattice_to_povs
    return atoms_to_povs + lattice_to_povs
  end

  def dump(io)
    self.to_pov.each do |line|
      io.print line
    end
  end

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

  # Return povray format string to draw bond between two atoms.
  # contents should be like ['Na1', 'Cl2'] # (element + number)
  def bond(atomids)
    #pp atomids
    if atomids.size != 2
      raise SizeError
    end
    atoms = []
    atomids.each do |atomid|
      atom = atom_by_id(atomid)
      raise AtomNotFoundError, atomid unless atom
      atoms << atom
    end
    intermediate =
      (( atoms[0].position +  atoms[1].position )/ 2.0) .to_v3d(self.axes)
    results = []
    atoms.each do |atom|
      cyl = CrystalCell::Povray::Cylinder.new(
        atom.position.to_v3d(self.axes),
        intermediate,
        BOND_RADIUS,
        CrystalCell::Povray::Element.color( atom.element)
      )
      results << cyl.to_pov
    end
    results.join("\n")
  end

  # Return povray format string to draw triangle among three atoms.
  # contents should be like ['Na1', 'Cl2', 'Cl3'] # (element + number from 1)
  # Color is set as 0th item in atomids
  def triangle(atomids)
    if atomids.size != 3
      raise SizeError
    end
    atoms = []
    atomids.each do |atomid|
      atom = atom_by_id(atomid)
      raise AtomNotFoundError, atomid unless atom
      atoms << atom
    end
    #pp atoms
    tri  = CrystalCell::Povray::Triangle.new(
      *atoms.map { |atom| atom.position.to_v3d(self.axes)},
      CrystalCell::Povray::Element.color( atoms[0].element)
    )
    tri.to_pov
  end

  # Return povray format string to draw tetrahedron among four atoms.
  # contents should be like ['Na1', 'Cl2', 'Cl3', 'Cl4'] # (element + number from 1)
  # Color is set as 0th item in atomids
  def tetrahedron(atomids)
    if atomids.size != 4
      raise SizeError
    end
    atoms = []
    atomids.each do |atomid|
      atom = atom_by_id(atomid)
      raise AtomNotFoundError, atomid unless atom
      atoms << atom
    end
    #pp atoms
    tetra  = CrystalCell::Povray::Tetrahedron.new(
      *atoms.map { |atom| atom.position.to_v3d(self.axes)},
      CrystalCell::Povray::Element.color( atoms[0].element)
    )
    tetra.to_pov
  end

  # 格子の棒を描画するための pov 形式文字列を返す。
  def lattice_to_povs # should be changed to 'lattice'
    v000 = Vector3DInternal[ 0.0, 0.0, 0.0 ].to_v3d(self.axes)
    v001 = Vector3DInternal[ 0.0, 0.0, 1.0 ].to_v3d(self.axes)
    v010 = Vector3DInternal[ 0.0, 1.0, 0.0 ].to_v3d(self.axes)
    v011 = Vector3DInternal[ 0.0, 1.0, 1.0 ].to_v3d(self.axes)
    v100 = Vector3DInternal[ 1.0, 0.0, 0.0 ].to_v3d(self.axes)
    v101 = Vector3DInternal[ 1.0, 0.0, 1.0 ].to_v3d(self.axes)
    v110 = Vector3DInternal[ 1.0, 1.0, 0.0 ].to_v3d(self.axes)
    v111 = Vector3DInternal[ 1.0, 1.0, 1.0 ].to_v3d(self.axes)

    results = []
    cy = CrystalCell::Povray::Cylinder
    r = LATTICE_RADIUS
    c = LATTICE_COLOR
    results << cy.new(v000, v001, r, c).to_pov.to_s + "\n"
    results << cy.new(v010, v011, r, c).to_pov.to_s + "\n"
    results << cy.new(v100, v101, r, c).to_pov.to_s + "\n"
    results << cy.new(v110, v111, r, c).to_pov.to_s + "\n"
    results << cy.new(v000, v010, r, c).to_pov.to_s + "\n"
    results << cy.new(v100, v110, r, c).to_pov.to_s + "\n"
    results << cy.new(v001, v011, r, c).to_pov.to_s + "\n"
    results << cy.new(v101, v111, r, c).to_pov.to_s + "\n"
    results << cy.new(v000, v100, r, c).to_pov.to_s + "\n"
    results << cy.new(v001, v101, r, c).to_pov.to_s + "\n"
    results << cy.new(v010, v110, r, c).to_pov.to_s + "\n"
    results << cy.new(v011, v111, r, c).to_pov.to_s + "\n"
    results
  end

  # Return atom from 'atom_id' like 'Na1' or 'Na1-556'.
  def atom_by_id(atom_id)
    elem_num, perio = atom_id.split('-')
    /^(\D+)(\d+)/ =~ elem_num
    elem = $1
    num = $2
    perio ||= '555'
    atom = atoms_of_element(elem)[num.to_i - 1]
    vec = perio.split(//).map { |figure| figure.to_i - 5 }
    atom.translate(vec.to_v3di)
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
