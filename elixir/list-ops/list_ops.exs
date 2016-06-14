defmodule ListOps do
  def count(list), do: countr(list, 0)
  defp countr([], total), do: total
  defp countr([_head | tail], total), do: countr(tail, total + 1)

  def reverse(list), do: reverser(list, [])
  defp reverser([], rev_list), do: rev_list
  defp reverser([head | tail], rev_list), do: reverser(tail, [head | rev_list])

  def map([], _func), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def filter([], _func), do: []
  def filter([head | tail], func) do
    if func.(head), do: [head | filter(tail, func)], else: filter(tail, func)
  end

  def reduce([], acc, _func), do: acc
  def reduce([head | tail], acc, func), do: reduce(tail, func.(head, acc), func)

  def append([], list), do: list
  def append([head | tail], list), do: [head | append(tail, list)]

  def concat(list), do: list |> reverse |> reduce([], &append/2)
end
