defmodule ListOps do
  def count(list), do: do_count(list, 0)

  defp do_count([_h | t], total), do: do_count(t, total + 1)
  defp do_count([], total), do: total

  def reverse(list), do: do_reverse(list, [])

  defp do_reverse([h | t], acc), do: do_reverse(t, [h | acc])
  defp do_reverse([], acc), do: acc

  def map(list, func), do: do_map(list, [], func)

  def do_map([h | t], acc, func), do: do_map(t, [func.(h) | acc], func)
  def do_map([], acc, _func), do: reverse(acc)

  def filter(list, func), do: do_filter(list, [], func)

  defp do_filter([h | t], acc, func), do: do_filter(t, (func.(h) && [h | acc]) || acc, func)
  defp do_filter([], acc, _func), do: reverse(acc)

  def reduce([h | t], acc, func), do: reduce(t, func.(h, acc), func)
  def reduce([], acc, _func), do: acc

  def append(list1, list2), do: list1 |> reverse() |> do_append(list2)

  defp do_append([h | t], list), do: do_append(t, [h | list])
  defp do_append([], list), do: list

  def concat(list), do: list |> reverse() |> reduce([], &append/2)
end
