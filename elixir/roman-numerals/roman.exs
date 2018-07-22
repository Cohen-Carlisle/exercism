defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number), do: do_numerals(number, "")

  defp do_numerals(num, roman) when num >= 1000, do: do_numerals(num - 1000, roman <> "M")
  defp do_numerals(num, roman) when num >= 0500, do: do_numerals(num - 0500, roman <> "D")
  defp do_numerals(num, roman) when num >= 0100, do: do_numerals(num - 0100, roman <> "C")
  defp do_numerals(num, roman) when num >= 0050, do: do_numerals(num - 0050, roman <> "L")
  defp do_numerals(num, roman) when num >= 0010, do: do_numerals(num - 0010, roman <> "X")
  defp do_numerals(num, roman) when num >= 0005, do: do_numerals(num - 0005, roman <> "V")
  defp do_numerals(num, roman) when num >= 0001, do: do_numerals(num - 0001, roman <> "I")
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
