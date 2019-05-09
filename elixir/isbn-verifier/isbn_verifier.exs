defmodule ISBNVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) when is_binary(isbn) do
    case preprocess(isbn) do
      {:ok, digits} ->
        {sum, _} = Enum.reduce(digits, {0, 10}, &calc_sum/2)
        rem(sum, 11) == 0

      :error ->
        false
    end
  end

  defp preprocess(isbn) do
    normalized_isbn = String.replace(isbn, "-", "")

    if Regex.match?(~r/^\d{9}[\dX]$/, normalized_isbn) do
      digits = normalized_isbn |> String.codepoints() |> Enum.map(&to_int/1)
      {:ok, digits}
    else
      :error
    end
  end

  defp to_int("X") do
    10
  end

  defp to_int(digit) do
    String.to_integer(digit)
  end

  defp calc_sum(digit, {sum, multiplier}) do
    {sum + multiplier * digit, multiplier - 1}
  end
end
