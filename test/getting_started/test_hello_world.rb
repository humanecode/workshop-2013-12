require "minitest/autorun"

class HelloWorld
  def greet name = "world"
    "Hello #{name}!"
  end
end

class HelloWorldTest < MiniTest::Unit::TestCase
  def test_greeting
    assert_equal "Hello world!", HelloWorld.new.greet
  end
end
