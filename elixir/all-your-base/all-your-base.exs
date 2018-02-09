defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert(digits, from_base, to_base)
      when length(digits) > 0 and from_base > 1 and to_base > 1 do
    digits
    |> digits_to_integer(from_base)
    |> integer_to_digits(to_base)
  end

  def convert(_digits, _from_base, _to_base), do: nil

  defp digits_to_integer(digits, base) do
    do_digits_to_integer(digits, base, 0)
  end

  defp do_digits_to_integer([digit | tail], base, acc) when digit in 0..(base - 1) do
    do_digits_to_integer(tail, base, acc * base + digit)
  end

  defp do_digits_to_integer([], _base, acc), do: acc
  defp do_digits_to_integer(_digits, _base, _acc), do: nil

  defp integer_to_digits(nil, _base), do: nil
  defp integer_to_digits(int, base), do: do_integer_to_digits(int, base, [])

  defp do_integer_to_digits(0, _base, []), do: [0]
  defp do_integer_to_digits(0, _base, acc), do: acc

  defp do_integer_to_digits(int, base, acc) do
    do_integer_to_digits(div(int, base), base, [rem(int, base) | acc])
  end
end
