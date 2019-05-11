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
  def isbn?(raw_isbn) when is_binary(raw_isbn) do
    isbn = String.replace(raw_isbn, "-", "")

    case preprocess(isbn) do
      {:ok, :isbn_10, digits, check} ->
        {isbn_10_sum, _} = Enum.reduce(digits, {0, 10}, &calc_isbn_10_sum/2)
        rem(isbn_10_sum + check, 11) == 0

      {:ok, :isbn_13, digits, check} ->
        {isbn_13_sum, _} = Enum.reduce(digits, {0, 1}, &calc_isbn_13_sum/2)
        10 - rem(isbn_13_sum, 10) == check

      :error ->
        false
    end
  end

  defp preprocess(isbn_10) when byte_size(isbn_10) == 10 do
    if Regex.match?(~r/^\d{9}[\dX]$/, isbn_10) do
      {digits, check} = preprocess_isbn(isbn_10)
      {:ok, :isbn_10, digits, check}
    else
      :error
    end
  end

  defp preprocess(isbn_13) when byte_size(isbn_13) == 13 do
    if Regex.match?(~r/^\d{13}$/, isbn_13) do
      {digits, check} = preprocess_isbn(isbn_13)
      {:ok, :isbn_13, digits, check}
    else
      :error
    end
  end

  defp preprocess(_isbn) do
    :error
  end

  defp preprocess_isbn(isbn) do
    isbn_length = byte_size(isbn)
    {digits, check} = String.split_at(isbn, isbn_length - 1)
    {digits_to_int_list(digits), check_to_int(check, isbn_length)}
  end

  defp digits_to_int_list(digits) do
    digits
    |> String.to_integer()
    |> Integer.digits()
  end

  defp check_to_int("X", 10) do
    10
  end

  defp check_to_int("0", 13) do
    10
  end

  defp check_to_int(check, _) do
    String.to_integer(check)
  end

  defp calc_isbn_10_sum(digit, {sum, multiplier}) do
    new_multiplier = multiplier - 1

    {sum + multiplier * digit, new_multiplier}
  end

  defp calc_isbn_13_sum(digit, {sum, multiplier}) do
    new_multiplier =
      case multiplier do
        1 -> 3
        3 -> 1
      end

    {sum + multiplier * digit, new_multiplier}
  end
end
