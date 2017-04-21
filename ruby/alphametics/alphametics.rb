module BookKeeping
  VERSION = 4
end

class Alphametics
  def self.solve(input)
    Alphametics.solve_brute_force(input)
  end

  def self.solve_brute_force(input)
    initial_equation = input.gsub(/ = /, ' == ')
    hash_of_candidate_values = Alphametics.hash_of_candidate_values(input)
    filtered_hash_of_candidate_values = Alphametics.remove_initial_zero_from_candidate_values(hash_of_candidate_values, input)
    candidate_hashes = Alphametics.construct_hashes_of_candidate_solutions(filtered_hash_of_candidate_values, input)
    candidate_hashes.each do |hash|
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

  def self.beginning_chars(input)
    words = Alphametics.words(input)
    words.map { |w| w[0] }.uniq
  end

  def self.hash_of_candidate_values(input)
    chars = Alphametics.used_chars(input)
    chars.map { |c| [c, (0..9).to_a] }.to_h
  end

  def self.remove_initial_zero_from_candidate_values(hash_of_candidate_values, input)
    beginning_chars = Alphametics.beginning_chars(input)
    beginning_chars.each do |c|
      hash_of_candidate_values[c].delete(0)
    end
    hash_of_candidate_values
  end

  def self.construct_hashes_of_candidate_solutions(hash_of_candidate_values, input)
    chars = Alphametics.used_chars(input)
    array_of_candidate_values = hash_of_candidate_values.values
    head, *rest = array_of_candidate_values
    potential_solutions = head.product(*rest).select { |array| array == array.uniq }
    potential_solutions.map { |s| chars.zip(s).to_h }
  end
end
