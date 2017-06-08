defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(num), do: intro(num) <> all_gifts(num)

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(first :: integer, last :: integer) :: String.t()
  def verses(first, last), do: Enum.map_join(first..last, "\n", &(verse(&1)))

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing():: String.t()
  def sing, do: verses(1, 12)

  @spec intro(number :: integer) :: String.t()
  defp intro(num) do
    "On the #{ordinal(num)} day of Christmas my true love gave to me, "
  end

  @spec ordinal(number :: integer) :: String.t()
  defp ordinal(1),  do: "first"
  defp ordinal(2),  do: "second"
  defp ordinal(3),  do: "third"
  defp ordinal(4),  do: "fourth"
  defp ordinal(5),  do: "fifth"
  defp ordinal(6),  do: "sixth"
  defp ordinal(7),  do: "seventh"
  defp ordinal(8),  do: "eighth"
  defp ordinal(9),  do: "ninth"
  defp ordinal(10), do: "tenth"
  defp ordinal(11), do: "eleventh"
  defp ordinal(12), do: "twelfth"

  @spec gift(number :: integer) :: String.t()
  defp gift(1),  do: "a Partridge in a Pear Tree"
  defp gift(2),  do: "two Turtle Doves"
  defp gift(3),  do: "three French Hens"
  defp gift(4),  do: "four Calling Birds"
  defp gift(5),  do: "five Gold Rings"
  defp gift(6),  do: "six Geese-a-Laying"
  defp gift(7),  do: "seven Swans-a-Swimming"
  defp gift(8),  do: "eight Maids-a-Milking"
  defp gift(9),  do: "nine Ladies Dancing"
  defp gift(10), do: "ten Lords-a-Leaping"
  defp gift(11), do: "eleven Pipers Piping"
  defp gift(12), do: "twelve Drummers Drumming"

  @spec all_gifts(number :: integer) :: String.t()
  defp all_gifts(1), do: gift(1) <> "."
  defp all_gifts(num) do
    num..2
    |> Enum.map_join(", ", &(gift(&1)))
    |> Kernel.<>(", and #{gift(1)}.")
  end
end
