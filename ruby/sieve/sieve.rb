class Sieve
  def initialize(n)
    @prime = (2..n).each_with_object({}) { |n, h| h[n] = true }
  end

  def primes
    last_possible_prime = @prime.length + 1
    limit = Math.sqrt(last_possible_prime)
    (2..limit).each do |n|
      next unless @prime[n]
      m = n ** 2
      while m <= last_possible_prime
        @prime[m] = false
        m += n
      end
    end
    @prime.select { |_, is_prime| is_prime }.keys
  end
end
