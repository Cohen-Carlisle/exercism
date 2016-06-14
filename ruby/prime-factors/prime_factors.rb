module PrimeFactors
  def self.for(n)
    out = []
    m = n
    x = 2
    while m > 1
      if m % x == 0
        out << x
        m /= x
      else
        x += 1
      end
    end
    out
  end
end
