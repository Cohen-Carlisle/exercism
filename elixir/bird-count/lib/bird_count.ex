defmodule BirdCount do
  def today(list) do
    List.first(list)
  end

  def increment_day_count([]) do
    [1]
  end

  def increment_day_count(list) do
    [hd(list) + 1 | tl(list)]
  end

  def has_day_without_birds?(list) do
    Enum.member?(list, 0)
  end

  def total(list) do
    Enum.sum(list)
  end

  def busy_days(list) do
    Enum.count(list, &(&1 >= 5))
  end
end
