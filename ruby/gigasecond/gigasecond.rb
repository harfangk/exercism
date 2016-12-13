module BookKeeping
  VERSION = 5
end

class Gigasecond
  def self.from(time)
    time_in_unix = time.to_i
    time_in_unix_after_adding_gigasecond = time_in_unix + 1000000000
    new_time_in_iso = Time.at(time_in_unix_after_adding_gigasecond)
    new_time_in_iso.utc
  end
end
