require 'minitest_helper'

class TestDonut < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Donut::VERSION
  end
end
