defmodule ResistorColor do
  @moduledoc false

  @spec colors() :: list(atom())
  def colors do
    ~w(black brown red orange yellow green blue violet grey white)a
  end

  @spec code(atom()) :: non_neg_integer() | nil
  def code(color) do
    Enum.find_index(colors(), &color == &1)
  end
end
