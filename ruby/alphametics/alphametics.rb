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
          chars.each_with_index do |c, index|
            hash[c] = eval("i#{index}")
          end
          int_numbers_to_add = numbers_to_add.map {|s| Alphametics.word_to_number(s, hash) }
          int_result = Alphametics.word_to_number(result, hash)
          if int_numbers_to_add.reduce(:+) == int_result
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
    puts word
    puts word_to_int_hash
    int_array = 
      word.chars.map do |c|
        word_to_int_hash[c]
      end
    int_array.join.to_i
  end
end
