require 'treetop'
require 'regex_parser'

class TestRegexParser < MiniTest::Unit::TestCase
  def test_can_spot_literals
    assert(RegexParser.new.parse('abc').node == [[:literal, 'a'], [:literal, 'b'], [:literal, 'c']])
  end
end
