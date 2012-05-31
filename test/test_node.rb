require 'minitest/unit'
require 'minitest/autorun'

require_relative '../lib/node.rb'
require_relative '../lib/match.rb'

class Stuff < MiniTest::Unit::TestCase

  def test_plus_operator
    
    # Let's build this: /ab+c/
    match = Match.new
    two = Node.new
    two.connect('c', match)
    two.connect('b', two)
    one = Node.new
    one.connect('b', two)
    start = Node.new
    start.connect('a', one)

    assert(start.match?('abc'))
    assert(start.match?('abbbbbbc'))
    refute(start.match?('ab'))

    10.times do
      assert_match(/ab+c/, start.sample)
    end
  end

  def test_star_operator

    # Now, try /ab*c/
    match = Match.new
    one = Node.new
    one.connect('c', match)
    one.connect('b', one)
    start = Node.new
    start.connect('a', one)

    assert(start.match?('ac'))
    assert(start.match?('abc'))
    assert(start.match?('abbbbc'))
    refute(start.match?('ab'))

    10.times do
      assert_match(/ab*c/, start.sample)
    end
  end

  def test_group_with_plus_operator

    # Now try /a(bb)+c/
    match = Match.new
    three = Node.new
    three.connect('c', match)
    two = Node.new
    two.connect('b', three)
    three.connect('b', two)
    one = Node.new
    one.connect('b', two)
    start = Node.new
    start.connect('a', one)

    assert(start.match?('abbc'))
    assert(start.match?('abbbbc'))
    refute(start.match?('ac'))
    refute(start.match?('abc'))
    refute(start.match?('abbbc'))

    10.times do
      assert_match(/a(bb)+c/, start.sample)
    end
  end

  def test_question_mark_operator

    # Try /ab?c/
    match = Match.new
    two = Node.new
    two.connect('c', match)
    one = Node.new
    one.connect('b', two)
    one.connect('c', match)
    start = Node.new
    start.connect('a', one)

    assert(start.match?('ac'))
    assert(start.match?('abc'))
    refute(start.match?('abbc'))

    10.times do
      assert_match(/ab?c/, start.sample)
    end
  end
end
