defmodule KitchenCalculator do
  @unit_to_ml [
    milliliter: 1,
    cup: 240,
    fluid_ounce: 30,
    teaspoon: 5,
    tablespoon: 15
  ]

  @units Keyword.keys(@unit_to_ml)

  def get_volume({_unit, volume}) do
    volume
  end

  def to_milliliter({unit, volume}) when unit in @units do
    {:milliliter, volume * @unit_to_ml[unit]}
  end

  def from_milliliter({:milliliter, volume}, unit) when unit in @units do
    {unit, volume / @unit_to_ml[unit]}
  end

  def convert(volume_pair, unit) do
    volume_pair |> to_milliliter() |> from_milliliter(unit)
  end
end
