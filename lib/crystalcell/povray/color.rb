#! /usr/bin/env ruby
# coding: utf-8

#
#
#
class CrystalCell::Povray::Color

  PI = Math::PI
  #
  def initialize()
  end

  # R,G,B のいずれかの色の theta における強度を返す。
  def self.round_color(theta)

    #theta = theta % (2*PI); #-2*pi 〜 +2*pi の範囲に入る

    #if (0.0/6.0)*(2.0*PI) <= theta && theta < (1.0/6.0)*(2.0*PI))
    #  r = 0.0
    #  g = theta/((1/6)*(2*PI))
    #elsif (0.0/6.0)*(2.0*PI) <= theta && theta < (1.0/6.0)*(2.0*PI))
    #    intensity = 1;

    #  ((3/6)*(2*PI) , (4/6)*(2*PI))
    #    intensity = 4-theta/((1/6)*(2*PI)) ;

    #  ((4/6)*(2*PI) , (6/6)*(2*PI))
    #    intensity = 0;
    #intensity
  end

  def self.intensity(theta, shift)
    theta /= (2*PI)
    theta -= theta.to_i
    if (0.0/6.0)*(2.0*PI) <= theta && theta < (1.0/6.0)*(2.0*PI))
      return 1.0
    elsif (1.0/6.0)*(2.0*PI) <= theta && theta < (2.0/6.0)*(2.0*PI))
      return 1.0 -theta
    HERE
  end

end

  #      thetaBase: その色が上がり始める点を基準とする。R ならば 4π/3
