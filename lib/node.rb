
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
