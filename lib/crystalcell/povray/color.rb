#! /usr/bin/env ruby
# coding: utf-8

#
#
#
class CrystalCell::Povray::Color
  #
  def initialize()
  end

  # R,G,B のいずれかの色の theta における強度を返す。
  def self.round_color(theta)

    local phi = mod(theta - thetaBase, 2*pi); #-2*pi 〜 +2*pi の範囲に入る
    if (phi < 0)
      phi = phi + 2*pi;
    end

    local intensity = 0;
    switch (phi)
      ((0/6)*(2*pi) , (1/6)*(2*pi))
        intensity = phi/((1/6)*(2*pi)) ;

      ((1/6)*(2*pi) , (3/6)*(2*pi))
        intensity = 1;

      ((3/6)*(2*pi) , (4/6)*(2*pi))
        intensity = 4-phi/((1/6)*(2*pi)) ;

      ((4/6)*(2*pi) , (6/6)*(2*pi))
        intensity = 0;
    intensity
end

  #      thetaBase: その色が上がり始める点を基準とする。R ならば 4π/3
