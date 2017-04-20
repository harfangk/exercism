module BookKeeping
  VERSION = 2
end

class Clock
  attr_reader :hour, :minute

  def initialize(hour, minute)
    set_time(hour, minute)
  end

  def self.at(hour, minute)
    Clock.new(hour, minute)
  end

  def to_s
    converted_hour = @hour.to_s.rjust(2, '0')
    converted_minute = @minute.to_s.rjust(2, '0')
    "#{converted_hour}:#{converted_minute}"
  end

  def ==(another_clock)
    @hour == another_clock.hour && @minute == another_clock.minute
  end

  def +(minute)
    set_time(@hour, @minute + minute)
    self
  end

  private

  def set_time(hour, minute)
    new_minute = minute % 60
    new_hour = (hour + (minute / 60)) % 24
    @hour = new_hour
    @minute = new_minute
  end
end
