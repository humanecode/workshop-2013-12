require "minitest/autorun"

class TestArithmetic < MiniTest::Unit::TestCase
  def test_one_plus_one_is_two
    assert_equal 2, 1 + 1
  end

  def test_one_plus_one_isnt_zero
    refute_equal 0, 1 + 1
  end

  def test_one_divided_by_zero_float_is_infinity
    assert_equal Float::INFINITY, 1 / 0.0
  end

  def test_one_divided_by_zero_int_raises
    assert_raises ZeroDivisionError do
      1 / 0
    end
  end
end
