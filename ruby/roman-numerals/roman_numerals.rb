module BookKeeping
  VERSION = 2
end

class Integer
  def to_roman
    if self > 3999
      return self
    end

    result = ''

    fourth_digit = self / 1000
    third_digit = (self % 1000) / 100
    second_digit = (self % 100) / 10
    first_digit = self % 10
    
    fourth_digit.times do
      result << 'M'
    end

    case third_digit
    when 9
      result << 'CM'
    when 5..8
      result << 'D'
      (third_digit - 5).times do
        result << 'C'
      end
    when 4
      result << 'CD'
    when 0..3
      third_digit.times do
        result << 'C'
      end
    end

    case second_digit
    when 9
      result << 'XC'
    when 5..8
      result << 'L'
      (second_digit - 5).times do
        result << 'X'
      end
    when 4
      result << 'XL'
    when 0..3
      second_digit.times do
        result << 'X'
      end
    end

    case first_digit
    when 9
      result << 'IX'
    when 5..8
      result << 'V'
      (first_digit - 5).times do
        result << 'I'
      end
    when 4
      result << 'IV'
    when 0..3
      first_digit.times do
        result << 'I'
      end
    end

    return result
  end
end
