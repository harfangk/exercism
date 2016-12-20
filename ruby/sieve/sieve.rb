RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
  trace_instruction: false
}

module BookKeeping
  VERSION = 1
end

class Sieve
  def initialize(n)
    @n = n
    @primes = nil 
  end

  def primes
    @primes ||= sieve((2..@n).to_a, [])
  end

  private
  def sieve(target_array = (2..@n).to_a, result_array = [])
    if @n < 2
      return result_array
    end

    if target_array.size == 1
      final_result = result_array.concat(target_array)
      @primes = final_result
      return final_result
    end

    prime = target_array.first
    new_result_array = result_array << prime
    remaining_target_array = target_array.reject { |n| n % prime == 0 }
    sieve(remaining_target_array, new_result_array)
  end
end
