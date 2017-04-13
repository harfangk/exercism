class Array
  def keep(&block)
    result = []
    self.each do |n|
      if block.call(n)
        result << n
      end
    end
    return result
  end

  def discard(&block)
    result = []
    self.each do |n|
      unless block.call(n)
        result << n
      end
    end
    return result
  end
end
