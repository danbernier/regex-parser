
class Node
  def initialize
    @edges = {}
  end

  def connect(val, node)
    @edges[val] ||= []
    @edges[val].push(node)
  end

  def next_nodes(val)
    @edges[val] || []
  end

  def sample(max_length=70)
    return '' if max_length == 0

    char = @edges.keys.sample
    nxt = @edges[char]
    nxt = nxt.sample

    char + nxt.sample(max_length-1)
  end

  def match?(chars)
    char = chars.shift
    @edges[char] && @edges[char].match?(chars)
  end
end
