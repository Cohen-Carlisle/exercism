defmodule Sublist do
  def compare(a, b), do: do_compare(sublist?(a, b), sublist?(b, a))

  def sublist?(a, b) when length(a) < length(b) do
    a === Enum.slice(b, 0, length(a)) || sublist?(a, tl(b))
  end
  def sublist?(a, b) when length(a) == length(b), do: a === b
  def sublist?(_, _), do: false

  defp do_compare(ab, ba)
  defp do_compare(true, true), do: :equal
  defp do_compare(true, _),    do: :sublist
  defp do_compare(_, true),    do: :superlist
  defp do_compare(_, _),       do: :unequal
end
