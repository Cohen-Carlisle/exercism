class SumOfMultiples
  def initialize(*nums)
    @nums = nums
  end

  def to(i)
    @nums.each_with_object(Array.new) do |n, multiples|
      n_multiple = n
      while n_multiple < i
        multiples << n_multiple
        n_multiple += n
      end
    end.uniq.reduce(0, :+)
  end
end
