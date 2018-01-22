defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    downcased_base = String.downcase(base)

    base_matcher =
      downcased_base
      |> String.codepoints()
      |> Enum.sort()

    index_matches =
      candidates
      |> Enum.map(&String.downcase/1)
      |> Enum.map(&String.codepoints/1)
      |> Enum.map(&Enum.sort/1)
      |> Enum.map(&(base_matcher == &1))

    candidates
    |> Enum.with_index()
    |> Enum.map(&matching_or_nil(&1, index_matches))
    |> Enum.reject(&is_nil/1)
    |> Enum.reject(&(downcased_base == String.downcase(&1)))
  end

  defp matching_or_nil({candidate, index}, index_matches) do
    (Enum.at(index_matches, index) && candidate) || nil
  end
end
