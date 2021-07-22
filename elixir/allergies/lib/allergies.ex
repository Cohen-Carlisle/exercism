defmodule Allergies do
  use Bitwise

  @allergen_codes [
    eggs: 1,
    peanuts: 2,
    shellfish: 4,
    strawberries: 8,
    tomatoes: 16,
    chocolate: 32,
    pollen: 64,
    cats: 128
  ]

  @allergens @allergen_codes |> Keyword.keys() |> Enum.map(&Atom.to_string/1)

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    Enum.filter(@allergens, &do_allergic_to?(flags, &1))
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) when item in @allergens, do: do_allergic_to?(flags, item)
  def allergic_to?(_flags, _item), do: false

  defp do_allergic_to?(flags, item) do
    item_flag = Keyword.fetch!(@allergen_codes, String.to_existing_atom(item))
    (flags &&& item_flag) == item_flag
  end
end
