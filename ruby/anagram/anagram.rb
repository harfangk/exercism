module BookKeeping
  VERSION = 2
end

class Anagram
  def initialize(word)
    @word = word
    @char_occurrences = count_char_occurrences(word)
  end

  def match(word_list)
    word_list.select { |w| is_a_match?(w) }
  end

  def count_char_occurrences(word)
    occurrences_hash = Hash.new(0) 
    decapitalized_word = downcase_first_char(word)
    decapitalized_word.each_char { |c| occurrences_hash[c] += 1 }
    occurrences_hash
  end

  def is_a_match?(w)
    @char_occurrences == count_char_occurrences(w) && w != @word && downcase_first_char(w) != @word
  end

  def downcase_first_char(s)
    s[0, 1].downcase + s[1..-1]
  end
end
