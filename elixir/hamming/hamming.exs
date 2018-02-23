defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(str1, str2), do: do_hamming_distance(str1, str2, 0)

  defp do_hamming_distance([char1 | tail1], [char2 | tail2], dist) do
    do_hamming_distance(tail1, tail2, dist + ((char1 == char2 && 0) || 1))
  end

  defp do_hamming_distance([], [], dist), do: {:ok, dist}
  defp do_hamming_distance(_, _, _), do: {:error, "Lists must be the same length"}
end
