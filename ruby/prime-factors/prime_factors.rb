class PrimeFactors
  def self.for(i)
    if i == 1
      return []
    end

    PrimeFactors.do_for(i, 2, [])
  end

  def self.do_for(i, current_factor, factors)
    if i == current_factor
      return factors << current_factor
    end

    if i % current_factor == 0
      new_factors = factors << current_factor
      new_i = i / current_factor
      do_for(new_i, current_factor, new_factors)
    else
      do_for(i, current_factor + 1, factors)
    end
  end
end
