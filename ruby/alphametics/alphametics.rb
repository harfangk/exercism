module BookKeeping
  VERSION = 4
end

class Alphametics
  def self.solve(input)
    Alphametics.solve_brute_force(input)
  end

  def self.solve_brute_force(input)
    words = Alphametics.words(input)
    result = words.last
    numbers_to_add = words[0..-2]
    chars = Alphametics.used_chars(input)
    hash = Hash.new(0)
    (0..9).each do |i0|
      (0..9).each do |i1|
        (0..9).each do |i2|
          if (i0 == i1) || (i1 == i2)
            next
          end
          chars.each_with_index do |c, index|
            hash[c] = eval("i#{index}")
          end
          numbers_to_add_in_int = numbers_to_add.map {|s| Alphametics.word_to_number(s, hash) }
          result_in_int = Alphametics.word_to_number(result, hash)
          if numbers_to_add_in_int.reduce(:+) == result_in_int
            return hash
          end
        end
      end
    end
  end

  def self.used_chars(input)
    input.gsub(/[^\w]/, "").chars.uniq
  end

  def self.words(input)
    input.scan(/\w+/)
  end

  def self.word_to_number(word, word_to_int_hash)
    int_array = 
      word.chars.map do |c|
        word_to_int_hash[c]
      end
    int_array.join.to_i
  end

  def self.candidate_hashes(input)
    chars = Alphametics.used_chars(input)
  end

  def self.predicates(input)
    initial_equation = input.gsub(/=/, "==")

  end

  def self.recurse(chars)
    Alphametics.do_recurse(1, chars)
  end

  def self.do_recurse(current_depth, chars)
    if current_depth == chars.length
      return
    end
  end
end
