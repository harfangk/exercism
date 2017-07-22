require 'date'

class Meetup
  WEEKDAYS = {
    :sunday => 0,
    :monday => 1,
    :tuesday => 2,
    :wednesday => 3,
    :thursday => 4,
    :friday => 5,
    :saturday => 6,
  }

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(weekday, schedule)
    starting_date = starting_date(schedule)
    target_day = WEEKDAYS[weekday]
    
    until starting_date.wday == target_day
      starting_date += 1
    end

    starting_date
  end
  
  def starting_date(schedule)
    case schedule
    when :first then Date.new(@year, @month, 1)
    when :second then Date.new(@year, @month, 8)
    when :third then Date.new(@year, @month, 15)
    when :fourth then Date.new(@year, @month, 22)
    when :teenth then Date.new(@year, @month, 13)
    when :last then Date.new(@year, @month, -7)
    end
  end
end
