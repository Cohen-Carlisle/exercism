defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    raise_unless_valid_nucleotide(nucleotide)
    Enum.count(strand, fn(n) ->
      raise_unless_valid_nucleotide(n)
      n == nucleotide
    end)
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    histo = for n <- @nucleotides, into: %{}, do: {n, count(strand, n)}
  end

  defp raise_unless_valid_nucleotide(n) do
    if !Enum.member?(@nucleotides, n) do
      raise ArgumentError
    end
  end
end
