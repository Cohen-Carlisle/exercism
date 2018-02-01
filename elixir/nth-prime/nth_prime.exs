defmodule Prime do
  @primes_seed {2, 3}

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(n) when n > 2, do: do_nth(n, @primes_seed)
  def nth(n) when n in [1, 2], do: elem(@primes_seed, n - 1)

  defp do_nth(n, primes) when n > tuple_size(primes) do
    do_nth(n, Tuple.append(primes, next_prime(primes, last_elem(primes) + 2)))
  end

  defp do_nth(_n, primes), do: last_elem(primes)

  defp next_prime(primes, candidate) do
    (is_prime?(candidate, primes) && candidate) || next_prime(primes, candidate + 2)
  end

  defp is_prime?(candidate, primes), do: do_is_prime?(candidate, primes, 0, :math.sqrt(candidate))

  defp do_is_prime?(_candidate, primes, i, lim) when elem(primes, i) > lim, do: true

  defp do_is_prime?(candidate, primes, i, lim) do
    (rem(candidate, elem(primes, i)) != 0 && do_is_prime?(candidate, primes, i + 1, lim)) || false
  end

  defp last_elem(tuple), do: elem(tuple, tuple_size(tuple) - 1)
end
