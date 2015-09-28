require 'minitest_helper'

class TestDonutLogger < Minitest::Test
  def test_that_it_exists
    refute_nil ::Donut::Logger
  end
end
