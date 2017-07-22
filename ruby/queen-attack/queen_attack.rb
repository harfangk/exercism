class Queens
  def initialize(**queens)
    validate_argument(queens)
    @white = queens[:white]
    @black = queens[:black]
  end

  def attack?
    x1, y1 = @white
    x2, y2 = @black
    x1 == x2 || y1 == y2 || (x1 - x2).fdiv(y1 - y2).abs == 1
  end

  def validate_argument(queens)
    queens.each do |k, v|
      x, y = v
      if (x < 0 || x > 7) || (y < 0 || y > 7)
        raise ArgumentError
      end
    end
  end
end

module BookKeeping
  VERSION = 2
end
