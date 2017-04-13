module BookKeeping
  VERSION = 1
end

class Trinary
  def initialize(s)
    @s = s
  end

  def to_decimal
    if is_invalid_number?
      return 0
    end
    reversed_digits = @s.split("").map(&:to_i).reverse
    reversed_digits.each_with_index.reduce(0) do |memo, (e, i)|
      memo = memo + (e * (3 ** i)) 
    end
  end

  def is_invalid_number?
    @s =~ /[^012]/
  end
end
