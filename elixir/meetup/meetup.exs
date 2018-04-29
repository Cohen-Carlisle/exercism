defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(year :: integer, month :: 1..12, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule)
      when schedule in [:first, :second, :third, :fourth] do
    target_dow = day_of_week(weekday)

    first_dow_in_month = Calendar.ISO.day_of_week(year, month, 1)
    days_until_first_target_dow = Integer.mod(target_dow - first_dow_in_month, 7)

    schedule_index = schedule_index(schedule)

    day = 1 + days_until_first_target_dow + schedule_index * 7

    {year, month, day}
  end

  def meetup(year, month, weekday, :last) do
    target_dow = day_of_week(weekday)

    days_in_month = Calendar.ISO.days_in_month(year, month)
    last_dow_in_month = Calendar.ISO.day_of_week(year, month, days_in_month)
    days_after_last_target_dow_in_month = Integer.mod(last_dow_in_month - target_dow, 7)

    day = days_in_month - days_after_last_target_dow_in_month

    {year, month, day}
  end

  def meetup(year, month, weekday, :teenth) do
    target_dow = day_of_week(weekday)

    dow_of_13th = Calendar.ISO.day_of_week(year, month, 13)
    days_until_target_dow_after_13th = Integer.mod(target_dow - dow_of_13th, 7)

    day = 13 + days_until_target_dow_after_13th

    {year, month, day}
  end

  defp day_of_week(:monday), do: 1
  defp day_of_week(:tuesday), do: 2
  defp day_of_week(:wednesday), do: 3
  defp day_of_week(:thursday), do: 4
  defp day_of_week(:friday), do: 5
  defp day_of_week(:saturday), do: 6
  defp day_of_week(:sunday), do: 7

  defp schedule_index(:first), do: 0
  defp schedule_index(:second), do: 1
  defp schedule_index(:third), do: 2
  defp schedule_index(:fourth), do: 3
end
