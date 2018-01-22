defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    comparable_base = to_comparable(base)

    for candidate <- candidates,
        anagram?(comparable_base, to_comparable(candidate)),
        do: candidate
  end

  defp to_comparable(string) do
    downcased = string |> String.downcase()
    charlist = downcased |> to_charlist() |> Enum.sort()
    {downcased, charlist}
  end

  defp anagram?({downcased_base, _}, {downcased_candidate, _})
       when downcased_base == downcased_candidate,
       do: false

  defp anagram?({_, base_charlist}, {_, candidate_charlist})
       when base_charlist == candidate_charlist,
       do: true

  defp anagram?(_, _), do: false
end
