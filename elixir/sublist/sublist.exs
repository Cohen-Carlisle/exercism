defmodule Sublist do
  def compare(a, b), do: do_compare(sublist?(a, b), sublist?(b, a))

  def sublist?(a, b), do: do_sublist?(a, b, length(a), length(b))

  defp do_sublist?(a, b, la, lb) when la < lb do
    a === Enum.take(b, la) || do_sublist?(a, tl(b), la, lb - 1)
  end
  defp do_sublist?(a, b, la, lb) when la == lb, do: a === b
  defp do_sublist?(_, _, _, _),                 do: false

  defp do_compare(ab, ba)
  defp do_compare(true, true), do: :equal
  defp do_compare(true, _),    do: :sublist
  defp do_compare(_, true),    do: :superlist
  defp do_compare(_, _),       do: :unequal
end
