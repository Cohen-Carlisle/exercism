class Sieve
  def initialize(upto)
    @upto = upto
    @primes = [false, false, true].concat((3..upto).map { |n| n.odd? })
  end

  def primes
    return [] if @upto < 2
    limit = Math.sqrt(@upto)
    (3..limit).each do |n|
      next unless @primes[n]
      m = n ** 2
      i = 2 * n
      while m <= @upto
        @primes[m] = false
        m += i
      end
    end
    @primes.each_with_object([]).with_index { |(is_prime, array), index| array << index if is_prime }
  end
end
