module BookKeeping
  VERSION = 1
end

class Sieve
  def initialize(up_to_n)
    @up_to_n = up_to_n
  end

  def primes
    if @up_to_n < 2
      return []
    end

    find_primes((2..@up_to_n).to_a, [])
  end

  private
  def find_primes(target_array, prime_number_array)
    if target_array.size == 1
      return prime_number_array.concat(target_array)
    end

    prime = target_array.first
    new_prime_number_array = prime_number_array << prime
    remaining_target_array = target_array.reject { |n| n % prime == 0 }
    find_primes(remaining_target_array, new_prime_number_array)
  end
end
