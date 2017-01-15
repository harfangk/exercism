class SumOfMultiples
  def initialize(*numbers)
    @numbers = eliminate_multiples_of_other_elements(*numbers)
  end

  def to(n)
    result = @numbers.reduce(0) do |memo, elem|
      puts sum_of_multiple_of_elem(n, elem)
      memo += sum_of_multiple_of_elem(n, elem)
    end

    sum_of_duplicates = @numbers.combination(2).reduce(0) do |memo, combination_array|
      puts sum_of_multiple_of_elem(n, combination_array.reduce(:lcm))
      memo += sum_of_multiple_of_elem(n, combination_array.reduce(:lcm))
    end
    
    if (@numbers.combination(3).to_a != []) 
      another_sum_of_duplicates = @numbers.combination(3).reduce(0) do |memo, combination_array|
        memo += sum_of_multiple_of_elem(n, combination_array.reduce(:lcm))
      end
      return result - sum_of_duplicates + another_sum_of_duplicates
    end

    result - sum_of_duplicates
  end

  private
  def eliminate_multiples_of_other_elements(*numbers)
    numbers.reject do |n|
      numbers.find do |m|
        n != m && n % m == 0
      end
    end
  end

  def sum_of_multiple_of_elem(n, elem)
    ((n - 1) / elem) * (((n - 1) / elem) + 1) / 2 * elem
  end
end
