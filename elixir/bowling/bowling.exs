defmodule Bowling do
  defstruct frames: []
  @type t :: %Bowling{frames: list(list())}

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """
  @spec start() :: t()
  def start do
    %Bowling{}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """
  @spec roll(t(), integer()) :: t() | {:error, String.t()}
  def roll(%Bowling{}, roll) when not is_integer(roll) do
    {:error, "Roll must be an integer"}
  end

  def roll(%Bowling{}, roll) when roll < 0 do
    {:error, "Negative roll is invalid"}
  end

  def roll(%Bowling{}, roll) when roll > 10 do
    {:error, "Pin count exceeds pins on the lane"}
  end

  def roll(%Bowling{frames: frames}, roll) do
    do_roll(frames, length(frames), roll)
  end

  defp do_roll(frames, frame_count, roll) when frame_count < 10 do
    do_normal_frame_rules(frames, roll)
  end

  defp do_roll(frames, 10, roll) do
    do_last_frame_rules(frames, roll)
  end

  defp do_normal_frame_rules([[last_roll] | t], roll) when last_roll < 10 do
    maybe_pin_count_error(last_roll, roll) || %Bowling{frames: [[last_roll, roll] | t]}
  end

  defp do_normal_frame_rules(frames, roll) do
    %Bowling{frames: [[roll] | frames]}
  end

  defp do_last_frame_rules([[10] | t], roll) do
    %Bowling{frames: [[10, roll] | t]}
  end

  defp do_last_frame_rules([[last_roll] | t], roll) do
    maybe_pin_count_error(last_roll, roll) || %Bowling{frames: [[last_roll, roll] | t]}
  end

  defp do_last_frame_rules([[10, 10] | t], roll) do
    %Bowling{frames: [[10, 10, roll] | t]}
  end

  defp do_last_frame_rules([[10, last_roll] | t], roll) do
    maybe_pin_count_error(last_roll, roll) || %Bowling{frames: [[10, last_roll, roll] | t]}
  end

  defp do_last_frame_rules([[roll1, roll2] | t], roll) when roll1 + roll2 == 10 do
    %Bowling{frames: [[roll1, roll2, roll] | t]}
  end

  defp do_last_frame_rules(_frames, _roll) do
    {:error, "Cannot roll after game is over"}
  end

  defp maybe_pin_count_error(roll1, roll2) when roll1 + roll2 > 10 do
    {:error, "Pin count exceeds pins on the lane"}
  end

  defp maybe_pin_count_error(_roll1, _roll2) do
    nil
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """
  @spec score(t()) :: integer | {:error, String.t()}
  def score(%Bowling{} = game) do
    game.frames
    |> Enum.reverse()
    |> List.flatten()
    |> Enum.reduce({0, first_roll: 1, second_roll: 1}, fn
      [10], {score, multipliers} ->
        {
          score + 10 * multipliers[:first_roll],
          first_roll: multipliers[:second_roll] + 1, second_roll: 2
        }

      [roll1, roll2], {score, multipliers} when roll1 + roll2 == 10 ->
        {
          score + roll1 * multipliers[:first_roll] + roll2 * multipliers[:second_roll],
          first_roll: 2, second_roll: 1
        }

      [roll1, roll2], {score, multipliers} ->
        {
          score + roll1 * multipliers[:first_roll] + roll2 * multipliers[:second_roll],
          first_roll: 1, second_roll: 1
        }
    end)
    |> elem(0)
  end
end
