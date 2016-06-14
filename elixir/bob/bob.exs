defmodule Bob do
  def hey(input) do
    cond do
      input |> silence  -> "Fine. Be that way!"
      input |> shouted  -> "Whoa, chill out!"
      input |> question -> "Sure."
      true              -> "Whatever."
    end
  end

  defp silence(input) do
    String.strip(input) == ""
  end

  defp shouted(input) do
    input =~ ~r/[[:alpha:]]/ && String.upcase(input) == input
  end

  defp question(input) do
    String.ends_with?(input, "?")
  end
end
