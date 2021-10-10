defmodule WineCellar do
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter(cellar, color, opts \\ []) do
    cellar
    |> Keyword.get_values(color)
    |> maybe_filter_by_year(opts[:year])
    |> maybe_filter_by_country(opts[:country])
  end

  defp maybe_filter_by_year(wines, nil) do
    wines
  end

  defp maybe_filter_by_year(wines, target_year) do
    Enum.filter(wines, fn {_, year, _} -> year == target_year end)
  end

  defp maybe_filter_by_country(wines, nil) do
    wines
  end

  defp maybe_filter_by_country(wines, target_country) do
    Enum.filter(wines, fn {_, _, country} -> country == target_country end)
  end
end
