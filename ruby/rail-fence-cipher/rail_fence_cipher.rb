class RailFenceCipher
  VERSION = 1

  class << self
    def encode(plaintext, rails_count)
      if rails_count <= 1 || plaintext.empty?
        return plaintext
      end

      encoding_table = encoding_table(plaintext, rails_count)

      plaintext.chars.each_with_index.map do |c, i|
        ciphertext_index = encoding_table[i]
        plaintext[ciphertext_index]
      end.join
    end

    def decode(ciphertext, rails_count)
      if rails_count <= 1 || ciphertext.empty?
        return ciphertext
      end

      decoding_table = decoding_table(ciphertext, rails_count)

      ciphertext.chars.each_with_index.map do |c, i|
        plaintext_index = decoding_table[i]
        ciphertext[plaintext_index]
      end.join
    end

    private

    def encoding_table(str, rails_count)
      cycle = cycle(rails_count)
      char_indices_per_rail = Array.new(rails_count) { Array.new }
      (0...str.length).each do |char_index|
        index_in_cycle = char_index % [1, cycle].max
        rail_row = index_in_cycle < rails_count ? index_in_cycle : cycle - index_in_cycle
        char_indices_per_rail[rail_row] << char_index
      end
      encoding_table_hash = (0...str.length).to_a.zip(char_indices_per_rail.flatten).to_h
      encoding_table_hash 
    end

    def decoding_table(str, rails_count)
      encoding_table(str, rails_count).invert
    end

    def cycle(rails_count)
      rails_count * 2 - 2
    end
  end
end
