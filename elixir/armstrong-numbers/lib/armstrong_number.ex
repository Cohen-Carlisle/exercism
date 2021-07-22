defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    number == armstrong(number)
  end

  defp armstrong(number) do
    digits = Integer.digits(number)
    length = length(digits)

    digits
    |> Enum.map(&Integer.pow(&1, length))
    |> Enum.sum()
  end
end
