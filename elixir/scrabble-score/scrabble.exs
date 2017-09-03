defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word
    |> String.downcase
    |> String.graphemes
    |> Enum.reduce(0, fn(char, acc) -> acc + do_score(char) end)
  end

  defp do_score("a"), do: 1
  defp do_score("e"), do: 1
  defp do_score("i"), do: 1
  defp do_score("o"), do: 1
  defp do_score("u"), do: 1
  defp do_score("l"), do: 1
  defp do_score("n"), do: 1
  defp do_score("r"), do: 1
  defp do_score("s"), do: 1
  defp do_score("t"), do: 1
  defp do_score("d"), do: 2
  defp do_score("g"), do: 2
  defp do_score("b"), do: 3
  defp do_score("c"), do: 3
  defp do_score("m"), do: 3
  defp do_score("p"), do: 3
  defp do_score("f"), do: 4
  defp do_score("h"), do: 4
  defp do_score("v"), do: 4
  defp do_score("w"), do: 4
  defp do_score("y"), do: 4
  defp do_score("k"), do: 5
  defp do_score("j"), do: 8
  defp do_score("x"), do: 8
  defp do_score("q"), do: 10
  defp do_score("z"), do: 10
  defp do_score(_), do: 0
end
