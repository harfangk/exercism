class Bst
  include Enumerable

  VERSION = 1

  attr_reader :left, :right, :data

  def initialize(data)
    @left = nil
    @right = nil
    @data = data
  end

  def each
    if block_given?
      to_a.each { |bst| yield(bst) }
    else
      enum_for(:each)
    end
  end

  def insert(data)
    if data <= @data
      if @left
        @left.insert(data)
      else
        @left = Bst.new(data)
      end
    else
      if @right
        @right.insert(data)
      else
        @right = Bst.new(data)
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
