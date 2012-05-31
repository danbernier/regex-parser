# This is all based on http://swtch.com/~rsc/regexp/regexp1.html

class Match
  def sample(max_length)
    ''
  end

  def match?(chars)
    true
  end
end

class Node
  def initialize
    @edges = {}
  end

  def connect(val, node)
    @edges[val] = node
  end

  def sample(max_length=70)
    return '' if max_length == 0

    char, nxt = *@edges.to_a.sample
    char + nxt.sample(max_length-1)
  end

  def match?(chars)
    return match?(chars.split('')) unless chars.is_a? Array

    char = chars.shift
    @edges[char] && @edges[char].match?(chars)
  end
end


if $0 == __FILE__

  def test(pattern, *strings)
    5.times do
      puts pattern.sample
    end

    strings.each do |string|
      msg = pattern.match?(string) ? 'yes' : 'no'
      puts "#{string} -> #{msg}"
    end
  end

  # Let's build this: /ab+c/
  match = Match.new
  two = Node.new
  two.connect('c', match)
  two.connect('b', two)
  one = Node.new
  one.connect('b', two)
  start = Node.new
  start.connect('a', one)

  test(start, 'abc', 'ab', 'abbbbbbc')


  puts

  # Now, try /ab*c/
  match = Match.new
  one = Node.new
  one.connect('c', match)
  one.connect('b', one)
  start = Node.new
  start.connect('a', one)

  test(start, 'ac', 'abc', 'abbbbc', 'ab')


  puts

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

  test(start, 'ac', 'abc', 'abbc', 'abbbc', 'abbbbc')

end
