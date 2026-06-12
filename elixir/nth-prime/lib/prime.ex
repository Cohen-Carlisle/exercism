defmodule Prime do
  @primes_seed {2, 3}

  @doc """
  Generates the nth prime.
  """
  @spec nth(pos_integer()) :: pos_integer()
  def nth(n) when is_integer(n) and n > 2, do: do_nth(n, @primes_seed)
  def nth(n) when n in [1, 2], do: elem(@primes_seed, n - 1)

  defp do_nth(n, primes) when n == tuple_size(primes), do: last_elem(primes)
  defp do_nth(n, primes), do: do_nth(n, append(primes, next_prime(primes, last_elem(primes) + 2)))

  defp next_prime(primes, candidate) do
    if is_prime?(candidate, primes) do
      candidate
    else
      next_prime(primes, candidate + 2)
    end
  end

  defp is_prime?(candidate, primes), do: do_is_prime?(candidate, primes, 0, :math.sqrt(candidate))

  defp do_is_prime?(_, primes, i, lim) when elem(primes, i) > lim, do: true
  defp do_is_prime?(candidate, primes, i, _) when rem(candidate, elem(primes, i)) == 0, do: false
  defp do_is_prime?(candidate, primes, i, lim), do: do_is_prime?(candidate, primes, i + 1, lim)

  defp last_elem(tuple), do: elem(tuple, tuple_size(tuple) - 1)
  defp append(tuple, element), do: Tuple.insert_at(tuple, tuple_size(tuple), element)
end
