defmodule LanguageList do
  def new, do: []

  def add(list, language), do: [language | list]

  def remove(list), do: tl(list)

  def first(list), do: hd(list)

  def count(list), do: Enum.count(list)

  def exciting_list?(list), do: Enum.member?(list, "Elixir")
end
