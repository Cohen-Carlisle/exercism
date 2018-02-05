defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number), do: do_numerals(number, "")

  defp do_numerals(num, roman) when num >= 1000, do: do_numerals(num - 1000, roman <> "M")
  defp do_numerals(num, roman) when num >= 500, do: do_numerals(num - 500, roman <> "D")
  defp do_numerals(num, roman) when num >= 100, do: do_numerals(num - 100, roman <> "C")
  defp do_numerals(num, roman) when num >= 50, do: do_numerals(num - 50, roman <> "L")
  defp do_numerals(num, roman) when num >= 10, do: do_numerals(num - 10, roman <> "X")
  defp do_numerals(num, roman) when num >= 5, do: do_numerals(num - 5, roman <> "V")
  defp do_numerals(num, roman) when num >= 1, do: do_numerals(num - 1, roman <> "I")
  defp do_numerals(0, roman), do: to_subtractive_notation(roman)

  defp to_subtractive_notation(roman) do
    roman
    |> String.replace("DCCCC", "CM")
    |> String.replace("CCCC", "CD")
    |> String.replace("LXXXX", "XC")
    |> String.replace("XXXX", "XL")
    |> String.replace("VIIII", "IX")
    |> String.replace("IIII", "IV")
  end
end
