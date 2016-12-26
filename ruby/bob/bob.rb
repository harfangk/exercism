class Bob
  def self.hey(remark)
    if is_question?(remark)
      return 'Sure.'
    elsif is_yell?(remark)
      return 'Whoa, chill out!'
    elsif is_meaningless?(remark)
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
    (remark.end_with?('!') && !remark.start_with?("Let's")) || all_latin_letters_in_upper_case?(remark)
  end

  def self.is_meaningless?(remark)
    remark_without_blank_characters = remark.gsub(/[[:blank:]]/, "")
    remark_without_blank_characters.empty?
  end

  def self.all_latin_letters_in_upper_case?(remark)
    non_latin_alphabet = /[^[:alpha:]]/
    lower_case_letters = /[a-z]/
    remark_with_latin_alphabet_only = remark.gsub(non_latin_alphabet, "")
    remark_has_upper_case_only = !!!remark_with_latin_alphabet_only.match(lower_case_letters)
    !remark_with_latin_alphabet_only.empty? && remark_has_upper_case_only
  end

  private_class_method :is_question?, :is_yell?, :is_meaningless?, :all_latin_letters_in_upper_case?
end
