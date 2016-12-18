module BookKeeping
  VERSION = 1
end

class Phrase
  def initialize(text)
    @text = text
  end

  def word_count
    @text.downcase.split(/,\s|,|\s/).reduce(Hash.new(0)) do |result_hash, word|
      cleaned_word = word.gsub(/[\[\]\,!".@#$%^&*();:?-]/, '').gsub(/\A'(.*)'\Z/, '\1')
      result_hash[cleaned_word] += 1
      result_hash
    end
  end
end
