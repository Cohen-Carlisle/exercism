defmodule BirdCount do
  def today([day | _other_days]) do
    day
  end

  def today([]) do
    nil
  end

  def increment_day_count([day | other_days]) do
    [day + 1 | other_days]
  end

  def increment_day_count([]) do
    [1]
  end

  def has_day_without_birds?([0 | _other_days]) do
    true
  end

  def has_day_without_birds?([_day | other_days]) do
    has_day_without_birds?(other_days)
  end

  def has_day_without_birds?([]) do
    false
  end

  def total(list) do
    do_total(list, 0)
  end

  defp do_total([day | other_days], total) do
    do_total(other_days, total + day)
  end

  defp do_total([], total) do
    total
  end

  def busy_days(list) do
    do_busy_days(list, 0)
  end

  defp do_busy_days([day | other_days], count) when day >= 5 do
    do_busy_days(other_days, count + 1)
  end

  defp do_busy_days([_day | other_days], count) do
    do_busy_days(other_days, count)
  end

  defp do_busy_days([], count) do
    count
  end
end
