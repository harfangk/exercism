module BookKeeping
  VERSION = 3
end

class Binary
  require 'set'
  
  def self.to_decimal(string)
    result = 0
    string.each_char.reverse_each.each_with_index do |number, digit|
      validate_number(number)
      result += number.to_i * (2 ** digit)
    end
    result
  end

  def self.validate_number(n)
    valid_numbers = Set.new(['0', '1'])
    unless valid_numbers.include? n
      raise ArgumentError
    end
  end

  private_class_method :validate_number
end
