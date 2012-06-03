class Matcher

  def initialize(start)
    @start = start
  end

  def match?(chars)
    return match?(chars.split('')) unless chars.is_a? Array

    nodes = [@start]

    until chars.empty? || nodes.empty?
      # TODO But could we have a empty-string pattern? It should
      # probably match ALL strings, though. Unit test that.
      char = chars.shift
      nodes = nodes.map { |n| n.next_nodes(char) }.flatten.uniq
      return true if nodes.any? { |n| Match === n }
    end

    return false
  end
end
