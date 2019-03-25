defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) when is_integer(hour) and is_integer(minute) do
    {hour_adjustment, m60} = handle_minute(minute)
    h24 = handle_hour(hour + hour_adjustment)
    %Clock{hour: h24, minute: m60}
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) when is_integer(add_minute) do
    new(hour, minute + add_minute)
  end

  defp handle_minute(minute) when minute >= 0 do
    {div(minute, 60), rem(minute, 60)}
  end

  defp handle_minute(minute) do
    {floor(minute / 60), Integer.mod(minute, 60)}
  end

  defp handle_hour(hour) when hour >= 0 do
    rem(hour, 24)
  end

  defp handle_hour(hour) do
    Integer.mod(hour, 24)
  end
end

defimpl String.Chars, for: Clock do
  def to_string(clock) do
    hh = clock.hour |> Integer.to_string() |> String.pad_leading(2, "0")
    mm = clock.minute |> Integer.to_string() |> String.pad_leading(2, "0")
    "#{hh}:#{mm}"
  end
end
