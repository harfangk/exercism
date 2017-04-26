class RailFenceCipher
  VERSION = 1

  def self.encode(plaintext, rail_rows)
    if rail_rows <= 1 || plaintext.empty?
      return plaintext
    end

    cycle = rail_rows * 2 - 2
    plaintext_segments_by_cycle = plaintext.scan(/.{1,#{cycle}}/)
    char_indices = RailFenceCipher.indices_for_each_rail_row(cycle)
    ciphertext_by_rows = RailFenceCipher.split_plaintext_into_rows(plaintext_segments_by_cycle, char_indices, rail_rows)
    ciphertext_by_rows.join
  end

  def self.decode(ciphertext, rail_rows)
    if rail_rows <= 1 || ciphertext.empty?
      return ciphertext
    end

    row_text_length_hash = RailFenceCipher.calculate_length_of_each_row(ciphertext, rail_rows)
    segments = RailFenceCipher.split_ciphertext_to_each_row(ciphertext, row_text_length_hash)
    RailFenceCipher.construct_plaintext_from_ciphertext_segments(segments)
  end

  def self.indices_for_each_rail_row(cycle)
    all_indices =
      (0...cycle).to_a.repeated_combination(2).select do |x, y| 
        (x + y) % cycle == 0
      end
    all_indices.map(&:uniq)
  end

  def self.split_plaintext_into_rows(plaintext_segments_by_cycle, char_indices, rail_rows)
    (0...rail_rows).map do |row|
      ciphertext_for_row = ""
      plaintext_segments_by_cycle.each do |segment|
        char_indices[row].each do |char_index|
          ciphertext_for_row += segment[char_index] if segment[char_index]
        end
      end
      ciphertext_for_row
    end
  end

  def self.calculate_length_of_each_row(ciphertext, rail_rows)
    cycle = rail_rows * 2 - 2
    complete_segments_count = ciphertext.length / cycle
    last_segment_length = ciphertext.length % cycle

    row_text_length_hash = Hash.new(0)
    (0...rail_rows).each do |row|
      if row == 0 || row == (cycle / 2) 
        row_text_length_hash[row] = complete_segments_count
      else
        row_text_length_hash[row] = complete_segments_count * 2
      end
    end

    (0...last_segment_length).each do |row|
      if row <= (cycle / 2)
        row_text_length_hash[row] += 1
      else
        row_text_length_hash[cycle - row] += 1
      end
    end

    row_text_length_hash
  end

  def self.split_ciphertext_to_each_row(ciphertext, row_text_length_hash)
    row_text_length_hash.values.reduce([]) do |memo, v|
      segment = ciphertext.slice!(0, v)
      memo << segment
    end
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
