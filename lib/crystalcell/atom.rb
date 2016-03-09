raise "Atom class need ruby version later than 1.9." if RUBY_VERSION.to_f < 1.9

# Class for an atom in a cell.
# This class doesn't have lattice information.
# Forbid changes in internal information. When you want to change, you can make a new instance.
# This class is not assumeed in a periodic condition.
class CrystalCell::Atom

    include Mageo

    class TypeError < StandardError ; end

    # Do not change :position to attr_accessor.
    # This must be Vector3DInternal instance.
    attr_reader :movable_flags
    attr_accessor :element, :name, :position

    # Arguments:
    #       elements:
    #           Identifier of a element.
    #           This may be String like "Li", Integer like 0, or other class instances.
    #           Why doesn't this class have concrete name of elements?
    #           The reason is below:
    #               - This class is assumed to be used in Cell class instances.
    #                   When we treat symmetry of the cell, the elements of atoms are not necessary information.
    #                   This specification enable highly abstract level of treatment of cells.
    #               - POSCAR file of VASP (before ver.4 series) don't have element information.
    #                   This specification enable to use POSCAR directly without POTCAR or element indication.
    #       position:
    #           Coordinates of an atom.
    #           This argument 'position' is mainly assumed as a internal coordinate.
    #       name:
    #           Identifier of an atom, e.g., "Li1" or "O23".
    #       movable_flags: 
    #           Movable flags of an atom in each of three directions as a Array of three items.
    def initialize(element, position, name = nil, movable_flags = nil)
        raise TypeError, "Position doesn't have []: (#{position.inspect})" unless position.methods.include?(:[])
        raise TypeError, "Number of items in position is not 3: (#{position})" if position.size != 3
        raise TypeError, "Coordinate is not a Float: (#{position})" if position[0].class != Float
        raise TypeError, "Coordinate is not a Float: (#{position})" if position[1].class != Float
        raise TypeError, "Coordinate is not a Float: (#{position})" if position[2].class != Float

        @element = element
        set_position(position)
        @name = name
        @movable_flags = movable_flags
    end

    ## Class methods

    # Equivalence checking (class method version).
    # Return true when all the condition below are satisfied:
    #       - same element identifier.
    #       - difference of coordinates is within tolerance.
    # Note that distance cannot be used since this class doesn't have a lattice axes.
    # Imagine the shape of tolerant zone is a hexahedron.
    def self.equal_in_delta?(atom0, atom1, tol = 0.0)
        return false if atom0.element != atom1.element
        3.times do |i|
            return false if ((atom0.position[i] - atom1.position[i]).abs > tol)
        end
        return true
    end

    ## Instance methods

    # Restricted equivalence checking.
    # Return true when all the condition below are satisfied:
    #       - same element identifier.
    #       - difference of coordinates is the same.
    # This method should be used after well-consideration.
    # Arbitrary coordinates are not generally the same like Float instances.
    # It is a good idea to use in test scripts.
    def ==(other)
        #pp self
        #pp other
        self.class.equal_in_delta?(self, other, 0.0)
    end

    # Equivalence checking (instance method version) .
    # Return true when all the condition below are satisfied:
    #       - same element identifier.
    #       - difference of coordinates is within tolerance.
    def equal_in_delta?(other, tol = 0.0)
        self.class.equal_in_delta?(self, other, tol)
    end

    #Return Vector3DInternal instance consist of coordinates between 0 and 1.
    def internal_coordinates
        result = @position.map{ |coord| coord - coord.floor }
        return Vector3DInternal[ *result ]
    end

    # Return Vector3DInternal instance consist of integers,
    # by which self.internal_coordinates translate to self.position.
    def translation_symmetry_operation
        result = @position.map{ |coord| coord.floor }
        return Vector3DInternal[ *result ]
    end

    # Overwrite position.
    def set_position(position)
        #pp position
        #pp position.class
        raise TypeError, "#{position.class}" if position.class == Vector3D
        @position = position.to_v3di
    end

    # Translate atom position (destructive).
    # Argument 'vec' should be given as internal vector,
    # which is an Array or Vector3DInternal instance but Vector3D instance.
    def translate!(vec)
        raise TypeError if vec.class == Vector3D
        raise TypeError if vec.size != 3
        self.set_position(@position + Vector3DInternal[ *vec ])
    end

    # Translate atom position (nondestructive).
    # Argument 'vec' should be given as internal vector,
    # which is an Array or Vector3DInternal instance but Vector3D instance.
    def translate(vec)
        tmp = Marshal.load(Marshal.dump(self))
        tmp.translate!(vec)
        return tmp
    end

end

