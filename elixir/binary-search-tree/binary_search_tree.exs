Code.load_file("../zipper/zipper.exs", __DIR__)

defmodule BinarySearchTree do
  @doc """
  Create a new Binary Search Tree with root's value as the given 'value'
  """
  @spec new(any()) :: BinTree.t()
  def new(value) do
    %BinTree{value: value}
  end

  @doc """
  Creates and inserts a node with its value as 'value' into the tree.
  """
  @spec insert(BinTree.t(), any()) :: BinTree.t()
  def insert(%BinTree{} = binary_tree, new_value) do
    binary_tree
    |> Zipper.from_tree()
    |> do_insert(new_value)
  end

  defp do_insert(%Zipper{focus: %{value: value, left: left, right: right}} = zipper, new_value) do
    case {new_value <= value, left, right} do
      {true, nil, _} ->
        zipper
        |> Zipper.set_left(BinarySearchTree.new(new_value))
        |> Zipper.to_tree()

      {true, _, _} ->
        zipper
        |> Zipper.left()
        |> do_insert(new_value)

      {false, _, nil} ->
        zipper
        |> Zipper.set_right(BinarySearchTree.new(new_value))
        |> Zipper.to_tree()

      {false, _, _} ->
        zipper
        |> Zipper.right()
        |> do_insert(new_value)
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's value.
  """
  @spec in_order(BinTree.t()) :: list(any())
  def in_order(%BinTree{} = binary_tree) do
    binary_tree # Your implementation here
  end
end
