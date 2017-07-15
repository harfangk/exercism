module BookKeeping
  VERSION = 1
end

class Say
  attr_reader :question

  NUM_TO_ENGLISH = {
    0 => 'zero', 1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four',
    5 => 'five', 6 => 'six', 7 => 'seven', 8 => 'eight', 9 => 'nine',
    10 => 'ten', 11 => 'eleven', 12 => 'twelve', 13 => 'thirteen', 14 => 'fourteen',
    15 => 'fifteen', 16 => 'sixteen', 17 => 'seventeen', 18 => 'eighteen', 19 => 'nineteen',
    20 => 'twenty', 30 => 'thirty', 40 => 'forty', 50 => 'fifty',
    60 => 'sixty', 70 => 'seventy', 80 => 'eighty', 90 => 'ninety',
  }

  UNITS = {
    1 => 'thousand',
    2 => 'million',
    3 => 'billion',
    4 => 'trillion',
    5 => 'zillion',
  }

  def initialize(question)
    @question = question
  end

  def in_english
    validate_range

    if NUM_TO_ENGLISH[question]
      return NUM_TO_ENGLISH[question]
    end

    numbers_by_thousands = split_question_by_thousands
    numbers_by_thousands.each_with_index.reject { |n, i| n.zero? }. map do |n, i|
      if i > 0
        "#{say_hundreds(n)} #{UNITS[i]}"
      else
        "#{say_hundreds(n)}"
      end
    end.reverse.join(' ')
  end

  def say_hundreds(num)
    if num >= 1000
      raise ArgumentError
    end

    quotient, remainder = num.divmod(100)
    
    if remainder == 0 && quotient > 0
      "#{NUM_TO_ENGLISH[quotient]} hundred"
    elsif quotient > 0
      "#{NUM_TO_ENGLISH[quotient]} hundred #{say_tens(remainder)}"
    else
      say_tens(remainder)
    end
  end

  def say_tens(num)
    if num >= 100
      raise ArgumentError
    end
       
    if NUM_TO_ENGLISH[num].nil?
      quotient, remainder = num.divmod(10)
      "#{NUM_TO_ENGLISH[quotient * 10]}-#{NUM_TO_ENGLISH[remainder]}"
    else
      NUM_TO_ENGLISH[num]
    end
  end

  private

  def validate_range
    if question < 0 || question >= 1_000_000_000_000
      raise ArgumentError
    end
  end

  def split_question_by_thousands
    q = question
    result = []
    while q > 0
      quotient, remainder = q.divmod(1000)
      result << remainder
      q = quotient
    end
    result
  end
end
