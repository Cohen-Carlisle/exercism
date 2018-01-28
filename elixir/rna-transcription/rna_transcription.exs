defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna([]), do: []
  def to_rna([?G | tail]), do: [?C | to_rna(tail)]
  def to_rna([?C | tail]), do: [?G | to_rna(tail)]
  def to_rna([?T | tail]), do: [?A | to_rna(tail)]
  def to_rna([?A | tail]), do: [?U | to_rna(tail)]
end
