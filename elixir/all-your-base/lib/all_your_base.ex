defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    case validate_input(digits, input_base, output_base) do
      :ok ->
        output_digits = digits |> digits_to_integer(input_base) |> integer_to_digits(output_base)
        {:ok, output_digits}

      error ->
        error
    end
  end

  defp validate_input(_digits, input_base, _output_base) when input_base < 2 do
    {:error, "input base must be >= 2"}
  end

  defp validate_input(_digits, _input_base, output_base) when output_base < 2 do
    {:error, "output base must be >= 2"}
  end

  defp validate_input(digits, input_base, _output_base) do
    if Enum.all?(digits, fn digit -> digit in 0..(input_base - 1) end) do
      :ok
    else
      {:error, "all digits must be >= 0 and < input base"}
    end
  end

  defp digits_to_integer(digits, base) do
    Enum.reduce(digits, 0, fn digit, acc -> acc * base + digit end)
  end

  defp integer_to_digits(0, _base), do: [0]

  defp integer_to_digits(int, base) do
    Stream.unfold(int, fn
      0 -> nil
      n -> {rem(n, base), div(n, base)}
    end)
    |> Enum.to_list()
    |> Enum.reverse()
  end
end
