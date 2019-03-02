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

  alias BinTree, as: BT
  alias Zipper, as: Z
  alias PathItem, as: PI

  @type t :: %Z{path: list(PI.t()), focus: BT.t()}
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
    @type t :: %PI{value: any, left: BT.t() | nil | :focus, right: BT.t() | nil | :focus}
    defstruct [:value, :left, :right]
  end

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t()) :: Z.t()
  def from_tree(%BT{} = tree) do
    %Z{path: [], focus: tree}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t()) :: BT.t()
  def to_tree(%Z{path: [], focus: %BT{} = tree}) do
    tree
  end

  def to_tree(%Z{} = zipper) do
    zipper
    |> up()
    |> to_tree()
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t()) :: any
  def value(%Z{focus: %BT{value: value}}) do
    value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t()) :: Z.t() | nil
  def left(%Z{focus: %BT{left: nil}}) do
    nil
  end

  def left(%Z{path: path, focus: %BT{value: value, left: %BT{} = left, right: right}})
      when is_list(path) do
    %Z{path: [%PI{value: value, left: :focus, right: right} | path], focus: left}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t()) :: Z.t() | nil
  def right(%Z{focus: %BT{right: nil}}) do
    nil
  end

  def right(%Z{path: path, focus: %BT{value: value, left: left, right: %BT{} = right}})
      when is_list(path) do
    %Z{path: [%PI{value: value, left: left, right: :focus} | path], focus: right}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t()) :: Z.t() | nil
  def up(%Z{path: []}) do
    nil
  end

  def up(%Z{path: [%PI{value: value, left: :focus, right: right} | tail], focus: %BT{} = focus}) do
    %Z{path: tail, focus: %BT{value: value, left: focus, right: right}}
  end

  def up(%Z{path: [%PI{value: value, left: left, right: :focus} | tail], focus: %BT{} = focus}) do
    %Z{path: tail, focus: %BT{value: value, left: left, right: focus}}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t(), any) :: Z.t()
  def set_value(%Z{focus: %BT{}} = zipper, value) do
    put_in(zipper.focus.value, value)
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t(), BT.t()) :: Z.t()
  def set_left(%Z{focus: %BT{}} = zipper, %BT{} = left) do
    do_set_left(zipper, left)
  end

  def set_left(%Z{focus: %BT{}} = zipper, nil) do
    do_set_left(zipper, nil)
  end

  defp do_set_left(zipper, left) do
    put_in(zipper.focus.left, left)
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t(), BT.t()) :: Z.t()
  def set_right(%Z{focus: %BT{}} = zipper, %BT{} = right) do
    do_set_right(zipper, right)
  end

  def set_right(%Z{focus: %BT{}} = zipper, nil) do
    do_set_right(zipper, nil)
  end

  defp do_set_right(zipper, right) do
    put_in(zipper.focus.right, right)
  end
end
