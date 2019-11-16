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

  defp do_new({color, {x, y}}, acc) do
    if color not in @valid_queen_colors do
      raise ArgumentError,
            "Queen color must be in #{inspect(@valid_queen_colors)}, got: #{inspect(color)}"
    end

    if x not in 0..7 or y not in 0..7 do
      raise ArgumentError, "Coordinates must be in 0..7, got: #{inspect({x, y})}"
    end

    if {x, y} in Map.values(acc) do
      raise ArgumentError, "Cannot place a queen on another queen at #{inspect({x, y})}"
    end

    %{acc | color => {x, y}}
  end

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
  end
end
