class Bst
  attr_reader :data
  attr_accessor :left, :right
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def insert(new_data)
    current_node = self
    while current_node
      if new_data <= current_node.data
        if current_node.left
          current_node = current_node.left
        else
          current_node.left = self.class.new(new_data)
          current_node = nil
        end
      else
        if current_node.right
          current_node = current_node.right
        else
          current_node.right = self.class.new(new_data)
          current_node = nil
        end
      end
    end
  end
end
