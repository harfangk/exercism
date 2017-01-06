module BookKeeping 
  VERSION = 2
end

class RunLengthEncoding
  def self.encode(input) 
    split_by_repeated_characters = input.each_char.chunk { |n| n }
    split_by_repeated_characters.reduce("") do |result, chunked_array|
        if chunked_array[1].size > 1
          result << chunked_array[1].size.to_s
        end
        result << chunked_array[0]
    end
  end

  def self.decode(input)
    compressed_characters_array = input.scan(/\d*\D/)
    compressed_characters_array.reduce("") do |result, comp|
      if comp.length == 1
        result << comp
      else
        count = comp.slice(0, comp.length - 1).to_i
        char = comp.slice(-1)
        result << char * count
      end
    end
  end
end
