class RailFenceCipher
  def self.encode(plaintext, rail_rows)
    cycle = rail_rows * 2 - 2
    plaintext_segments = plaintext.scan(/.{1,#{cycle}}/)
    indices = RailFenceCipher.indices_for_each_rail_row(cycle)
    ciphertext_by_rows =
      (0..(rail_rows - 1)).map do |row|
        row_text = ""
        plaintext_segments.each do |s|
          indices[row].each do |i|
            if s[i]
              row_text += s[i]
            end
          end
        end
        row_text
      end
    ciphertext_by_rows.join
  end

  def self.decode(ciphertext, rail_rows)

  end

  def self.indices_for_each_rail_row(cycle)
    (0..(cycle-1)).to_a.repeated_combination(2).select do |x, y| 
      (x + y) % cycle == 0
    end.map(&:uniq)
  end
end
