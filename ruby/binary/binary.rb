module BookKeeping
  VERSION = 3
end

class Binary
  require 'set'
  
  def self.to_decimal(string)
    valid_digits = Set.new(['0', '1'])
    result = 0
    string.each_char.reverse_each.each_with_index do |elem, index|
      unless valid_digits.include? elem
        raise ArgumentError
      end
      result += elem.to_i * (2 ** index)
    end
    result
  end
end
