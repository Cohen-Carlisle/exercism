class Hamming
  VERSION = 1

  def self.compute(arg1, arg2)
    length1 = arg1.length
    raise ArgumentError, 'args must be equal length' if length1 != arg2.length
    (0...length1).select { |i| arg1[i] != arg2[i] }.length
  end
end
