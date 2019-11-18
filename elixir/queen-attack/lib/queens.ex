defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  @valid_queen_colors [:black, :white]
  defstruct @valid_queen_colors

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new(opts \\ []) do
    Enum.reduce(opts, %__MODULE__{}, &do_new/2)
  end

  defp do_new({color, {row, col}}, acc) do
    validate_color!(color)
    validate_coords_in_range!({row, col})
    validate_coords_unoccupied!({row, col}, acc)

    %{acc | color => {row, col}}
  end

  defp validate_color!(color) do
    if color not in @valid_queen_colors do
      raise ArgumentError,
            "Queen color must be in #{inspect(@valid_queen_colors)}, got: #{inspect(color)}"
    end
  end

  defp validate_coords_in_range!({row, col}) do
    if row not in 0..7 or col not in 0..7 do
      raise ArgumentError, "Coordinates must be in 0..7, got: #{inspect({row, col})}"
    end
  end

  defp validate_coords_unoccupied!(coords, acc) do
    if coords in Map.values(acc) do
      raise ArgumentError, "Cannot place a queen on another queen at #{inspect(coords)}"
    end
  end

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(%Queens{} = queens) do
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%__MODULE__{black: {black_row, black_col}, white: {white_row, white_col}}) do
    black_row == white_row or black_col == white_col or
      abs(black_row - white_row) == abs(black_col - white_col)
  end

  def can_attack?(%__MODULE__{}) do
    false
  end
end
