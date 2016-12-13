module BookKeeping
  VERSION = 4
end

class Complement
  def self.of_dna(dna_strand)
    dna_strand_in_array = dna_strand.each_char.map do |nucleotide|
      case nucleotide
        when 'G'
          'C'
        when 'C'
          'G'
        when 'T'
          'A'
        when 'A'
          'U'
        else
          return ''
      end
    end

    dna_strand_in_array.join
  end
end
