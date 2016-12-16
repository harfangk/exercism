module BookKeeping
  VERSION = 1
end

class Prime
  def self.nth(n)
    if n < 1 || n > 1_000_000
      raise ArgumentError
    end

    prime_counter = 0
    # primes1.txt contains first 1_000_000 prime numbers. 
    # Downloaded from http://primes.utm.edu/lists/small/millions/
    IO.foreach('primes1.txt').with_index do |line, line_num|
      if line_num == 0
        next
      end
      array = line.split(' ')
      array.each do |element|
        prime_counter += 1
        if prime_counter == n
          return element.to_i
        end
      end
    end
  end
end
