class Grains
  def self.square(at = n)
    2 ** (at - 1)
  end

  def self.total(base = 2, max_exponent = 64)
    (1 - base ** max_exponent) / (1 - base)
  end
end
