class PrimeFactors
  def self.for(n)
    if n == 1
      return []
    end

    current_n = n
    factors = []
    i = 2

    while i == 2
      if current_n % i == 0
        factors << i
        current_n = current_n / i
      else
        i = 3
      end
    end

    while i <= current_n
      if current_n % i == 0
        factors << i
        current_n = current_n / i
      else
        i += 2
      end
    end
    return factors
  end
end
