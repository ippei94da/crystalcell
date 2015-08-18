#! /usr/bin/ruby

require 'test/unit'

class TC_Povray_Element < Test::Unit::TestCase
  def setup
  end

  def test_radius
    assert_equal( 0.2, CrystalCell::Povray::Element.radius('H') )
  end

  def test_color
    assert_equal( [ 1.00, 0.80, 0.80 ], CrystalCell::Povray::Element.color('H' ) )
  end
end

