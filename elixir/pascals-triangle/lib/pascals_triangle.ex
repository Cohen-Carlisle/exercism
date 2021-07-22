defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(height) do
    Enum.reverse(do_rows(1, height, []))
  end

  defp do_rows(row_number, height, acc) when row_number > height do
    acc
  end

  defp do_rows(row_number, height, acc) do
    new_acc = [make_row(row_number, List.first(acc)) | acc]
    do_rows(row_number + 1, height, new_acc)
  end

  defp make_row(1, _previous_row) do
    [1]
  end

  defp make_row(row_length, previous_row) do
    even_or_odd = if rem(row_length, 2) == 0, do: :even, else: :odd
    limit = ceil(row_length / 2)
    acc = [1]
    do_make_row(even_or_odd, 1, limit, previous_row, acc)
  end

  defp do_make_row(:even, current_length, limit, _previous_row, acc) when current_length == limit do
    Enum.reverse(acc) ++ acc
  end

  defp do_make_row(:odd, current_length, limit, _previous_row, acc) when current_length == limit do
    Enum.reverse(acc) ++ tl(acc)
  end

  defp do_make_row(even_or_odd, current_length, limit, [x, y | tail], acc) do
    do_make_row(even_or_odd, current_length + 1, limit, [y | tail], [x + y | acc])
  end
end
