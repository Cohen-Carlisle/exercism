class Crypto
  def initialize(str)
    @original_message = str
  end

  def normalize_plaintext
    @normalize_plaintext ||= @original_message.gsub(/\W+/, '').downcase
  end

  def size
    @size ||= Math.sqrt(normalize_plaintext.size).ceil
  end

  def plaintext_segments
    @plaintext_segments ||= normalize_plaintext.scan(/.{1,#{size}}/)
  end

  def ciphertext
    @ciphertext ||= preprocessed.transpose.flatten.join
  end

  private

  def preprocessed
    return @preprocessed if @preprocessed
    ary_of_chars = plaintext_segments.map { |str| str.chars }
    last_segment = ary_of_chars.last
    last_segment.concat(Array.new(size - last_segment.size, nil))
    @preprocessed = ary_of_chars
  end
end
