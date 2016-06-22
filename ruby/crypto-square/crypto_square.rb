class Crypto
  def initialize(str)
    @original_message = str
  end

  def normalize_plaintext
    @normalize_plaintext ||= @original_message.gsub(/\W+/, '').downcase
  end

  def size
    @size ||= size_float.ceil
  end

  def plaintext_segments
    @plaintext_segments ||= normalize_plaintext.scan(/.{1,#{size}}/)
  end

  def ciphertext
    @ciphertext ||= preprocessed.transpose.flatten.join
  end

  def normalize_ciphertext
    out = ciphertext.scan(/.{1,#{upper_ciphertext_segment_size}}/)
    min_size = upper_ciphertext_segment_size - 1
    i = -1
    loop do
      segment_size = out[i].size
      break if segment_size >= min_size
      out[i].prepend(out[i-=1].slice!(segment_size-min_size..-1))
    end
    out.join(' ')
  end

  private

  def preprocessed
    return @preprocessed if @preprocessed
    ary_of_chars = plaintext_segments.map { |str| str.chars }
    last_segment = ary_of_chars.last
    last_segment.concat(Array.new(pad(last_segment.size), nil))
    @preprocessed = ary_of_chars
  end

  def size_float
    @size_float ||= Math.sqrt(normalize_plaintext.size)
  end

  def upper_ciphertext_segment_size
    @upper_ciphertext_segment_size ||= [size_float.floor, 2].max
  end

  def pad(last_segment_size=nil)
    @pad ||= size - last_segment_size
  end
end
