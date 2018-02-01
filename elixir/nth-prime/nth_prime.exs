defmodule Prime do
  @primes_seed [3, 2]

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(n) when n > 2, do: do_nth(n, @primes_seed)
  def nth(n) when n in [1, 2], do: @primes_seed |> Enum.reverse() |> Enum.at(n - 1)

  defp do_nth(n, primes) when n > length(primes) do
    do_nth(n, [next_prime(primes, hd(primes) + 2) | primes])
  end

  defp do_nth(n, primes) when n == length(primes), do: hd(primes)

  defp next_prime(primes, candidate) do
    (is_prime?(candidate, primes) && candidate) || next_prime(primes, candidate + 2)
  end

  defp is_prime?(candidate, primes) do
    !Enum.any?(primes, &(rem(candidate, &1) == 0))
  end
end
