class Bst
  include Enumerable

  VERSION = 1

  attr_reader :left, :right

  def initialize(value)
    @left = nil
    @right = nil
    @value = value
  end

  def data
    @value
  end

  def each
    if block_given?
      to_a.each { |bst| yield(bst) }
    else
      enum_for(:each)
    end
  end

  def insert(value)
    if value <= @value
      if @left
        @left.insert(value)
      else
        @left = Bst.new(value)
      end
    else
      if @right
        @right.insert(value)
      else
        @right = Bst.new(value)
      end
    end
  end

  def to_a
    do_to_a.flatten.map(&:data)
  end

  def do_to_a
    result = [self]
    if @left
      result = @left.do_to_a + result
    end

    if @right
      result = result + @right.do_to_a
    end

    result
  end
end
