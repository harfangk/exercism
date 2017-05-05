class Nucleotide
  VALID_NUCLEOTIDES = ['A', 'T', 'C', 'G']

  def initialize(dna)
    @dna = dna
  end

  def self.from_dna(dna)
    validate_dna(dna)
    new(dna)
  end

  def self.validate_dna(dna)
    dna.each_char do |c|
      unless VALID_NUCLEOTIDES.include?(c)
        raise ArgumentError
      end
    end
  end

  def count(nucleotide)
    @dna.chars.select {|c| c == nucleotide}.count
  end

  def histogram
    nucleotides = VALID_NUCLEOTIDES.product([0]).to_h
    @dna.each_char do |c|
      nucleotides[c] += 1
    end
    nucleotides
  end
end
