module BookKeeping
  VERSION = 3
end

class Raindrops
  def self.convert(number)
    filter_number_pairs = [[3, 'Pling'], [5, 'Plang'], [7, 'Plong']]

    result_array = filter_number_pairs.map do |factor, string|
      string if number % factor == 0
    end

    result = result_array.join
    result.empty? ? number.to_s : result
  end
end
