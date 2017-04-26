class RailFenceCipher
  VERSION = 1

  def self.encode(plaintext, rail_rows)
    if rail_rows == 1 || plaintext.empty?
      return plaintext
    end
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
    if rail_rows == 1 || ciphertext.empty?
      return ciphertext
    end
    row_text_length_hash = RailFenceCipher.calculate_length_of_each_row(ciphertext, rail_rows)
    segments = RailFenceCipher.split_ciphertext_to_each_row(ciphertext, row_text_length_hash)
    RailFenceCipher.construct_plaintext_from_ciphertext_segments(segments)
  end

  def self.indices_for_each_rail_row(cycle)
    (0..(cycle-1)).to_a.repeated_combination(2).select do |x, y| 
      (x + y) % cycle == 0
    end.map(&:uniq)
  end

  def self.calculate_length_of_each_row(ciphertext, rail_rows)
    cycle = rail_rows * 2 - 2
    complete_segments_count = ciphertext.length / cycle
    last_segment_length = ciphertext.length % cycle

    hash = Hash.new(0)
    (0..(rail_rows - 1)).each do |row|
      if row == 0 || row == (cycle / 2) 
        hash[row] = complete_segments_count
      else
        hash[row] = complete_segments_count * 2
      end
    end

    (0..(last_segment_length - 1)).each do |row|
      if row <= (cycle / 2)
        hash[row] += 1
      else
        hash[cycle - row] += 1
      end
    end

    hash
  end

  def self.split_ciphertext_to_each_row(ciphertext, row_text_length_hash)
    segments = []
    row_text_length_hash.each do |k, v|
      segment = ciphertext.slice!(0, v)
      segments << segment
    end
    segments
  end

  def self.construct_plaintext_from_ciphertext_segments(segments)
    plaintext = ""
    while (segments.length > 0)
      segments.each_with_index do |str, i|
        if i != segments.length - 1
          plaintext += str.slice!(0,1)
        end
      end
      segments.reverse.each_with_index do |str, i|
        if i != segments.length - 1
          plaintext += str.slice!(0,1)
        end
      end
      segments.delete("")
    end
    plaintext
  end
end
