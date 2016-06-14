class Series
  def initialize(str)
    @series = str.chars.map! { |n| Integer(n) }
  end

  def slices(num)
    raise ArgumentError, "num must be <= length" if num > @series.length
    @series.each_cons(num).map { |e| e }
  end
end
