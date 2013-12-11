require "minitest/autorun"

class HelloWorld
  def greet name = "world"
    "Hello #{name}!"
  end
end

class HelloWorldTest < MiniTest::Unit::TestCase
  def setup
    @greeter = HelloWorld.new
  end

  def test_greeting
    assert_equal "Hello world!", @greeter.greet
  end

  def test_greeting_with_name
    assert_equal "Hello Mike!", @greeter.greet("Mike")
  end
end
