class Palindromes
  def initialize(**args)
    @max_factor = args[:max_factor]
    @min_factor = args[:min_factor] || 1
    @palindrome_products = []
  end

  def generate
    palindrome_hash = Hash.new()
    factors = (@min_factor..@max_factor).to_a
    combinations = factors.repeated_combination(2)
    combinations.each do |c|
      product = c.reduce(:*)
      if product.digits == product.digits.reverse
        palindrome_hash[product] ||= PalindromeProduct.new(product)
        palindrome_hash[product].factors << c
      end
    end
    @palindrome_products = palindrome_hash.values.sort
  end

  def largest
    @palindrome_products.last
  end

  def smallest
    @palindrome_products.first
  end
end

class PalindromeProduct
  attr :value, :factors

  def initialize(value)
    @value = value
    @factors = []
  end

  def <=>(another)
    value <=> another.value
  end
end
