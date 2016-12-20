module BookKeeping
  VERSION = 1
end

class Phrase
  def initialize(text)
    @text = text
  end

  def word_count
    # Define words that have unaccented alphabet letters, numbers, underscores, 
    # and apostrophe and hyphen when they are used between previously described characters
    # as proper words to be counted.
    proper_words = /\w+['-]\w+|\w+/
    by_comma_and_space = /,\s|,|\s/

    @text.downcase.split(by_comma_and_space).reduce(Hash.new(0)) do |result_hash, word|
      proper_word = word.match(proper_words)[0]
      result_hash[proper_word] += 1
      result_hash
    end
  end
end
