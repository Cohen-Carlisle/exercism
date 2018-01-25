defmodule LinkedList do
  defstruct l: nil

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: %LinkedList{}
  def new(), do: %LinkedList{}

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(%LinkedList{}, any()) :: %LinkedList{}
  def push(%LinkedList{} = list, elem), do: %LinkedList{l: {elem, list}}

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(%LinkedList{}) :: non_neg_integer()
  def length(%LinkedList{} = list), do: do_length(list, 0)

  defp do_length(%{l: nil}, length), do: length
  defp do_length(%{l: {_, t}}, length), do: do_length(t, length + 1)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(%LinkedList{}) :: boolean()
  def empty?(%LinkedList{l: nil}), do: true
  def empty?(%LinkedList{}), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(%LinkedList{}) :: {:ok, any()} | {:error, :empty_list}
  def peek(%LinkedList{l: nil}), do: {:error, :empty_list}
  def peek(%LinkedList{l: {h, _}}), do: {:ok, h}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(%LinkedList{}) :: {:ok, %LinkedList{}} | {:error, :empty_list}
  def tail(%LinkedList{l: nil}), do: {:error, :empty_list}
  def tail(%LinkedList{l: {_, t}}), do: {:ok, t}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(%LinkedList{}) :: {:ok, any(), %LinkedList{}} | {:error, :empty_list}
  def pop(%LinkedList{l: nil}), do: {:error, :empty_list}
  def pop(%LinkedList{l: {h, t}}), do: {:ok, h, t}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: %LinkedList{}
  def from_list([]), do: %LinkedList{}
  def from_list([h | t]), do: %LinkedList{l: {h, from_list(t)}}

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(%LinkedList{}) :: list()
  def to_list(%LinkedList{l: nil}), do: []
  def to_list(%LinkedList{l: {h, t}}), do: [h | to_list(t)]

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(%LinkedList{}) :: %LinkedList{}
  def reverse(%LinkedList{} = list), do: do_reverse(list, %LinkedList{})

  defp do_reverse(%{l: nil}, rev), do: rev
  defp do_reverse(%{l: {h, t}}, rev), do: do_reverse(t, %LinkedList{l: {h, rev}})
end
