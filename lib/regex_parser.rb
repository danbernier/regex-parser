# Autogenerated from a Treetop grammar. Edits may be lost.


module Regex
  include Treetop::Runtime

  def root
    @root ||= :literals
  end

  module Literals0
    def node
      elements.map { |e| [:literal, e.text_value] }
    end
  end

  def _nt_literals
    start_index = index
    if node_cache[:literals].has_key?(index)
      cached = node_cache[:literals][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      if has_terminal?('\G[a-zA-Z0-9]', true, index)
        r1 = true
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Literals0)
    end

    node_cache[:literals][start_index] = r0

    r0
  end

end

class RegexParser < Treetop::Runtime::CompiledParser
  include Regex
end

