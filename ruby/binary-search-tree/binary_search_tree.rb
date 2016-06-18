require 'forwardable'

class Bst
  extend Forwardable
  def_delegators :@root, :data, :left, :right

  def initialize(data)
    @root = Node.new(data)
  end

  def insert(data)
    current_node = @root
    while current_node
      if data <= current_node.data
        if current_node.left
          current_node = current_node.left
        else
          current_node.left = Node.new(data)
          current_node = nil
        end
      else
        if current_node.right
          current_node = current_node.right
        else
          current_node.right = Node.new(data)
          current_node = nil
        end
      end
    end
  end

  class Node
    attr_reader :data
    attr_accessor :left, :right

    def initialize(data)
      @data = data
      @left = nil
      @right = nil
    end
  end
end
