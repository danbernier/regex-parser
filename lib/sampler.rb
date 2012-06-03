class Sampler
  
  def initialize(start)
    @start = start
  end

  def sample(max_length=70)
    node = @start

    chars = []
    while node && max_length > 0
      char, node = node.sample
      chars << char
    end

    chars.join('')
  end

end
