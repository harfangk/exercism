class PrimeFactors
  def self.for(n)
    current_n = n
    factors = []
    i = 2

    while i <= current_n
      if current_n % i == 0
        factors << i
        current_n = current_n / i
      else
        if i == 2
          i = 3
        else
          i += 2
        end
      end
    end

    return factors
  end
end
