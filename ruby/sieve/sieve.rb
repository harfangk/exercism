module BookKeeping
  VERSION = 1
end

class Sieve
  def initialize(up_to_n)
    @up_to_n = up_to_n
  end

  def primes(target_array = (2..@up_to_n).to_a, result_array = [])
    if @up_to_n < 2
      return result_array
    end

    if target_array.size == 1
      return result_array.concat(target_array)
    end

    prime = target_array.first
    new_result_array = result_array << prime
    remaining_target_array = target_array.reject { |n| n % prime == 0 }
    primes(remaining_target_array, new_result_array)
  end
end
