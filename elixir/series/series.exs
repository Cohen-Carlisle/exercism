defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) when size <= 0, do: []
  def slices(s, size), do: do_slices(String.codepoints(s), size)

  defp do_slices(s, size) when length(s) < size, do: []
  defp do_slices(s, size) do
    slice = s
            |> Enum.slice(0..size-1)
            |> Enum.join
    rest = Enum.slice(s, 1..-1)
    [slice | do_slices(rest, size)]
  end
end
