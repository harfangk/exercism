class Hexadecimal
  attr_accessor :hex_code
  
  HEX_DEC_TABLE = {
    '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
    '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9,
    'a' => 10, 'b' => 11, 'c' => 12, 'd' => 13, 'e' => 14,
    'f' => 15,
  }

  def initialize(s)
    @hex_code = s
  end

  def to_decimal
    result = 0
    hex_code.chars.reverse.each_with_index do |c, i|
      case HEX_DEC_TABLE[c]
      when nil
        return 0
      else
        result += HEX_DEC_TABLE[c] * (16 ** i)
      end
    end
    result
  end
end
