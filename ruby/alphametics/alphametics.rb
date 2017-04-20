module BookKeeping
  VERSION = 4
end

class Alphametics
  def self.solve(input)
    Alphametics.solve_brute_force(input)
  end

  def self.solve_brute_force(input)
    initial_equation = input.gsub(/ = /, ' == ')
    Alphametics.candidate_hashes(input).each do |hash|
      substituted_equation = Alphametics.substitute_chars_with_values(initial_equation, hash)
      if eval substituted_equation
        return hash
      end
    end
    {}
  end

  def self.used_chars(input)
    input.gsub(/[^\w]/, "").chars.uniq
  end

  def self.words(input)
    input.scan(/\w+/)
  end

  def self.substitute_chars_with_values(string, string_to_value_hash)
    substituted_string =
      string.chars.map do |c|
        if string_to_value_hash[c]
          string_to_value_hash[c]
        else
          c
        end
      end
    substituted_string.join
  end

  def self.candidate_hashes(input)
    candidate_hashes = []
    beginning_chars = Alphametics.beginning_chars(input)
    chars = Alphametics.used_chars(input)
    arrays_with_distinct_values = (0..9).to_a.permutation(chars.length)
    arrays_with_distinct_values.each do |values|
      candidate_hash = chars.zip(values).to_h
      if Alphametics.has_no_zero_as_beginning_chars?(candidate_hash, beginning_chars)
        candidate_hashes << candidate_hash
      end
    end
    candidate_hashes
  end

  def self.beginning_chars(input)
    words = Alphametics.words(input)
    words.map { |w| w[0] }
  end

  def self.has_no_zero_as_beginning_chars?(candidate_hash, beginning_chars)
    beginning_chars.each do |c|
      if candidate_hash[c] == 0
        return false
      end
    end
  end
end
