class Array
  def keep
    each_with_object(self.class.new) { |e, out| out << e if yield(e) }
  end

  def discard
    keep { |e| !yield(e) }
  end
end
