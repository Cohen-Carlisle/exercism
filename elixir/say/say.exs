defmodule Say do
  defguardp is_in_range(n) when n in 1..999_999_999_999

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(0), do: {:ok, "zero"}
  def in_english(n) when is_in_range(n), do: {:ok, do_in_english([], n)}
  def in_english(_), do: {:error, "number is out of range"}

  defp do_in_english(englist, n, thousand_power \\ 3)
  defp do_in_english(englist, _, -1), do: englist |> Enum.reverse() |> Enum.join(" ")

  defp do_in_english(englist, n, thousand_power) do
    thousand_power_multiple = div(n, int_pow(1000, thousand_power))
    hundreds_place = div(thousand_power_multiple, 100)
    tens_and_ones_place = rem(thousand_power_multiple, 100)
    unsaid_n = n - thousand_power_multiple * int_pow(1000, thousand_power)

    englist
    |> maybe_say_hundred(hundreds_place)
    |> maybe_say_less_than_hundred(tens_and_ones_place)
    |> maybe_say_thousand_power_name(thousand_power, thousand_power_multiple)
    |> do_in_english(unsaid_n, thousand_power - 1)
  end

  defp maybe_say_thousand_power_name(englist, 3, mult) when mult > 0, do: ["billion" | englist]
  defp maybe_say_thousand_power_name(englist, 2, mult) when mult > 0, do: ["million" | englist]
  defp maybe_say_thousand_power_name(englist, 1, mult) when mult > 0, do: ["thousand" | englist]
  defp maybe_say_thousand_power_name(englist, _, _), do: englist

  defp maybe_say_hundred(englist, 0), do: englist

  defp maybe_say_hundred(englist, hundreds_place) do
    [say_hundreds_place | _] = maybe_say_less_than_hundred([], hundreds_place)

    ["#{say_hundreds_place} hundred" | englist]
  end

  defp maybe_say_less_than_hundred(englist, 0), do: englist
  defp maybe_say_less_than_hundred(englist, 1), do: ["one" | englist]
  defp maybe_say_less_than_hundred(englist, 2), do: ["two" | englist]
  defp maybe_say_less_than_hundred(englist, 3), do: ["three" | englist]
  defp maybe_say_less_than_hundred(englist, 4), do: ["four" | englist]
  defp maybe_say_less_than_hundred(englist, 5), do: ["five" | englist]
  defp maybe_say_less_than_hundred(englist, 6), do: ["six" | englist]
  defp maybe_say_less_than_hundred(englist, 7), do: ["seven" | englist]
  defp maybe_say_less_than_hundred(englist, 8), do: ["eight" | englist]
  defp maybe_say_less_than_hundred(englist, 9), do: ["nine" | englist]
  defp maybe_say_less_than_hundred(englist, 10), do: ["ten" | englist]
  defp maybe_say_less_than_hundred(englist, 11), do: ["eleven" | englist]
  defp maybe_say_less_than_hundred(englist, 12), do: ["twelve" | englist]
  defp maybe_say_less_than_hundred(englist, 13), do: ["thirteen" | englist]
  defp maybe_say_less_than_hundred(englist, 14), do: ["fourteen" | englist]
  defp maybe_say_less_than_hundred(englist, 15), do: ["fifteen" | englist]
  defp maybe_say_less_than_hundred(englist, 16), do: ["sixteen" | englist]
  defp maybe_say_less_than_hundred(englist, 17), do: ["seventeen" | englist]
  defp maybe_say_less_than_hundred(englist, 18), do: ["eighteen" | englist]
  defp maybe_say_less_than_hundred(englist, 19), do: ["nineteen" | englist]
  defp maybe_say_less_than_hundred(englist, 20), do: ["twenty" | englist]
  defp maybe_say_less_than_hundred(englist, 30), do: ["thirty" | englist]
  defp maybe_say_less_than_hundred(englist, 40), do: ["forty" | englist]
  defp maybe_say_less_than_hundred(englist, 50), do: ["fifty" | englist]
  defp maybe_say_less_than_hundred(englist, 60), do: ["sixty" | englist]
  defp maybe_say_less_than_hundred(englist, 70), do: ["seventy" | englist]
  defp maybe_say_less_than_hundred(englist, 80), do: ["eighty" | englist]
  defp maybe_say_less_than_hundred(englist, 90), do: ["ninety" | englist]

  defp maybe_say_less_than_hundred(englist, n) when n < 100 do
    tens_floor = div(n, 10) * 10
    [say_tens_place | _] = maybe_say_less_than_hundred([], tens_floor)
    ones_place = rem(n, 10)
    [say_ones_place | _] = maybe_say_less_than_hundred([], ones_place)

    ["#{say_tens_place}-#{say_ones_place}" | englist]
  end

  defp int_pow(n, m) when is_integer(n) and is_integer(m), do: trunc(:math.pow(n, m))
end
