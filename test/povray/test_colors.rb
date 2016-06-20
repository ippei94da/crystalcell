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

  def test_self_round_color
    results = COLOR.round_color((2.0 * Math::PI) * 0.0)
    asser_in_delta(1.0, results[0], $tolerance)
    asser_in_delta(0.0, results[1], $tolerance)
    asser_in_delta(0.0, results[2], $tolerance)

    results = COLOR.round_color((2.0 * Math::PI) * (1.0/6.0))
    asser_in_delta(1.0, results[0], $tolerance)
    asser_in_delta(1.0, results[1], $tolerance)
    asser_in_delta(0.0, results[2], $tolerance)

    results = COLOR.round_color((2.0 * Math::PI) * (2.0/6.0))
    asser_in_delta(0.0, results[0], $tolerance)
    asser_in_delta(1.0, results[1], $tolerance)
    asser_in_delta(0.0, results[2], $tolerance)

    results = COLOR.round_color((2.0 * Math::PI) * (3.0/6.0))
    asser_in_delta(0.0, results[0], $tolerance)
    asser_in_delta(1.0, results[1], $tolerance)
    asser_in_delta(1.0, results[2], $tolerance)

    results = COLOR.round_color((2.0 * Math::PI) * (4.0/6.0))
    asser_in_delta(0.0, results[0], $tolerance)
    asser_in_delta(0.0, results[1], $tolerance)
    asser_in_delta(1.0, results[2], $tolerance)

    results = COLOR.round_color((2.0 * Math::PI) * (5.0/6.0))
    asser_in_delta(1.0, results[0], $tolerance)
    asser_in_delta(0.0, results[1], $tolerance)
    asser_in_delta(1.0, results[2], $tolerance)

    results = COLOR.round_color(2.0 * Math::PI)
    asser_in_delta(1.0, results[0], $tolerance)
    asser_in_delta(0.0, results[1], $tolerance)
    asser_in_delta(0.0, results[2], $tolerance)


    results = COLOR.round_color((2.0 * Math::PI) * (1.0/12.0))
    asser_in_delta(1.0, results[0], $tolerance)
    asser_in_delta(0.5, results[1], $tolerance)
    asser_in_delta(0.0, results[2], $tolerance)

    # out of range , 0 <= theta < pi
    results = COLOR.round_color((2.0 * Math::PI) * (9.0/6.0))
    asser_in_delta(0.0, results[0], $tolerance)
    asser_in_delta(1.0, results[1], $tolerance)
    asser_in_delta(1.0, results[2], $tolerance)

    results = COLOR.round_color((2.0 * Math::PI) * (-3.0/6.0))
    asser_in_delta(0.0, results[0], $tolerance)
    asser_in_delta(1.0, results[1], $tolerance)
    asser_in_delta(1.0, results[2], $tolerance)
  end

  def test_intensity
    asser_in_delta(1.0, COLOR.intensity(( 0.0/12.0)*2.0*Math::PI, 0.0), $tolerance)
    asser_in_delta(1.0, COLOR.intensity(( 1.0/12.0)*2.0*Math::PI, 0.0), $tolerance)
    asser_in_delta(1.0, COLOR.intensity(( 2.0/12.0)*2.0*Math::PI, 0.0), $tolerance)
    asser_in_delta(0.5, COLOR.intensity(( 3.0/12.0)*2.0*Math::PI, 0.0), $tolerance)
    asser_in_delta(0.0, COLOR.intensity(( 4.0/12.0)*2.0*Math::PI, 0.0), $tolerance)
    asser_in_delta(0.0, COLOR.intensity(( 5.0/12.0)*2.0*Math::PI, 0.0), $tolerance)
    asser_in_delta(0.0, COLOR.intensity(( 6.0/12.0)*2.0*Math::PI, 0.0), $tolerance)
    asser_in_delta(0.0, COLOR.intensity(( 7.0/12.0)*2.0*Math::PI, 0.0), $tolerance)
    asser_in_delta(0.0, COLOR.intensity(( 8.0/12.0)*2.0*Math::PI, 0.0), $tolerance)
    asser_in_delta(0.5, COLOR.intensity(( 9.0/12.0)*2.0*Math::PI, 0.0), $tolerance)
    asser_in_delta(1.0, COLOR.intensity((10.0/12.0)*2.0*Math::PI, 0.0), $tolerance)
    asser_in_delta(1.0, COLOR.intensity((11.0/12.0)*2.0*Math::PI, 0.0), $tolerance)

    asser_in_delta(0.0, COLOR.intensity(( 0.0/12.0)*2.0*Math::PI, Math::PI), $tolerance)
    asser_in_delta(0.0, COLOR.intensity(( 1.0/12.0)*2.0*Math::PI, Math::PI), $tolerance)
    asser_in_delta(0.0, COLOR.intensity(( 2.0/12.0)*2.0*Math::PI, Math::PI), $tolerance)
    asser_in_delta(0.5, COLOR.intensity(( 3.0/12.0)*2.0*Math::PI, Math::PI), $tolerance)
    asser_in_delta(1.0, COLOR.intensity(( 4.0/12.0)*2.0*Math::PI, Math::PI), $tolerance)
    asser_in_delta(1.0, COLOR.intensity(( 5.0/12.0)*2.0*Math::PI, Math::PI), $tolerance)
    asser_in_delta(1.0, COLOR.intensity(( 6.0/12.0)*2.0*Math::PI, Math::PI), $tolerance)
    asser_in_delta(1.0, COLOR.intensity(( 7.0/12.0)*2.0*Math::PI, Math::PI), $tolerance)
    asser_in_delta(1.0, COLOR.intensity(( 8.0/12.0)*2.0*Math::PI, Math::PI), $tolerance)
    asser_in_delta(0.5, COLOR.intensity(( 9.0/12.0)*2.0*Math::PI, Math::PI), $tolerance)
    asser_in_delta(0.0, COLOR.intensity((10.0/12.0)*2.0*Math::PI, Math::PI), $tolerance)
    asser_in_delta(0.0, COLOR.intensity((11.0/12.0)*2.0*Math::PI, Math::PI), $tolerance)

    asser_in_delta(0.0, COLOR.intensity((-6.0/12.0)*2.0*Math::PI, 0.0), $tolerance)
    asser_in_delta(0.0, COLOR.intensity((18.0/12.0)*2.0*Math::PI, 0.0), $tolerance)
  end
end

#! /usr/bin/env ruby # coding: utf-8

