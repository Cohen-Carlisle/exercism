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
    case preprocess(raw_isbn) do
      {:ok, :isbn_10, digits, check} ->
        check == calculate_isbn_10_check(digits)

      {:ok, :isbn_13, digits, check} ->
        check == calculate_isbn_13_check(digits)

      :error ->
        false
    end
  end

  def isbn_10_to_13(raw_isbn) when is_binary(raw_isbn) do
    case preprocess(raw_isbn) do
      {:ok, :isbn_10, digits, _check} ->
        isbn_13_digits = prepend_gs1_prefix(digits)
        check = isbn_13_digits |> calculate_isbn_13_check() |> int_to_check(13)
        isbn_13 = Enum.join(isbn_13_digits) <> check

        {:ok, isbn_13}

      {:ok, :isbn_13, _digits, _check} ->
        {:error, :valid_isbn_13}

      :error ->
        {:error, :invalid_isbn}
    end
  end

  defp preprocess(raw_isbn) do
    isbn = String.replace(raw_isbn, "-", "")

    cond do
      Regex.match?(~r/^\d{9}[\dX]$/, isbn) ->
        {digits, check} = preprocess_isbn(isbn)
        {:ok, :isbn_10, digits, check}

      Regex.match?(~r/^\d{13}$/, isbn) ->
        {digits, check} = preprocess_isbn(isbn)
        {:ok, :isbn_13, digits, check}

      true ->
        :error
    end
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

  defp int_to_check(10, 10) do
    "X"
  end

  defp int_to_check(10, 13) do
    "0"
  end

  defp int_to_check(int, _) do
    Integer.to_string(int)
  end

  defp calculate_isbn_10_sum(digits) do
    {sum, _} =
      Enum.reduce(digits, {0, 10}, fn digit, {partial_sum, multiplier} ->
        new_multiplier = multiplier - 1

        {partial_sum + multiplier * digit, new_multiplier}
      end)

    sum
  end

  defp calculate_isbn_13_sum(digits) do
    {sum, _} =
      Enum.reduce(digits, {0, 1}, fn digit, {partial_sum, multiplier} ->
        new_multiplier =
          case multiplier do
            1 -> 3
            3 -> 1
          end

        {partial_sum + multiplier * digit, new_multiplier}
      end)

    sum
  end

  defp calculate_isbn_10_check(digits) do
    sum = calculate_isbn_10_sum(digits)
    11 - rem(sum, 11)
  end

  defp calculate_isbn_13_check(digits) do
    sum = calculate_isbn_13_sum(digits)
    10 - rem(sum, 10)
  end

  defp prepend_gs1_prefix(digits) do
    [9, 7, 8 | digits]
  end
end
