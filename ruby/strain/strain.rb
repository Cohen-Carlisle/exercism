class Array
  def keep
    each_with_object(self.class.new) { |e, out| out << e if yield(e) }
  end

  def discard
    each_with_object(self.class.new) { |e, out| out << e unless yield(e) }
  end
end
