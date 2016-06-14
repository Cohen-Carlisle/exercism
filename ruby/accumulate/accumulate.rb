class Array
  def accumulate(&block)
    each_with_object(self.class.new) { |element, out| out << block[element] }
  end
end
