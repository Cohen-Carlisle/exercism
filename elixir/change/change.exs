defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(coins, target) do
    coins
    |> Enum.reject(&(&1 > target))
    |> Enum.sort()
    |> Enum.reverse()
    |> do_generate(target, [])
  end

  defp do_generate(_coins, 0, change), do: {:ok, change}

  defp do_generate([biggest_coin | rest_of_coins], target, change) do
    n = div(target, biggest_coin)
    new_change = List.duplicate(biggest_coin, n) ++ change
    new_target = target - n * biggest_coin
    do_generate(rest_of_coins, new_target, new_change)
  end

  defp do_generate([], _target, _change), do: {:error, "cannot change"}
end
