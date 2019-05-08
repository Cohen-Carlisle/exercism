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
      {:ok, digits, check} ->
        do_isbn?(10, digits, check, 0)

      :error ->
        false
    end
  end

  defp preprocess(isbn) do
    if Regex.match?(~r/^\d-?\d{3}-?\d{5}-?[\dX]$/, isbn) do
      isbn
      |> String.replace("-", "")
      |> String.split_at(9)
      |> do_preprocess()
    else
      :error
    end
  end

  defp do_preprocess({digits, check}) do
    {:ok, do_preprocess_digits(digits), do_preprocess_check(check)}
  end

  defp do_preprocess_digits(digits) do
    digits
    |> String.to_integer()
    |> Integer.digits()
  end

  defp do_preprocess_check("X") do
    10
  end

  defp do_preprocess_check(check) do
    String.to_integer(check)
  end

  defp do_isbn?(multiplier, [h | t], check, sum) do
    do_isbn?(multiplier - 1, t, check, sum + multiplier * h)
  end

  defp do_isbn?(_, [], check, sum) do
    rem(check + sum, 11) == 0
  end
end
