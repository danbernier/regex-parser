
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

  def sample
    char = @edges.keys.sample
    [char, @edges[char].sample]
  end
end
