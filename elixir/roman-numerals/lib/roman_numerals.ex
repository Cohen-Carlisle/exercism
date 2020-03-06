defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number), do: do_numeral(number, "")

  defp do_numeral(num, roman) when num >= 1000, do: do_numeral(num - 1000, roman <> "M")
  defp do_numeral(num, roman) when num >= 0500, do: do_numeral(num - 0500, roman <> "D")
  defp do_numeral(num, roman) when num >= 0100, do: do_numeral(num - 0100, roman <> "C")
  defp do_numeral(num, roman) when num >= 0050, do: do_numeral(num - 0050, roman <> "L")
  defp do_numeral(num, roman) when num >= 0010, do: do_numeral(num - 0010, roman <> "X")
  defp do_numeral(num, roman) when num >= 0005, do: do_numeral(num - 0005, roman <> "V")
  defp do_numeral(num, roman) when num >= 0001, do: do_numeral(num - 0001, roman <> "I")
  defp do_numeral(0, roman), do: to_subtractive_notation(roman)

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
