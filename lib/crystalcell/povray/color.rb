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

  # 色相環(color circle) 上での色を、与えられた角度に対して返す。
  # 強度は [r, g, b] の配列で、0.0<=x<=1.0 の実数。
  def self.circle_color(theta)
    theta = theta % (2*PI); #-2*pi 〜 +2*pi の範囲に入る

    r = self.trapezoidal_wave(theta, (4.0/6.0) * 2.0 * PI)
    g = self.trapezoidal_wave(theta, (0.0/6.0) * 2.0 * PI)
    b = self.trapezoidal_wave(theta, (2.0/6.0) * 2.0 * PI)
    [r, g, b]
  end

  # 台形波
  def self.trapezoidal_wave(theta, phase)
    x = (theta - phase)/ (2.0*PI)
    x = x -  x.floor
    if (0.0/6.0) <= x && x < (1.0/6.0)
      return x * 6.0
    elsif (1.0/6.0) <= x && x < (3.0/6.0)
      return 1.0
    elsif (3.0/6.0) <= x && x < (4.0/6.0)
      return 4.0 - x * 6.0
    elsif (4.0/6.0) <= x && x < (6.0/6.0)
      return 0.0
    end
  end

end

  #      thetaBase: その色が上がり始める点を基準とする。R ならば 4π/3
