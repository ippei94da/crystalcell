#! /usr/bin/env ruby
# coding: utf-8

require "pp"
require "helper"
#require "test/unit"
#require "pkg/klass.rb"

$tolerance = 1.0E-10

class TC_Color < Test::Unit::TestCase
  #def setup
  #  @k = Color.new
  #end
  #
  COLOR = CrystalCell::Povray::Color
  PI = Math::PI

  def test_self_circle_color
    results = COLOR.circle_color((2.0 * PI) * 0.0)
    assert_in_delta(1.0, results[0], $tolerance)
    assert_in_delta(0.0, results[1], $tolerance)
    assert_in_delta(0.0, results[2], $tolerance)

    results = COLOR.circle_color((2.0 * PI) * (1.0/6.0))
    assert_in_delta(1.0, results[0], $tolerance)
    assert_in_delta(1.0, results[1], $tolerance)
    assert_in_delta(0.0, results[2], $tolerance)

    results = COLOR.circle_color((2.0 * PI) * (2.0/6.0))
    assert_in_delta(0.0, results[0], $tolerance)
    assert_in_delta(1.0, results[1], $tolerance)
    assert_in_delta(0.0, results[2], $tolerance)

    results = COLOR.circle_color((2.0 * PI) * (3.0/6.0))
    assert_in_delta(0.0, results[0], $tolerance)
    assert_in_delta(1.0, results[1], $tolerance)
    assert_in_delta(1.0, results[2], $tolerance)

    results = COLOR.circle_color((2.0 * PI) * (4.0/6.0))
    assert_in_delta(0.0, results[0], $tolerance)
    assert_in_delta(0.0, results[1], $tolerance)
    assert_in_delta(1.0, results[2], $tolerance)

    results = COLOR.circle_color((2.0 * PI) * (5.0/6.0))
    assert_in_delta(1.0, results[0], $tolerance)
    assert_in_delta(0.0, results[1], $tolerance)
    assert_in_delta(1.0, results[2], $tolerance)

    results = COLOR.circle_color(2.0 * PI)
    assert_in_delta(1.0, results[0], $tolerance)
    assert_in_delta(0.0, results[1], $tolerance)
    assert_in_delta(0.0, results[2], $tolerance)


    results = COLOR.circle_color((2.0 * PI) * (1.0/12.0))
    assert_in_delta(1.0, results[0], $tolerance)
    assert_in_delta(0.5, results[1], $tolerance)
    assert_in_delta(0.0, results[2], $tolerance)

    # out of range , 0 <= theta < pi
    results = COLOR.circle_color((2.0 * PI) * (9.0/6.0))
    assert_in_delta(0.0, results[0], $tolerance)
    assert_in_delta(1.0, results[1], $tolerance)
    assert_in_delta(1.0, results[2], $tolerance)

    results = COLOR.circle_color((2.0 * PI) * (-3.0/6.0))
    assert_in_delta(0.0, results[0], $tolerance)
    assert_in_delta(1.0, results[1], $tolerance)
    assert_in_delta(1.0, results[2], $tolerance)
  end

  def test_trapezoidal_wave
    assert_in_delta(0.0, COLOR.trapezoidal_wave(( 0.0/12.0)*2.0*PI, 0.0), $tolerance)
    assert_in_delta(0.5, COLOR.trapezoidal_wave(( 1.0/12.0)*2.0*PI, 0.0), $tolerance)
    assert_in_delta(1.0, COLOR.trapezoidal_wave(( 2.0/12.0)*2.0*PI, 0.0), $tolerance)
    assert_in_delta(1.0, COLOR.trapezoidal_wave(( 3.0/12.0)*2.0*PI, 0.0), $tolerance)
    assert_in_delta(1.0, COLOR.trapezoidal_wave(( 4.0/12.0)*2.0*PI, 0.0), $tolerance)
    assert_in_delta(1.0, COLOR.trapezoidal_wave(( 5.0/12.0)*2.0*PI, 0.0), $tolerance)
    assert_in_delta(1.0, COLOR.trapezoidal_wave(( 6.0/12.0)*2.0*PI, 0.0), $tolerance)
    assert_in_delta(0.5, COLOR.trapezoidal_wave(( 7.0/12.0)*2.0*PI, 0.0), $tolerance)
    assert_in_delta(0.0, COLOR.trapezoidal_wave(( 8.0/12.0)*2.0*PI, 0.0), $tolerance)
    assert_in_delta(0.0, COLOR.trapezoidal_wave(( 9.0/12.0)*2.0*PI, 0.0), $tolerance)
    assert_in_delta(0.0, COLOR.trapezoidal_wave((10.0/12.0)*2.0*PI, 0.0), $tolerance)
    assert_in_delta(0.0, COLOR.trapezoidal_wave((11.0/12.0)*2.0*PI, 0.0), $tolerance)

    assert_in_delta(1.0, COLOR.trapezoidal_wave(( 0.0/12.0)*2.0*PI, PI), $tolerance)
    assert_in_delta(0.5, COLOR.trapezoidal_wave(( 1.0/12.0)*2.0*PI, PI), $tolerance)
    assert_in_delta(0.0, COLOR.trapezoidal_wave(( 2.0/12.0)*2.0*PI, PI), $tolerance)
    assert_in_delta(0.0, COLOR.trapezoidal_wave(( 3.0/12.0)*2.0*PI, PI), $tolerance)
    assert_in_delta(0.0, COLOR.trapezoidal_wave(( 4.0/12.0)*2.0*PI, PI), $tolerance)
    assert_in_delta(0.0, COLOR.trapezoidal_wave(( 5.0/12.0)*2.0*PI, PI), $tolerance)
    assert_in_delta(0.0, COLOR.trapezoidal_wave(( 6.0/12.0)*2.0*PI, PI), $tolerance)
    assert_in_delta(0.5, COLOR.trapezoidal_wave(( 7.0/12.0)*2.0*PI, PI), $tolerance)
    assert_in_delta(1.0, COLOR.trapezoidal_wave(( 8.0/12.0)*2.0*PI, PI), $tolerance)
    assert_in_delta(1.0, COLOR.trapezoidal_wave(( 9.0/12.0)*2.0*PI, PI), $tolerance)
    assert_in_delta(1.0, COLOR.trapezoidal_wave((10.0/12.0)*2.0*PI, PI), $tolerance)
    assert_in_delta(1.0, COLOR.trapezoidal_wave((11.0/12.0)*2.0*PI, PI), $tolerance)

    assert_in_delta(1.0, COLOR.trapezoidal_wave((-6.0/12.0)*2.0*PI, 0.0), $tolerance)
    assert_in_delta(1.0, COLOR.trapezoidal_wave((18.0/12.0)*2.0*PI, 0.0), $tolerance)
  end
end

#! /usr/bin/env ruby # coding: utf-8

