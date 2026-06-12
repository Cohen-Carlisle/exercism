defmodule ResistorColorTrio do
  @colors %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    colors
    |> process_first_two_bands()
    |> process_third_band()
  end

  defp process_first_two_bands([color1, color2, color3 | _]) do
    n = 10 * Map.fetch!(@colors, color1) + Map.fetch!(@colors, color2)
    {n, color3}
  end

  defp process_third_band({n, color}) do
    raw_ohms = n * 10 ** Map.fetch!(@colors, color)
    apply_unit(raw_ohms)
  end

  defp apply_unit(ohms) when ohms >= 1_000_000_000, do: {div(ohms, 1_000_000_000), :gigaohms}
  defp apply_unit(ohms) when ohms >= 1_000_000, do: {div(ohms, 1_000_000), :megaohms}
  defp apply_unit(ohms) when ohms >= 1_000, do: {div(ohms, 1_000), :kiloohms}
  defp apply_unit(ohms), do: {ohms, :ohms}
end
