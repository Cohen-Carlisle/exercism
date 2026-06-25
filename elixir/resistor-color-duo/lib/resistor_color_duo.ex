defmodule ResistorColorDuo do
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value([color1, color2 | _]) do
    10 * code(color1) + code(color2)
  end

  @spec colors() :: list(atom())
  defp colors do
    ~w(black brown red orange yellow green blue violet grey white)a
  end

  @spec code(atom()) :: non_neg_integer() | nil
  defp code(color) do
    Enum.find_index(colors(), &(color == &1))
  end
end
