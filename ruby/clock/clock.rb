module BookKeeping
  VERSION = 2
end

class Clock
  attr_reader :h, :m

  def initialize(h, m)
    set_time(h, m)
  end

  def self.at(h, m)
    Clock.new(h, m)
  end

  def to_s
    converted_h = @h.to_s.rjust(2, '0')
    converted_m = @m.to_s.rjust(2, '0')
    "#{converted_h}:#{converted_m}"
  end

  def ==(y)
    @h == y.h && @m == y.m
  end

  def +(m)
    set_time(@h, @m + m)
    self
  end

  private

  def set_time(h, m)
    new_m = m % 60
    new_h = (h + (m / 60)) % 24
    @h = new_h
    @m = new_m
  end
end
