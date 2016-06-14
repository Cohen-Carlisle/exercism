class Trinary
  def initialize(str)
    @str = str
  end

  def to_decimal
    return 0 if @str =~ /[^012]/
    @str.chars.reverse!.each_with_index.reduce(0) do |decimal, (digit, index)|
      decimal + digit.to_i * 3 ** index
    end
  end
end
