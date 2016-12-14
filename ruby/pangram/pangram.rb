require 'set'

module BookKeeping
  VERSION = 3
end

class Pangram
  def self.pangram?(phrase)
    lowercase_alphabet_set = ('a'..'z').to_set
    current_alphabet_set = phrase.downcase.each_char.reduce(lowercase_alphabet_set) do |remaining_alphabet_set, codepoint| 
      remaining_alphabet_set.delete(codepoint)
    end
    current_alphabet_set.size == 0 ? true : false
  end
end
