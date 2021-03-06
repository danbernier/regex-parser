require 'matcher'
require 'sampler'
require 'node'
require 'match'

class TestMatcherAndSampler < MiniTest::Unit::TestCase

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
    pattern = Matcher.new(plus_operator)
    assert(pattern.match?('abc'))
    assert(pattern.match?('abbbbbbc'))
    refute(pattern.match?('ab'))
  end

  def test_plus_operator_sample
    pattern = Sampler.new(plus_operator)
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
    pattern = Matcher.new(star_operator)
    assert(pattern.match?('ac'))
    assert(pattern.match?('abc'))
    assert(pattern.match?('abbbbc'))
    refute(pattern.match?('ab'))
  end

  def test_star_operator_sample
    pattern = Sampler.new(star_operator)
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
    pattern = Matcher.new(group_with_plus_operator)
    assert(pattern.match?('abbc'))
    assert(pattern.match?('abbbbc'))
    refute(pattern.match?('ac'))
    refute(pattern.match?('abc'))
    refute(pattern.match?('abbbc'))
  end

  def test_group_with_plus_operator_sample
    pattern = Sampler.new(group_with_plus_operator)
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
    pattern = Matcher.new(question_mark_operator)
    assert(pattern.match?('ac'))
    assert(pattern.match?('abc'))
    refute(pattern.match?('abbc'))
  end

  def test_question_mark_operator_sample
    pattern = Sampler.new(question_mark_operator)
    10.times do
      assert_match(/ab?c/, pattern.sample)
    end
  end



  def test_nfa_match
    # /a(bb)+c/
    match = Match.new
    three = Node.new
    three.connect('c', match)
    two = Node.new
    two.connect('b', three)
    one = Node.new
    one.connect('b', two)
    two.connect('b', one)
    start = Node.new
    start.connect('a', one)


    pattern = Matcher.new(start)
    assert(pattern.match?('abbc'))
    assert(pattern.match?('abbbbc'))
    refute(pattern.match?('ac'))
    refute(pattern.match?('abc'))
    refute(pattern.match?('abbbc'))
  end
end
