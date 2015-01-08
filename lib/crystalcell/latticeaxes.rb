require "rubygems"
gem "malge"
require "malge/simultaneousequations.rb"

# Class to deal with lattice axes in three dimensional space,
# related to cell parameter and crystal axes.
# Lattice information cannot be changed after initialized. 
# 
# When lattice axes of three vectors are given,
# lattice axes are automatically converted as below.
#       - c axes in internal axis is along to z axis in cartesian axis.
#       - b axes in internal axis is on the b-c plane.
#       - a axes in internal axis is set to be a right-hand system.
#       E.g., 
#           [ [0.5, 0.5, 0.0], [0.5, 0.0, 0.5], [0.0, 0.5, 0.5] ]
#           will be converted to 
#           [ [0.57735, 0.20412, 0.35355],
#               [0.00000, 0.61237, 0.35355],
#               [0.00000, 0.00000, 0.70710]]
class CrystalCell::LatticeAxes < Mageo::Axes

    class InitializeError < Exception; end
    class ArgumentError < Exception; end
    class TypeError < Exception; end

    include Math
    include Mageo

    # Argument 'vectors' is three vectors with the order of a, b, c.
    # If you want to make LatticeAxes instances from lattice constants,
    # you should convert to axes with LatticeAxes.lc_to_axes
    # 任意の向きのベクトルを渡しても、必ず triangulate する。
    def initialize(vectors)
        raise InitializeError, "#{vectors.inspect}" unless vectors.size == 3

        if vectors.class == CrystalCell::LatticeAxes
            @axes = vectors
        else
            begin
                vectors = self.class.triangulate(vectors)
            rescue Vector3D::RangeError
                raise InitializeError, "#{vectors.inspect}"
            end

            super(vectors)
        end
    end


    ## Class methods

    # Generate new instance from lattice constants.
    def self.new_lc(lc)
        vec = CrystalCell::LatticeAxes.lc_to_axes(lc)
        CrystalCell::LatticeAxes.new(vec)
    end

    # Convert six lattice constants to three axes.
    # Set true to the argument of 'righthand' if a assumed lattice has righthand axis system.
    def self.lc_to_axes(lc, righthand = true)
        raise ArgumentError if (lc.size != 6)

        a = lc[0]
        b = lc[1]
        c = lc[2]
        alpha = (2.0*PI) * lc[3] / 360.0 # radian
        beta    = (2.0*PI) * lc[4] / 360.0 # radian
        gamma = (2.0*PI) * lc[5] / 360.0 # radian

        v_c = Vector3D[0.0, 0.0, c]
        v_b = Vector3D[0.0, b * Math::sin(alpha), b * Math::cos(alpha)]
        v_a_z = a * Math::cos(beta)
        v_a_y = (a * (Math::cos(gamma) - Math::cos(alpha) * Math::cos(beta)))/ Math::sin(alpha)
        v_a_x = Math::sqrt(a**2 - v_a_y**2 - v_a_z**2)
        v_a_x *= -1.0 if righthand == false
        v_a = Vector3D[v_a_x, v_a_y, v_a_z]
        return [v_a, v_b, v_c]
    end

    # Convert three axes to six lattice constants.
    def self.axes_to_lc(axes)
        axes.collect!{|i| Vector3D[*i] }
        a = axes[0].r
        b = axes[1].r
        c = axes[2].r
        alpha = axes[1].angle_degree(axes[2])
        beta    = axes[2].angle_degree(axes[0])
        gamma = axes[0].angle_degree(axes[1])
        return [ a, b, c, alpha, beta, gamma ]
    end

    # Return true if the relation of vector order is righthand system.
    def self.righthand?(axes)
        axes.map! { |i| Vector3D[*i] }
        return true if Vector3D.scalar_triple_product(*axes) > 0.0
        return false
    end

    # Return true if the relation of vector order is lefthand system.
    def self.lefthand?(axes)
        axes.map! { |i| Vector3D[*i] }
        return true if Vector3D.scalar_triple_product(*axes) < 0.0
        return false
    end

    # Convert three axes to three axes with rules below:
    #       c axis is along z axis in cartesian system.
    #       b axis is on y-z plane in cartesian system.
    # Return an array of three Vector3D instances.
    # This class does not convert righthand to lefthand system.
    # The name of this method 'triangulate' originates from the
    # matrix indicating the vectors being triangular matrix.
    #
    # クラスメソッドは廃止の方向で。
    # vectors の数をチェックするのは initialize でやるべきことだろうし、
    # LatticeAxes クラスインスタンス以外で triangulate を使う場面が想像できない。
    #
    def self.triangulate(vectors)
        vectors.map! { |i| Vector3D[*i] }
        raise InitializeError if self.dependent?(vectors)
        lc = self.axes_to_lc(vectors)
        righthand = self.righthand?(vectors)
        return self.lc_to_axes(lc, righthand)
    end

    ## Instance methods.

    # Get lattice constants in six values.
    def get_lattice_constants
        return CrystalCell::LatticeAxes.axes_to_lc(@axes)
    end

    def righthand?
        self.class.righthand?(@axes)
    end

    def lefthand?
        self.class.lefthand?(@axes)
    end

    # This class is obsoleted. [2011-12-22]
    ## Convert internal coordinates to cartesian coordinates.
    ## Return a Vector3DInternal class instance, which is not a cartesian vector.
    #def internal2cartesian(internal_coord)
    # Vector3DInternal[ *internal_coord ].to_v3d(axes)
    #end

    # This class is obsoleted. [2011-12-22]
    ## Convert cartesian coordinates to internal coordinates.
    ## Return a Vector3D class instance, which is a cartesian vector.
    #def cartesian2internal(cartesian_coord)
    # #pp cartesian_coord
    # Vector3D[ *cartesian_coord ].to_v3di(axes)
    #end

    # Compare <other> CrystalCell::LatticeAxes instance.
    # <length_ratio> is tolerance of ratio in length of axes.
    # <angle_tolerance> is tolerance of value in angle between axes.
    def equal_in_delta?(other, length_ratio, angle_tolerance)
        length_a = self .get_lattice_constants[0..2]
        length_b = other.get_lattice_constants[0..2]
        3.times do |i|
            return false unless ((length_a[i] - length_b[i]).abs <= length_ratio)
        end

        angle_a  = self .get_lattice_constants[3..5]
        angle_b  = other.get_lattice_constants[3..5]
        3.times do |i|
            return false unless ((angle_a[i] - angle_b[i]).abs <=    angle_tolerance)
        end
        return true
    end

    def ==(other)
        3.times do |i|
            3.times do |j|
                return false if self[i][j] != other[i][j]
            end
        end
        return true
    end

    private

    def triangulate
        #self.class.triangulate(@axes)
    # rotate(2, 2, 1)
    # rotate(2, 0, 2)
    # rotate(1, 2, 1)
    end

    #private

    ## 保持する全ての軸を回転する。
    ## 以下の index は Axes クラス保持している配列における index。
    ## target_index          回転の際の角度を決めるベクトルの
    ##  self が保持する内部座標軸の index。
    ## center_axis_index 回転の中心軸のベクトルの index in x, y, z。
    ## plane_axis_index) 回転の目的地となる平面を、中心軸と共に構成するベクトルの index
    ##  in x, y, z。
    #def rotate(target_index, center_axis_index, plane_axis_index)
    # theta = 

    # axes[target_index]
    # 
    # HERE

    # self.each do |vector|
    #       vector
    # end
    #end

end
