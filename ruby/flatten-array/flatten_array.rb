class FlattenArray
  VERSION = 1

  def self.flatten(array)
    do_flatten([], array)
  end

  def self.do_flatten(acc, array)
    if array.empty?
      return acc
    end

    head, *tail = array
    case head
    when Array
      do_flatten(do_flatten(acc, head), tail)
    when nil
      do_flatten(acc, tail)
    else
      do_flatten(acc << head, tail)
    end
  end
end
