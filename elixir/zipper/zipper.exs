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
  @moduledoc """
  A zipper for binary trees.

  `path` stores the path walked and associated data needed to reconstruct the tree.
  `focus` is the the current node of the tree.
  """
  @type t :: %Zipper{path: list(PathItem.t()), focus: BinTree.t()}
  defstruct [:path, :focus]

  defmodule PathItem do
    @moduledoc """
    An record of an edge traversal.

    `value` is the value of the parent node.
    `left` is the parent's left subtree, or :focus.
    `right` is the parent's right subtree, or :focus.
    either `left` or `right` (but not both) must be :focus.
    :focus indicates the focus of the zipper is the child node for that subtree.
    """
    @type t :: %PathItem{value: any, left: BinTree.t() | nil | :focus, right: BinTree.t() | nil | :focus}
    defstruct [:value, :left, :right]
  end

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(%BinTree{} = tree) do
    %Zipper{path: [], focus: tree}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%Zipper{path: [], focus: tree}) do
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
  @spec value(Zipper.t()) :: any
  def value(%Zipper{focus: %BinTree{value: value}}) do
    value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%Zipper{focus: %BinTree{left: nil}}) do
    nil
  end

  def left(%Zipper{path: path, focus: %BinTree{value: value, left: left, right: right}}) do
    %Zipper{path: [%PathItem{value: value, left: :focus, right: right} | path], focus: left}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%Zipper{focus: %BinTree{right: nil}}) do
    nil
  end

  def right(%Zipper{path: path, focus: %BinTree{value: value, left: left, right: right}}) do
    %Zipper{path: [%PathItem{value: value, left: left, right: :focus} | path], focus: right}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t()
  def up(%Zipper{path: []}) do
    nil
  end

  def up(%Zipper{path: [%PathItem{value: value, left: :focus, right: right} | tail], focus: focus}) do
    %Zipper{path: tail, focus: %BinTree{value: value, left: focus, right: right}}
  end

  def up(%Zipper{path: [%PathItem{value: value, left: left, right: :focus} | tail], focus: focus}) do
    %Zipper{path: tail, focus: %BinTree{value: value, left: left, right: focus}}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(%Zipper{focus: %BinTree{} = focus} = zipper, value) do
    %Zipper{zipper | focus: %BinTree{focus | value: value}}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t()) :: Zipper.t()
  def set_left(%Zipper{} = zipper, %BinTree{} = left), do: do_set_left(zipper, left)
  def set_left(%Zipper{} = zipper, nil), do: do_set_left(zipper, nil)

  defp do_set_left(%Zipper{focus: %BinTree{} = focus} = zipper, left) do
    %Zipper{zipper | focus: %BinTree{focus | left: left}}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t()) :: Zipper.t()
  def set_right(%Zipper{} = zipper, %BinTree{} = right), do: do_set_right(zipper, right)
  def set_right(%Zipper{} = zipper, nil), do: do_set_right(zipper, nil)

  defp do_set_right(%Zipper{focus: %BinTree{} = focus} = zipper, right) do
    %Zipper{zipper | focus: %BinTree{focus | right: right}}
  end
end
