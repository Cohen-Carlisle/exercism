defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna), do: Enum.map(dna, &nucleotide_to_complement/1)

  defp nucleotide_to_complement(?G), do: ?C
  defp nucleotide_to_complement(?C), do: ?G
  defp nucleotide_to_complement(?T), do: ?A
  defp nucleotide_to_complement(?A), do: ?U
end
