require 'minitest_helper'

class TestDonutApp < Minitest::Test
  def test_that_it_exists
    refute_nil ::Donut::App
  end

  def test_that_it_implements_the_minimum_hooks
    app = Donut::App.new 'hello/world'

    assert app.methods.include? :install
    assert app.methods.include? :serve
    assert app.methods.include? :test
    assert app.methods.include? :deploy
  end
  
  def test_that_it_can_run_system_commands
    app = Donut::App.new 'hello/world'

    result = app.send(:run, 'echo "Hello World!"')
    assert result
  end
end
