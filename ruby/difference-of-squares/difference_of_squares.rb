class Squares
  VERSION = 2

  def initialize(num)
    @one_to_num = 1.upto num
  end

  def square_of_sum
    @one_to_num.reduce(0, :+) ** 2
  end

  def sum_of_squares
    @one_to_num.map { |n| n ** 2 }.reduce(0, :+)
  end

  def difference
    square_of_sum - sum_of_squares
  end
end
