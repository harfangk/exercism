class Bob
  def self.hey(remark)
    case
    when is_question?(remark)
      return 'Sure.'
    when is_yell?(remark)
      return 'Whoa, chill out!'
    when is_meaningless?(remark)
      return 'Fine. Be that way!'
    else
      return 'Whatever.'
    end
  end

  # All class methods below are private methods
  def self.is_question?(remark)
    !all_latin_letters_in_upper_case?(remark) && remark.end_with?('?')
  end

  def self.is_yell?(remark)
    all_latin_letters_in_upper_case?(remark) || (!is_mild_suggestion?(remark) && remark.end_with?('!'))
  end

  def self.is_meaningless?(remark)
    remark.strip.empty?
  end

  def self.all_latin_letters_in_upper_case?(remark)
    non_latin_alphabet = /[^[:alpha:]]/
    lower_case_letters = /[a-z]/
    remark_with_latin_alphabet_only = remark.gsub(non_latin_alphabet, "")
    !remark_with_latin_alphabet_only.empty? && !remark_with_latin_alphabet_only.match(lower_case_letters)
  end

  def self.is_mild_suggestion?(remark)
    remark.start_with?("Let's")
  end

  private_class_method :is_question?, :is_yell?, :is_meaningless?, :all_latin_letters_in_upper_case?, :is_mild_suggestion?
end
