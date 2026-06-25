defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {non_neg_integer(), :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    colors
    |> process_first_two_bands()
    |> process_third_band()
  end

  defp process_first_two_bands([color1, color2, color3 | _]) do
    n = 10 * code(color1) + code(color2)
    {n, color3}
  end

  defp process_third_band({n, color}) do
    raw_ohms = n * 10 ** code(color)
    apply_unit(raw_ohms)
  end

  defp apply_unit(ohms) when ohms >= 1_000_000_000, do: {div(ohms, 1_000_000_000), :gigaohms}
  defp apply_unit(ohms) when ohms >= 1_000_000, do: {div(ohms, 1_000_000), :megaohms}
  defp apply_unit(ohms) when ohms >= 1_000, do: {div(ohms, 1_000), :kiloohms}
  defp apply_unit(ohms), do: {ohms, :ohms}

  defp code(color) do
    Enum.find_index(
      ~w(black brown red orange yellow green blue violet grey white)a,
      &(color == &1)
    )
  end
end
