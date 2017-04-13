class PhoneNumber
  attr_accessor :number, :area_code

  def initialize(s)
    if has_invalid_characters(s)
      @number = '0000000000'
      @area_code = '000'
      return
    end

    digit_only_s = s.gsub(/[\D]/, '')

    if has_invalid_length_of_digits(digit_only_s) 
      @number = '0000000000'
      @area_code = '000'
      return
    end

    if has_us_country_code(digit_only_s)
      @number = digit_only_s.slice(1, digit_only_s.length)
    elsif digit_only_s.length == 10
      @number = digit_only_s
    else
      @number = '0000000000'
    end
    @area_code = @number.slice(0, 3)
  end

  def has_invalid_characters(s)
    s =~ /[^\d\.\-\ \(\)]/
  end

  def has_invalid_length_of_digits(s)
    s.length < 10 || s.length > 11
  end

  def has_us_country_code(s)
    s.length == 11 && s[0] == '1'
  end

  def to_s
    middle_numbers = @number.slice(3, 3)
    last_numbers = @number.slice(6, 4)
    "(#{@area_code}) #{middle_numbers}-#{last_numbers}"
  end
end
