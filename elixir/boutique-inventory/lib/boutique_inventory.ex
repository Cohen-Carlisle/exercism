defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1[:price]))
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(is_nil(&1[:price])))
  end

  def increase_quantity(item, count) do
    Map.update(
      item,
      :quantity_by_size,
      %{s: count, m: count, l: count, xl: count},
      &(Enum.into(&1, %{}, fn {size, quantity} -> {size, quantity + count} end))
    )
  end

  def total_quantity(%{quantity_by_size: quantity_by_size}) do
    Enum.reduce(quantity_by_size, 0, fn {_sizq, quantity}, total -> total + quantity end)
  end
end
