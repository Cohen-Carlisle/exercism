defmodule ResistorColor do
  @moduledoc false

  @spec colors() :: list(String.t())
  def colors do
    ~w(black brown red orange yellow green blue violet grey white)
  end

  @spec code(String.t()) :: non_neg_integer() | nil
  def code(color) do
    Enum.find_index(colors(), &color == &1)
  end
end
