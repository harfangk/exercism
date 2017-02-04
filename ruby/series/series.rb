class Series 
  def initialize(s)
    @number = s
  end

  def slices(n)
    if n > @number.length
      raise ArgumentError 
    end
  end
end
