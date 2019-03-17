defmodule Bowling do
  defstruct frames: []
  @type t :: %Bowling{frames: list(list())}

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """
  @spec start() :: t()
  def start, do: %Bowling{}

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """
  @spec roll(t(), integer()) :: t() | {:error, String.t()}
  def roll(%Bowling{frames: [[last_roll] | t]}, roll) when last_roll < 10 do
    %Bowling{frames: [[last_roll, roll] | t]}
  end

  def roll(%Bowling{frames: frames}, roll) do
    %Bowling{frames: [[roll] | frames]}
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """
  @spec score(t()) :: integer | {:error, String.t()}
  def score(%Bowling{} = game) do
    game.frames
    |> Enum.reverse()
    |> Enum.reduce({0, first_roll: 1, second_roll: 1}, fn
      [10], {score, multipliers} ->
        {
          score + 10 * multipliers[:first_roll],
          first_roll: multipliers[:second_roll] + 1, second_roll: 2
        }

      [x, y], {score, multipliers} when x + y == 10 ->
        {
          score + x * multipliers[:first_roll] + y * multipliers[:second_roll],
          first_roll: 2, second_roll: 1
        }

      [x, y], {score, multipliers} ->
        {
          score + x * multipliers[:first_roll] + y * multipliers[:second_roll],
          first_roll: 1, second_roll: 1
        }
    end)
    |> elem(0)
  end
end
