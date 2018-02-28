defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(clist1, clist2), do: do_hamming_distance(clist1, clist2, 0)

  defp do_hamming_distance([c | t1], [c | t2], d), do: do_hamming_distance(t1, t2, d)
  defp do_hamming_distance([_ | t1], [_ | t2], d), do: do_hamming_distance(t1, t2, d + 1)
  defp do_hamming_distance([], [], d), do: {:ok, d}
  defp do_hamming_distance(_, _, _), do: {:error, "Lists must be the same length"}
end
