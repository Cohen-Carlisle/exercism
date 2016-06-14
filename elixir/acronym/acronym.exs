defmodule Acronym do
  def abbreviate(string) do
    string
      |> String.split(" ")
      |> Enum.reduce("", &append_initials/2)
  end

  defp append_initials(str, acc) do
    first_char = str |> String.first |> String.upcase
    other_caps = str |> String.replace(~r/(^.)|[^A-Z]/, "")
    acc <> first_char <> other_caps
  end
end
