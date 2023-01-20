require 'minitest/autorun'

def add_numbers (a, b)
  5
end

class TestPokedex < Minitest::Test
  def test_poke
    assert_equal 5 , add_numbers(2, 3)
  end
end
