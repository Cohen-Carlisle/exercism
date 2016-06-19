class Bst
  VERSION = 1

  attr_reader :data
  attr_accessor :left, :right
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def insert(new_data)
    if new_data <= data
      left ? left.insert(new_data) : self.left = self.class.new(new_data)
    else
      right ? right.insert(new_data) : self.right = self.class.new(new_data)
    end
  end

  def each(&block)
    return to_enum unless block_given?
    left && left.each(&block)
    yield data
    right && right.each(&block)
  end
end
