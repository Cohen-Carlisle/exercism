defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) when number in 1..64, do: {:ok, do_square(number)}
  def square(_), do: {:error, "The requested square must be between 1 and 64 (inclusive)"}

  defp do_square(number), do: :math.pow(2, number - 1) |> trunc()

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total, do: {:ok, Enum.reduce(1..64, fn x, acc -> do_square(x) + acc end)}
end
