class Anagram
  def initialize(str)
    @original = str.downcase
    @anagram_hash = to_anagram_hash(str)
  end

  def match(str_ary)
    str_ary.select do |str|
      to_anagram_hash(str) == @anagram_hash && !original?(str)
    end
  end

  private

  def to_anagram_hash(str)
    str.downcase.chars.each_with_object(Hash.new(0)) do |char, hash|
      hash[char] += 1
    end
  end

  def original?(str)
    str.downcase == @original
  end
end
