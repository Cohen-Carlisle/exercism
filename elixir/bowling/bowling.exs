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

  defp do_normal_frame_rules([[last_roll] | _] = frames, roll) when last_roll < 10 do
    do_spare_try(frames, roll)
  end

  defp do_normal_frame_rules(frames, 10) do
    %Bowling{frames: [["X"] | frames]}
  end

  defp do_normal_frame_rules(frames, roll) do
    %Bowling{frames: [[roll] | frames]}
  end

  defp do_last_frame_rules([["X"] | t], 10) do
    %Bowling{frames: [["X", "X"] | t]}
  end

  defp do_last_frame_rules([["X"] | t], roll) do
    %Bowling{frames: [["X", roll] | t]}
  end

  defp do_last_frame_rules([[_last_roll] | _t] = frames, roll) do
    do_spare_try(frames, roll)
  end

  defp do_last_frame_rules([["X", "X"] | t], 10) do
    %Bowling{frames: [["X", "X", "X"] | t]}
  end

  defp do_last_frame_rules([["X", "X"] | t], roll) do
    %Bowling{frames: [["X", "X", roll] | t]}
  end

  defp do_last_frame_rules([["X", _last_roll] | _t] = frames, roll) do
    do_spare_try(frames, roll)
  end

  defp do_last_frame_rules([[roll1, "/"] | t], 10) do
    %Bowling{frames: [[roll1, "/", "X"] | t]}
  end

  defp do_last_frame_rules([[roll1, "/"] | t], roll) do
    %Bowling{frames: [[roll1, "/", roll] | t]}
  end

  defp do_last_frame_rules(_frames, _roll) do
    {:error, "Cannot roll after game is over"}
  end

  defp do_spare_try([h | t], roll) do
    case List.last(h) + roll do
      sum when sum > 10 -> {:error, "Pin count exceeds pins on the lane"}
      10 -> %Bowling{frames: [h ++ ["/"] | t]}
      _ -> %Bowling{frames: [h ++ [roll] | t]}
    end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """
  @spec score(t()) :: integer | {:error, String.t()}
  def score(%Bowling{} = game) do
    case roll(game, 0) do
      {:error, "Cannot roll after game is over"} ->
        last_frame = hd(game.frames)

        game.frames
        |> Enum.reverse()
        |> List.flatten()
        |> score_normal_frames(length(last_frame), 0)
        |> add_last_frame_score(last_frame)

      _ ->
        {:error, "Score cannot be taken until the end of the game"}
    end
  end

  defp score_normal_frames([_1, _2, _3], 3, score) do
    score
  end

  defp score_normal_frames([_1, _2], 2, score) do
    score
  end

  defp score_normal_frames(["X" | t], last_frame_length, score) do
    new_score = score + 10 + strike_bonus(t)
    score_normal_frames(t, last_frame_length, new_score)
  end

  defp score_normal_frames([roll1, "/" | t], last_frame_length, score) do
    roll2 = 10 - roll1
    new_score = score + roll1 + roll2 + spare_bonus(t)
    score_normal_frames(t, last_frame_length, new_score)
  end

  defp score_normal_frames([roll | t], last_frame_length, score) do
    new_score = score + roll
    score_normal_frames(t, last_frame_length, new_score)
  end

  defp add_last_frame_score(score, ["X" | t]) do
    score + 10 + strike_bonus(t)
  end

  defp add_last_frame_score(score, [_roll1, "/" | t]) do
    score + 10 + spare_bonus(t)
  end

  defp add_last_frame_score(score, frame) do
    score + Enum.sum(frame)
  end

  defp strike_bonus([roll1, roll2 | _]) do
    do_bonus(roll1, roll2)
  end

  defp strike_bonus([roll]) do
    do_bonus(roll)
  end

  defp strike_bonus([]) do
    0
  end

  defp spare_bonus([roll | _]) do
    do_bonus(roll)
  end

  defp spare_bonus([]) do
    0
  end

  defp do_bonus(_roll1, "/") do
    10
  end

  defp do_bonus(roll1, roll2) do
    do_bonus(roll1) + do_bonus(roll2)
  end

  defp do_bonus("X") do
    10
  end

  defp do_bonus(roll) do
    roll
  end
end
