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
  end
end

#! /usr/bin/env ruby # coding: utf-8

