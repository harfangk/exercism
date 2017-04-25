class Bst
  include Enumerable

  VERSION = 1

  attr_reader :left, :right, :data

  def initialize(data)
    @data = data
  end

  def each(&block)
    return enum_for(:each) unless block_given?

    left.each(&block) if left
    block.call(self.data)
    right.each(&block) if right
    self
  end

  def <=>(other_bst)
    data <=> other_bst.data
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
end
