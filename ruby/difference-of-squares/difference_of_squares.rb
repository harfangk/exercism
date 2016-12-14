module BookKeeping
  VERSION = 3
end

class Squares
  def initialize(up_to_n)
    @up_to_n = up_to_n
  end

  def square_of_sum
    (@up_to_n * (@up_to_n + 1) / 2) ** 2
  end

  def sum_of_squares
    if @up_to_n == 0
      return 0
    end
    (1..@up_to_n).map {|n| n ** 2}.reduce(:+)
  end

  def difference
    square_of_sum - sum_of_squares
  end
end
