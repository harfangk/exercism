class Crypto
  def initialize(plaintext)
    @plaintext = plaintext
  end

  def normalize_plaintext
    @plaintext.downcase.gsub(/[^a-z\d]/, "")
  end

  def size
    Math.sqrt(normalize_plaintext.length).ceil
  end

  def plaintext_segments
    normalize_plaintext.scan(/.{1,#{size}}/)
  end

  def ciphertext
    ciphertext_segments.join
  end

  def normalize_ciphertext
    ciphertext_segments.join(' ')
  end

  def justified_plaintext_segments
    plaintext_segments.map do |s|
      s.ljust(size)
    end
  end

  def ciphertext_segments
    justified_plaintext_segments.map(&:chars).transpose.map(&:join).map(&:strip)
  end
end
