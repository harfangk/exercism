module BookKeeping
  VERSION = 1
end

class Phrase
  def initialize(text)
    @text = text
  end

  def word_count
    by_comma_and_space = /,\s|,|\s/
    punctuations = /[\[\]\,!.@#$%^&*();:?-]/
    surruonding_quotation_marks = /\A'(.*)'\Z/
    @text.downcase.split(by_comma_and_space).reduce(Hash.new(0)) do |result_hash, word|
      cleaned_word = word.gsub(punctuations).gsub(surruonding_quotation_marks, '\1')
      result_hash[cleaned_word] += 1
      result_hash
    end
  end
end
