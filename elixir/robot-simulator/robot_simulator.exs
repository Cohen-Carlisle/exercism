defmodule RobotSimulator do
  @type direction() :: :north | :east | :south | :west
  @type position() :: {x :: integer(), y :: integer()}
  @type robot() :: %RobotSimulator{direction: direction(), position: position()}

  defguardp is_direction(d) when d in [:north, :east, :south, :west]

  defguardp is_position(p)
            when is_tuple(p) and tuple_size(p) == 2 and p |> elem(0) |> is_integer() and
                   p |> elem(1) |> is_integer()

  defstruct direction: :north, position: {0, 0}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction(), position()) :: robot()
  def create do
    %RobotSimulator{}
  end

  def create(direction, position) when is_direction(direction) and is_position(position) do
    %RobotSimulator{direction: direction, position: position}
  end

  def create(_direction, position) when is_position(position) do
    {:error, "invalid direction"}
  end

  def create(direction, _position) when is_direction(direction) do
    {:error, "invalid position"}
  end

  def create(_direction, _position) do
    {:error, "invalid direction and position"}
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot()) :: direction()
  def direction(%RobotSimulator{direction: direction, position: p})
      when is_direction(direction) and is_position(p) do
    direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot()) :: position()
  def position(%RobotSimulator{direction: d, position: position})
      when is_direction(d) and is_position(position) do
    position
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot(), instructions :: String.t()) :: robot()
  def simulate(%RobotSimulator{direction: d, position: p} = robot, instructions)
      when is_direction(d) and is_position(p) and is_binary(instructions) do
    if valid_instructions?(instructions) do
      do_simulate(robot, instructions)
    else
      {:error, "invalid instruction"}
    end
  end

  defp valid_instructions?(instructions) do
    Regex.match?(~r/\A[ALR]*\z/, instructions)
  end

  defp do_simulate(robot, "") do
    robot
  end

  defp do_simulate(%RobotSimulator{direction: d, position: p}, "A" <> rest) do
    do_simulate(%RobotSimulator{direction: d, position: advance(d, p)}, rest)
  end

  defp do_simulate(%RobotSimulator{direction: d, position: p}, "L" <> rest) do
    do_simulate(%RobotSimulator{direction: turn_left(d), position: p}, rest)
  end

  defp do_simulate(%RobotSimulator{direction: d, position: p}, "R" <> rest) do
    do_simulate(%RobotSimulator{direction: turn_right(d), position: p}, rest)
  end

  defp advance(direction, {x, y}) do
    case direction do
      :north -> {x, y + 1}
      :east -> {x + 1, y}
      :south -> {x, y - 1}
      :west -> {x - 1, y}
    end
  end

  defp turn_left(direction) do
    case direction do
      :north -> :west
      :east -> :north
      :south -> :east
      :west -> :south
    end
  end

  defp turn_right(direction) do
    case direction do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
    end
  end
end
