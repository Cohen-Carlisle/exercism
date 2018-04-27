defmodule ListOps do
  def count(list), do: do_count(list, 0)

  defp do_count([_h | t], total), do: do_count(t, total + 1)
  defp do_count([], total), do: total

  def reverse(list), do: do_reverse(list, [])

  defp do_reverse([h | t], acc), do: do_reverse(t, [h | acc])
  defp do_reverse([], acc), do: acc

  def map(list, func), do: do_map(list, func, [])

  def do_map([], _func, acc), do: reverse(acc)
  def do_map([h | t], func, acc), do: do_map(t, func, [func.(h) | acc])

  def filter(list, func), do: do_filter(list, func, [])

  defp do_filter([h | t], func, acc), do: do_filter(t, func, func.(h) && [h | acc] || acc)
  defp do_filter([], _func, acc), do: reverse(acc)

  def reduce([h | t], acc, func), do: reduce(t, func.(h, acc), func)
  def reduce([], acc, _func), do: acc

  def append([h | t], list), do: [h | append(t, list)]
  def append([], list), do: list

  def concat(list), do: list |> reverse |> reduce([], &append/2)
end
