class Palindromes
  def initialize(**factors)
    @max_factor = factors[:max_factor]
    @min_factor = factors[:min_factor] || 1
    @palindrome_products = []
  end

  def self.is_palindrome?(num)
    digits = num.to_s.chars.map(&:to_i)
    first_half = digits.slice(0, digits.length / 2)
    second_half = digits.slice(digits.length.fdiv(2).ceil, digits.length)
    first_half == second_half.reverse
  end

  def generate
    palindrome_hash = Hash.new()
    factors = (@min_factor..@max_factor).to_a
    combinations = factors.product(factors)
    combinations.each do |c|
      product = c.reduce(&:*)
      if Palindromes.is_palindrome?(product)
        palindrome_hash[product] ||= PalindromeProduct.new(product)
        palindrome_hash[product].product_factors << c
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
  include Comparable

  attr_reader :value
  attr_accessor :product_factors

  def initialize(value)
    @value = value
    @product_factors = []
  end

  def <=>(another)
    value <=> another.value
  end

  def factors
    @product_factors.map(&:sort).uniq
  end
end

# 1. Get the range of factos
# 2. Get pairs of factors
# 3. Multiply the pairs and check for palindromic number
# 4. If palindromic number, store the pair; else, discard it.
#
# * Pairs that produce previously produced palindromic number should be added
# to the factors of that palindromic number
