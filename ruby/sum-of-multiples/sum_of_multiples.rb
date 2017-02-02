class SumOfMultiples
  def initialize(*numbers)
    @numbers = *numbers
  end

  def to(n)
    @numbers.map {|x| (1...n).find_all {|y| y % x == 0}}.reduce(:|).reduce(0, :+)
  end
end
