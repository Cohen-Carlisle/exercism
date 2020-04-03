defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(list), do: do_count(list, 0)

  defp do_count([_head | tail], acc), do: do_count(tail, acc + 1)
  defp do_count([], acc), do: acc

  @spec reverse(list) :: list
  def reverse(list), do: do_reverse(list, [])

  defp do_reverse([head | tail], acc), do: do_reverse(tail, [head | acc])
  defp do_reverse([], acc), do: acc

  @spec map(list, (any -> any)) :: list
  def map(list, func), do: do_map(list, [], func)

  defp do_map([head | tail], acc, func), do: do_map(tail, [func.(head) | acc], func)
  defp do_map([], acc, _func), do: reverse(acc)

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, func), do: do_filter(list, [], func)

  defp do_filter([head | tail], acc, func) do
    new_acc = if func.(head), do: [head | acc], else: acc
    do_filter(tail, new_acc, func)
  end

  defp do_filter([], acc, _func), do: reverse(acc)

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([head | tail], acc, func), do: reduce(tail, func.(head, acc), func)
  def reduce([], acc, _func), do: acc

  @spec append(list, list) :: list
  def append(left, right), do: do_append(reverse(left), right)

  defp do_append([head | tail], acc), do: do_append(tail, [head | acc])
  defp do_append([], acc), do: acc

  @spec concat(list(list)) :: list
  def concat(list_of_lists), do: reduce(reverse(list_of_lists), [], &append/2)
end
