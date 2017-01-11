module BookKeeping
  VERSION = 1
end

class Array
  def accumulate()
    result = Array.new(self.size)
    for i in 0...result.size 
      result[i] = yield(self[i])
    end
    result
  end
end
