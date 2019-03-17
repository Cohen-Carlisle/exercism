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
  def roll(%Bowling{frames: [[last_roll] | t]} = game, roll) do
    put_in(game.frames, [[last_roll, roll] | t])
  end

  def roll(%Bowling{frames: frames} = game, roll) do
    put_in(game.frames, [[roll] | frames])
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """
  @spec score(t()) :: integer | {:error, String.t()}
  def score(%Bowling{} = game) do
    game.frames
    |> Enum.reverse()
    |> Enum.reduce(0, fn frame, acc -> acc + Enum.sum(frame) end)
  end
end
