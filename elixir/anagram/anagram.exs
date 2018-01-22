defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    downcased_base = base |> String.downcase()

    for candidate <- candidates,
        anagram?(downcased_base, candidate |> String.downcase()),
        do: candidate
  end

  defp anagram?(dbase, dcandidate) when dbase == dcandidate, do: false

  defp anagram?(dbase, dcandidate) do
    dbase |> to_charlist() |> Enum.sort() == dcandidate |> to_charlist() |> Enum.sort()
  end
end
