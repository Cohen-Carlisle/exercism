defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input), do: Enum.reduce(input, %{}, &do_transform/2)

  defp do_transform({key, [hd | tl]}, acc) do
    new_entry = %{String.downcase(hd) => key}
    do_transform({key, tl}, Map.merge(acc, new_entry))
  end

  defp do_transform({_, []}, acc), do: acc
end
