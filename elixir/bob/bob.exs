defmodule Bob do
  @doc """
  Responds like a teenager.
  """
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    shouted = shouted?(input)
    question = question?(input)

    cond do
      shouted and question -> "Calm down, I know what I'm doing!"
      shouted -> "Whoa, chill out!"
      question -> "Sure."
      silence?(input) -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end

  defp shouted?(input) do
    Regex.match?(~r/[[:upper:]]/, input) and not Regex.match?(~r/[[:lower:]]/, input)
  end

  defp question?(input) do
    String.ends_with?(input, "?")
  end

  defp silence?(input) do
    String.trim(input) == ""
  end
end
