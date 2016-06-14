class Binary
  VERSION = 2

  def initialize(binary_str)
    @binary_ary = binary_str.reverse.chars.map! do |char|
      binary_char_to_int(char)
    end
  end

  def to_decimal
    power_of_two = -1
    @binary_ary.reduce(0) do |decimal, binary_digit|
      decimal + 2 ** (power_of_two += 1) * binary_digit
    end
  end

  private

  def binary_char_to_int(char)
    raise ArgumentError unless char == '0' || char == '1'
    char.to_i
  end
end
