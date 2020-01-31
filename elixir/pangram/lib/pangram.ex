defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    char_set = for <<char <- sentence>>, into: MapSet.new(), do: put_lowercase(char)
    MapSet.subset?(MapSet.new(?a..?z), char_set)
  end

  defp put_lowercase(char) when char in ?A..?Z, do: char + 32
  defp put_lowercase(char), do: char
end
