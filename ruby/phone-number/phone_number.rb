class PhoneNumber
  attr_accessor :number, :area_code

  def initialize(s)
    if has_prohibited_characters(s)
      @number = '0000000000'
      @area_code = '000'
      return
    end

    digit_only_s = s.gsub(/[\D]/, '')

    if digit_only_s.length < 10 || digit_only_s.length > 11
      @number = '0000000000'
      @area_code = '000'
      return
    end

    if digit_only_s.length == 11 && digit_only_s[0] == '1'
      @number = digit_only_s.slice(1, digit_only_s.length)
    elsif digit_only_s.length == 10
      @number = digit_only_s
    else
      @number = '0000000000'
    end
    @area_code = @number.slice(0, 3)
  end

  def has_prohibited_characters(s)
    s =~ /[^\d\.\-\ \(\)]/
  end

  def to_s
    middle_numbers = @number.slice(3, 3)
    last_numbers = @number.slice(6, 4)
    "(#{@area_code}) #{middle_numbers}-#{last_numbers}"
  end
end
