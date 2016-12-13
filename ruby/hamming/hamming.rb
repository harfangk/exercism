module BookKeeping
  VERSION = 3 # Where the version number matches the one in the test.
end

class Hamming
  def self.compute(strand_a, strand_b)
    self.validate_equal_length(strand_a, strand_b)
    strand_a_as_char_array = strand_a.scan(/\w/) 
    strand_b_as_char_array = strand_b.scan(/\w/) 
    [strand_a_as_char_array, strand_b_as_char_array].transpose.reduce(0) do |distance, char_pair|
      char_pair[0] == char_pair[1] ? distance : distance + 1
    end
  end

  private
  def self.validate_equal_length(strand_a, strand_b)
    if strand_a.length != strand_b.length  
      raise ArgumentError 
    end
  end
end
