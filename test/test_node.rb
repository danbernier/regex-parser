require 'minitest/unit'
require 'minitest/autorun'

require_relative '../lib/node.rb'
require_relative '../lib/match.rb'

class Stuff < MiniTest::Unit::TestCase

  def plus_operator
    # /ab+c/
    match = Match.new
    two = Node.new
    two.connect('c', match)
    two.connect('b', two)
    one = Node.new
    one.connect('b', two)
    start = Node.new
    start.connect('a', one)
    start
  end

  def test_plus_operator_match
    pattern = plus_operator
    assert(pattern.match?('abc'))
    assert(pattern.match?('abbbbbbc'))
    refute(pattern.match?('ab'))
  end

  def test_plus_operator_sample
    pattern = plus_operator
    10.times do
      assert_match(/ab+c/, pattern.sample)
    end
  end

  def star_operator
    # /ab*c/
    match = Match.new
    one = Node.new
    one.connect('c', match)
    one.connect('b', one)
    start = Node.new
    start.connect('a', one)
    start
  end

  def test_star_operator_match
    pattern = star_operator
    assert(pattern.match?('ac'))
    assert(pattern.match?('abc'))
    assert(pattern.match?('abbbbc'))
    refute(pattern.match?('ab'))
  end

  def test_star_operator_sample
    pattern = star_operator
    10.times do
      assert_match(/ab*c/, pattern.sample)
    end
  end

  def group_with_plus_operator
    # /a(bb)+c/
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
    start
  end

  def test_group_with_plus_operator_match
    pattern = group_with_plus_operator
    assert(pattern.match?('abbc'))
    assert(pattern.match?('abbbbc'))
    refute(pattern.match?('ac'))
    refute(pattern.match?('abc'))
    refute(pattern.match?('abbbc'))
  end

  def test_group_with_plus_operator_sample
    pattern = group_with_plus_operator
    10.times do
      assert_match(/a(bb)+c/, pattern.sample)
    end
  end

  def question_mark_operator
    # /ab?c/
    match = Match.new
    two = Node.new
    two.connect('c', match)
    one = Node.new
    one.connect('b', two)
    one.connect('c', match)
    start = Node.new
    start.connect('a', one)
    start
  end

  def test_question_mark_operator_match
    pattern = question_mark_operator
    assert(pattern.match?('ac'))
    assert(pattern.match?('abc'))
    refute(pattern.match?('abbc'))
  end

  def test_question_mark_operator_sample
    pattern = question_mark_operator
    10.times do
      assert_match(/ab?c/, pattern.sample)
    end
  end
end
