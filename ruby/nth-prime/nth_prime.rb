class Prime
  PRIMES = [2, 3]
  private_constant :PRIMES

  def self.nth(nth)
    raise ArgumentError, 'nth only accepts positive numbers' unless nth > 0
    generate_primes_upto(nth) if PRIMES.length < nth
    PRIMES[nth - 1]
  end

  def self.generate_primes_upto(nth)
    candidate = PRIMES.last + 2
    while PRIMES.length < nth
      PRIMES << candidate if prime?(candidate)
      candidate += 2
    end
  end
  private_class_method :generate_primes_upto

  def self.prime?(candidate)
    limit = Math.sqrt(candidate)
    i = 1
    until PRIMES[i] > limit
      return false if candidate % PRIMES[i] == 0
      i += 1
    end
    true
  end
  private_class_method :prime?
end
