defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) when is_integer(radicand) and radicand > 0 do
    do_calculate(radicand, 0, radicand + 1)
  end

  defp do_calculate(_radicand, min, max) when min == max - 1, do: min

  defp do_calculate(radicand, min, max) do
    mid = div(min + max, 2)
    square = mid * mid

    if square <= radicand do
      do_calculate(radicand, mid, max)
    else
      do_calculate(radicand, min, mid)
    end
  end
end
