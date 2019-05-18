if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("binary_search_tree.exs", __DIR__)
end

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule BinarySearchTreeTest do
  use ExUnit.Case

  test "retains value" do
    assert BinarySearchTree.new(4).value == 4
  end

  @tag :pending
  test "inserting lower number" do
    root =
      BinarySearchTree.new(4)
      |> BinarySearchTree.insert(2)

    assert root.value == 4
    assert root.left.value == 2
  end

  @tag :pending
  test "inserting same number" do
    root =
      BinarySearchTree.new(4)
      |> BinarySearchTree.insert(4)

    assert root.value == 4
    assert root.left.value == 4
  end

  @tag :pending
  test "inserting higher number" do
    root =
      BinarySearchTree.new(4)
      |> BinarySearchTree.insert(5)

    assert root.value == 4
    assert root.right.value == 5
  end

  @tag :pending
  test "complex tree" do
    root =
      BinarySearchTree.new(4)
      |> BinarySearchTree.insert(2)
      |> BinarySearchTree.insert(6)
      |> BinarySearchTree.insert(1)
      |> BinarySearchTree.insert(3)
      |> BinarySearchTree.insert(7)
      |> BinarySearchTree.insert(5)

    assert root.value == 4
    assert root.left.value == 2
    assert root.left.left.value == 1
    assert root.left.right.value == 3
    assert root.right.value == 6
    assert root.right.left.value == 5
    assert root.right.right.value == 7
  end

  @tag :pending
  test "iterating one element" do
    root = BinarySearchTree.new(4)

    assert [4] == BinarySearchTree.in_order(root)
  end

  @tag :pending
  test "iterating over smaller element" do
    root =
      BinarySearchTree.new(4)
      |> BinarySearchTree.insert(2)

    assert [2, 4] == BinarySearchTree.in_order(root)
  end

  @tag :pending
  test "iterating over larger element" do
    root =
      BinarySearchTree.new(4)
      |> BinarySearchTree.insert(5)

    assert [4, 5] == BinarySearchTree.in_order(root)
  end

  @tag :pending
  test "iterating over complex tree" do
    root =
      BinarySearchTree.new(4)
      |> BinarySearchTree.insert(2)
      |> BinarySearchTree.insert(1)
      |> BinarySearchTree.insert(3)
      |> BinarySearchTree.insert(6)
      |> BinarySearchTree.insert(7)
      |> BinarySearchTree.insert(5)

    assert [1, 2, 3, 4, 5, 6, 7] == BinarySearchTree.in_order(root)
  end
end
