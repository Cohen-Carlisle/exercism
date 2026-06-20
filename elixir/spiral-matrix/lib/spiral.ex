defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(dimension) do
    matrix = :empty |> List.duplicate(dimension) |> List.duplicate(dimension)
    do_matrix(matrix, 1, 0, 0, 1, 0, false)
  end

  defp do_matrix(matrix, n, x, y, dx, dy, just_rotated) do
    case at(matrix, x, y) do
      :empty ->
        do_matrix(put(matrix, x, y, n), n + 1, x + dx, y + dy, dx, dy, false)

      _ when not just_rotated ->
        do_matrix(matrix, n, x - dx - dy, y - dy + dx, -dy, dx, true)

      _ ->
        matrix
    end
  end

  defp at(matrix, x, y) do
    case Enum.at(matrix, y) do
      nil -> nil
      row -> Enum.at(row, x)
    end
  end

  defp put(matrix, x, y, n) do
    new_row = matrix |> Enum.at(y) |> List.replace_at(x, n)
    List.replace_at(matrix, y, new_row)
  end
end
