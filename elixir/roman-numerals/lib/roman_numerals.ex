defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number), do: do_numeral(number, [])

  defp do_numeral(num, acc) when num >= 1000, do: do_numeral(num - 1000, [?M | acc])
  defp do_numeral(num, acc) when num >= 0500, do: do_numeral(num - 0500, [?D | acc])
  defp do_numeral(num, acc) when num >= 0100, do: do_numeral(num - 0100, [?C | acc])
  defp do_numeral(num, acc) when num >= 0050, do: do_numeral(num - 0050, [?L | acc])
  defp do_numeral(num, acc) when num >= 0010, do: do_numeral(num - 0010, [?X | acc])
  defp do_numeral(num, acc) when num >= 0005, do: do_numeral(num - 0005, [?V | acc])
  defp do_numeral(num, acc) when num >= 0001, do: do_numeral(num - 0001, [?I | acc])
  defp do_numeral(0, acc), do: subtractive_notation(acc)

  defp additive_notation(iodata) do
    iodata
    |> Enum.reverse()
    |> IO.iodata_to_binary()
  end

  defp subtractive_notation(iodata) do
    iodata
    |> additive_notation()
    |> do_subtractive_notation()
  end

  defp do_subtractive_notation(additive_notation) do
    String.replace(
      additive_notation,
      ~w[DCCCC CCCC LXXXX XXXX VIIII IIII],
      fn
        "DCCCC" -> "CM"
        "CCCC" -> "CD"
        "LXXXX" -> "XC"
        "XXXX" -> "XL"
        "VIIII" -> "IX"
        "IIII" -> "IV"
      end,
      global: false
    )
  end
end
