class Series 
  def initialize(s)
    @number = s
  end

  def slices(n)
    if n > @number.length
      raise ArgumentError 
    end

    result = []
    @number.each_char.each_cons(n) {|x| result << x.join}
    result
  end
end
