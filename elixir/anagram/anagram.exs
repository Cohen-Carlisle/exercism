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

    downcased_candidates = Enum.map(candidates, &String.downcase/1)

    index_matches? =
      downcased_candidates
      |> Enum.map(&String.codepoints/1)
      |> Enum.map(&Enum.sort/1)
      |> Enum.map(&(base_matcher == &1))

    candidates
    |> Enum.with_index()
    |> Enum.map(&matching_or_nil(&1, index_matches?))
    |> Enum.reject(&nil_or_base_word?(&1, downcased_base, downcased_candidates))
    |> Enum.map(fn {candidate, _index} -> candidate end)
  end

  defp matching_or_nil({_candidate, index} = tuple, index_matches?) do
    (Enum.at(index_matches?, index) && tuple) || {nil, index}
  end

  defp nil_or_base_word?({candidate, index}, downcased_base, downcased_candidates) do
    is_nil(candidate) || Enum.at(downcased_candidates, index) == downcased_base || false
  end
end
