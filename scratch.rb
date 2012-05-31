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

  # Let's build this: /ab+c/
  match = Match.new
  two = Node.new
  two.connect('c', match)
  two.connect('b', two)
  one = Node.new
  one.connect('b', two)
  start = Node.new
  start.connect('a', one)

  5.times do
    puts start.sample
  end

  ['abc', 'ab', 'abbbbbbc'].each do |string|
    msg = start.match?(string) ? 'yes' : 'no'
    puts "#{string} -> #{msg}"
  end


  puts

  # Now, try /ab*c/
  match = Match.new
  one = Node.new
  one.connect('c', match)
  one.connect('b', one)
  start = Node.new
  start.connect('a', one)

  5.times do
    puts start.sample
  end

  ['ac', 'abc', 'abbbbc', 'ab'].each do |string|
    msg = start.match?(string) ? 'yes' : 'no'
    puts "#{string} -> #{msg}"
  end

end
