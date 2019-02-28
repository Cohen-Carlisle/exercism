defmodule BinTree do
  import Inspect.Algebra

  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{value: any, left: BinTree.t() | nil, right: BinTree.t() | nil}
  defstruct value: nil, left: nil, right: nil

  # A custom inspect instance purely for the tests, this makes error messages
  # much more readable.
  #
  # BT[value: 3, left: BT[value: 5, right: BT[value: 6]]] becomes (3:(5::(6::)):)
  def inspect(%BinTree{value: v, left: l, right: r}, opts) do
    concat([
      "(",
      to_doc(v, opts),
      ":",
      if(l, do: to_doc(l, opts), else: ""),
      ":",
      if(r, do: to_doc(r, opts), else: ""),
      ")"
    ])
  end
end

defmodule Zipper do
  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t()) :: Z.t()
  def from_tree(%BinTree{} = tree) do
    {[], tree}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t()) :: BT.t()
  def to_tree({[], %BinTree{} = tree}) do
    tree
  end

  def to_tree(zipper) do
    zipper
    |> up()
    |> to_tree()
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t()) :: any
  def value({_, %BinTree{value: value}}) do
    value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t()) :: Z.t() | nil
  def left({_, %BinTree{left: nil}}) do
    nil
  end

  def left({history, %BinTree{value: value, right: right, left: left}}) do
    {[{:left, value, right} | history], left}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t()) :: Z.t() | nil
  def right({_, %BinTree{right: nil}}) do
    nil
  end

  def right({history, %BinTree{value: value, right: right, left: left}}) do
    {[{:right, value, left} | history], right}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t()) :: Z.t()
  def up({[], %BinTree{}}) do
    nil
  end

  def up({[{:left, value, right} | t], %BinTree{} = focus}) do
    {t, %BinTree{value: value, left: focus, right: right}}
  end

  def up({[{:right, value, left} | t], %BinTree{} = focus}) do
    {t, %BinTree{value: value, left: left, right: focus}}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t(), any) :: Z.t()
  def set_value({history, %BinTree{} = focus}, value) do
    {history, %BinTree{focus | value: value}}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t(), BT.t()) :: Z.t()
  def set_left(zipper, %BinTree{} = left), do: do_set_left(zipper, left)
  def set_left(zipper, nil), do: do_set_left(zipper, nil)

  defp do_set_left({history, %BinTree{} = focus}, left) do
    {history, %BinTree{focus | left: left}}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t(), BT.t()) :: Z.t()
  def set_right(zipper, %BinTree{} = right), do: do_set_right(zipper, right)
  def set_right(zipper, nil), do: do_set_right(zipper, nil)

  defp do_set_right({history, %BinTree{} = focus}, right) do
    {history, %BinTree{focus | right: right}}
  end
end
