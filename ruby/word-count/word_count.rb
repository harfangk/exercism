module BookKeeping
  VERSION = 1
end

class Phrase
  def initialize(text)
    @text = text
  end

  def word_count
    # A proper word can be a combination of:
    # extended latin alphabet letters, numbers, ', - 
    # e.g. don't, he-who-must-not-be-named, ISO-6689, Khlûl-hloo
    # Words that begin or end with ', i.e. ol', runnin', 'tis, are not covered.
    proper_words = /([A-Za-zÀ-ɏ0-9]+[-']?)*[A-Za-zÀ-ɏ0-9]+/
    by_comma_and_space = /,\s|,|\s/

    @text.downcase.split(by_comma_and_space).reduce(Hash.new(0)) do |result_hash, word|
      proper_word = word.match(proper_words)[0]
      result_hash[proper_word] += 1
      result_hash
    end
  end
end
